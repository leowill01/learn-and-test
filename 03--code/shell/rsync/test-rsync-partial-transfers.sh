# testing rsync partial transfers

cd ~/Desktop/work--tmp

src="/Volumes/Pursell-Lab-HD/Pursell-lab/01--raw-data"
dest="/Users/leo/Desktop/work--tmp/01--raw-data--RSYNC-DEST"

# TEST BASIC COMMAND ################
	# try simple transfers
	rsync -avP "$src"/ "$dest"/
	# notes: cmd includes '--partial': for large files, this command will copy file into tmp hidden file. if cmd is stopped, it will write this tmp file to an actual file that will be incomplete up to where it was stopped. when cmd is run again, it will pick up where transfer left off into a new tmp file. if cmd is interrupted again, it will append this new tmp chunk to the existing partial real file. it keeps doing this until the entire actual file is complete.
	# speed on mac ssd: 120MB/s

	# add more readable output
	rsync -avP --stats --itemize-changes --human-readable "$src"/ "$dest"/

# TEST PARTIAL TRANSFERS ################
	# what does specifying '--partial-dir' do?
	rsync -avP --partial-dir="_rsync-partial" "$src"/ "$dest"/
	# notes:
	# 1: instead of appending the new chunk to the real file, this makes a partial dir in the same dir as the file being transferred, and within that it stores the partial *chunk* as a real file. i will finish running the command and see if this partial real chunk gets appended to the incomplete real file made so far by the previous command
	# notes 2: it seems to be recopying the entire file into the partial dir. so it seems that using '--partial-dir' after using a command that only had '--partial' does not pick up the partial file.
	# 3: one time after interripting, it started the entire file over again and the tmp partial dir file size did not change? not sure what happened there
	# 4: doing what i saw in (3) again. before: partial dir file = 10.18GB; during transfer = copying all the way, stopped @ 72%, 8.14GB (src file is 11.18GB); end after interrupt = partial dir file is still 10.18GB?? but the partial dir file timestamp kept updating even though the size didnt
	# 5: started it again and let it run until finished. before partial dir file = 10.18GB, partial real file = 9.59GB ;; ran from 0-100% @ 120MB/s ;; end = 11.18GB - same as src file, partial dir removed, previous partial real (no partial dir) file overwritten
	# 6: revisited: when starting off using a '--partial-dir' without previous only '--partial', when resuming transfer after an interruption, it picks up on the partial file in the partial dir and starts appending to it

# TEST INCLUDE/EXCLUDES ################
	# only sync a specific type of file
	# pre-notes: '--include' is not all-encompassing; it means more of "don't exclude" rather than a strict "include" (see https://stackoverflow.com/questions/11111562/rsync-copy-over-only-certain-types-of-files-using-include-option). 
	# '--exclude' MUST COME LAST
	# '--prune-empty-dirs'/'-m' makes sure no empty directories are copied - only those in the hierarchy that the included files exist in
	rsync -avP --stats --itemize-changes --human-readable \
	--include='*/' \
	--include='*.bam' \
	--exclude='*' \
	--prune-empty-dirs \
	--partial-dir="_rsync-partial"  \
	"$src"/ "$dest"/

# TEST LOGS ################
	# where does the log file output go from the '--log-file=""' option? from previous experience I think it automatically goes into the dir where the *script* is run from, not from any direction by the rsync command.
	rsync -avP --stats --itemize-changes --human-readable \
	--include='*/' \
	--include='*.bam' \
	--exclude='*' \
	--prune-empty-dirs \
	--partial-dir="_rsync-partial" \
	--log-file="_rsync-log.log" \
	"$src"/ "$dest"/
	# yes confirmed: the .log file gets output to the $PWD where the command is run from. to put log file *within* 

	# make dir within destination to store log files
	dest_logs_dir="$dest"/"_rsync-logs"
	mkdir -pv "$dest_logs_dir"
	# run with timestamped logs
	rsync -avP --stats --itemize-changes --human-readable \
	--include='*/' \
	--include='*.bam' \
	--exclude='*' \
	--prune-empty-dirs \
	--partial-dir="_rsync-partial" \
	--log-file="$dest_logs_dir"/"$(date +%Y-%m-%d-%H%M%S)-rsync.log" \
	"$src"/ "$dest"/
	# this works. but i know from exp that you cant make a log dir on with 'mkdir' on a remote ssh server. so for my 2-way sync, the logs dir will always have to go in the local dir.

# TEST DELETE AND BACKUP ################
	# now make the practice dest we've been using into a mock local dir and make a new empty dir as a mock remote so we can play around with deleting and backing up files
	local="/Users/leo/Desktop/work--tmp/RSYNC-TEST-LOCAL"
	remote="/Users/leo/Desktop/work--tmp/RSYNC-TEST-REMOTE"

	# make logs dir on local (bc cant on remote bc ssh)
	local_logs_dir="$local"/"_rsync-logs"
	mkdir -pv "$local_logs_dir"

	# test just --delete on remote
		# make newfile on remote
		touch "$remote"/newfile.txt
		# sync remote >> local
		rsync -avP --stats --itemize-changes --human-readable \
		--prune-empty-dirs \
		--partial-dir="_rsync-partial" \
		--log-file="$local_logs_dir"/"$(date +%Y-%m-%d-%H%M%S)-rsync.log" \
		"$remote"/ "$local"/

		# delete newfile from local - it should delete on remote
		rm "$local"/newfile.txt

		# sync local >> remote
		rsync -avP --stats --itemize-changes --human-readable \
		--prune-empty-dirs \
		--delete \
		--partial-dir="_rsync-partial" \
		--log-file="$local_logs_dir"/"$(date +%Y-%m-%d-%H%M%S)-rsync.log" \
		"$local"/ "$remote"/
		# successfully reproducibly deletes the newfile from remote since it was deleted from local. DOES NOT back up the deleted file on the remote

	# test --delete + --backup
		# make newfile on remote
		touch "$remote"/newfile.txt

		# sync remote >> local
		rsync -avP --stats --itemize-changes --human-readable \
		--prune-empty-dirs \
		--partial-dir="_rsync-partial" \
		--log-file="$local_logs_dir"/"$(date +%Y-%m-%d-%H%M%S)-rsync.log" \
		"$remote"/ "$local"/

		# delete newfile from local - it should delete on remote
		rm "$local"/newfile.txt

		# sync local >> remote
		rsync -avP --stats --itemize-changes --human-readable \
		--prune-empty-dirs \
		--delete \
		--backup \
		--partial-dir="_rsync-partial" \
		--log-file="$local_logs_dir"/"$(date +%Y-%m-%d-%H%M%S)-rsync.log" \
		"$local"/ "$remote"/
		# with both --delete and --backup on, the "deleted" file is appended with a '~' at the end to signify it is a backup file

		# what happens to the backup .*~ file when you run it again?
		rsync -avP --stats --itemize-changes --human-readable \
		--prune-empty-dirs \
		--delete \
		--backup \
		--partial-dir="_rsync-partial" \
		--log-file="$local_logs_dir"/"$(date +%Y-%m-%d-%H%M%S)-rsync.log" \
		"$local"/ "$remote"/
		# it stays there. 

		# what happens to remote ~ backup files when you rsync back to local? do the backup files get transferred?
		rsync -avP --stats --itemize-changes --human-readable \
		--prune-empty-dirs \
		--partial-dir="_rsync-partial" \
		--log-file="$local_logs_dir"/"$(date +%Y-%m-%d-%H%M%S)-rsync.log" \
		"$remote"/ "$local"/
		# YES they do. you need to exclude backup files on remote with an --exclude on local side:
		rsync -avP --stats --itemize-changes --human-readable \
		--prune-empty-dirs \
		--exclude='*.*~' \
		--partial-dir="_rsync-partial" \
		--log-file="$local_logs_dir"/"$(date +%Y-%m-%d-%H%M%S)-rsync.log" \
		"$remote"/ "$local"/

	# test --delete + --backup + --backup-dir
		# make newfile on remote
		touch "$remote"/newfile{1..5}.txt

		# sync local <- remote
		rsync -avP --stats --itemize-changes --human-readable \
		--prune-empty-dirs \
		--partial-dir="_rsync-partial" \
		--log-file="$local_logs_dir"/"$(date +%Y-%m-%d-%H%M%S)-rsync.log" \
		"$remote"/ "$local"/

		# delete newfile from local - it should delete on remote
		rm "$local"/newfile.txt

		# sync local -> remote and use --backup-dir where files get put instead of appending a '~' to the end of the file
		rsync -avP --stats --itemize-changes --human-readable \
		--prune-empty-dirs \
		--delete \
		--backup \
		--backup-dir="_rsync-backup" \
		--partial-dir="_rsync-partial" \
		--log-file="$local_logs_dir"/"$(date +%Y-%m-%d-%H%M%S)-rsync.log" \
		"$local"/ "$remote"/
		# this actually keeps backing up the existing '_rsync-backup' into the new '_rsync-backup'. it needs an --exclude to prevent nesting of backup dirs.
		
		# exclude the rsync backup dir on remote to prevent backup dir nesting
		rsync -avP --stats --itemize-changes --human-readable \
		--prune-empty-dirs \
		--exclude='_rsync-backup/' \
		--delete \
		--backup \
		--backup-dir="_rsync-backup" \
		--partial-dir="_rsync-partial" \
		--log-file="$local_logs_dir"/"$(date +%Y-%m-%d-%H%M%S)-rsync.log" \
		"$local"/ "$remote"/
		# this works but doesnt make sense since the backup dir is only on the remote and not being copied from local, but the exclude still acts like it is..? idk


	

