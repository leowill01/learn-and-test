# INSTALL VEP FOR MACOS
# https://uswest.ensembl.org/info/docs/tools/vep/script/vep_download.html#macos

# WITH DOCKER
# https://uswest.ensembl.org/info/docs/tools/vep/script/vep_download.html#docker
	# install docker image
	docker pull ensemblorg/ensembl-vep

	# command to run vep
	docker run -t -i ensemblorg/ensembl-vep ./vep
	alias vep='docker run -t -i ensemblorg/ensembl-vep ./vep'

	# use a local dir to store cache data
		# make dir
		mkdir ~/vep_data

		# ensure dir has read/write access
		chmod a+rwx ~/vep_data

		# command to run vep with local storage dir
		# FIXM: this enters a new shell and unclear how to install cache files
		# docker run -t -i -v ~/vep_data:/opt/vep/.vep ensemblorg/ensembl-vep
		# FIX: needed './vep' at the end to call the command
		docker run -t -i -v ~/vep_data:/opt/vep/.vep ensemblorg/ensembl-vep ./vep

		# manually install cache files
		# follow the prompt for everything
		docker run -t -i -v $HOME/vep_data:/opt/vep/.vep ensemblorg/ensembl-vep perl INSTALL.pl
		# eg install specific version of human cache
		docker run -t -i -v $HOME/vep_data:/opt/vep/.vep ensemblorg/ensembl-vep perl INSTALL.pl -a cf -s "homo_sapiens" -y "GRCh38"
		# eg install specific version of mouse cache
		docker run -t -i -v $HOME/vep_data:/opt/vep/.vep ensemblorg/ensembl-vep perl INSTALL.pl -a cf -s "mus_musculus" -y "GRCm38"

		# notes
			# The VEP can either connect to remote or local databases, or use local cache files.
			# Using local cache files is the fastest and most efficient way to run the VEP
			# Cache files will be stored in /opt/vep/.vep


			# The VEP can use FASTA files to retrieve sequence data for HGVS notations and reference sequence checks.
			# FASTA files will be stored in /opt/vep/.vep

			# The FASTA file should be automatically detected by the VEP when using --cache or --offline.
			# If it is not, use "--fasta /opt/vep/.vep/mus_musculus/102_GRCm38/Mus_musculus.GRCm38.dna.toplevel.fa.gz"

		# alias to run vep command - FIXME: cant find file
		alias vep='docker run -t -i -v $HOME/vep_data:/opt/vep/.vep ensemblorg/ensembl-vep ./vep'

		docker run -t -i -v $HOME/vep_data:/opt/vep/.vep ensemblorg/ensembl-vep


# SCRIPT TO RUN DOCKER VEP
	# define inputs
	in_vcf="/Users/leo/Desktop/work--tmp/9Lu_T-717L_N/mutect/results--2020-12-11-003156/9Lu_T-717L_N.mutect2.filtered.pass.vcf"
	in_vcf_basename=$(basename $in_vcf)
	in_vcf_dirname=$(dirname $in_vcf)

	out_vcf_basename="${in_vcf_basename%.vcf}.vep.vcf"
	out_vcf="$in_vcf_dirname"/"$out_vcf_basename"
	
	vep_data_input_dir="/Users/leo/vep_data/input"
	vep_data_output_dir="/Users/leo/vep_data/output"

	# copy vcf to vep input dir
	cp "$in_vcf" "$vep_data_input_dir"

	# start vep image
	docker run -t -i -v $HOME/vep_data:/opt/vep/.vep ensemblorg/ensembl-vep

	# run vep [https://uswest.ensembl.org/info/docs/tools/vep/script/vep_download.html#docker]
	vep --cache --offline --format vcf --vcf --force_overwrite --species mus_musculus \
	--dir_cache /opt/vep/.vep/ \
	--input_file /opt/vep/.vep/input/"$in_vcf_basename" \
	--output_file /opt/vep/.vep/output/outfile.vcf
	# --plugin dbNSFP,/opt/vep/.vep/Plugins/DBNSFP.gz,ALL
	# --custom /opt/vep/.vep/custom/my_extra_data.bed,BED_DATA,bed,exact,1 \
	# --dir_plugins /opt/vep/.vep/Plugins/ 

	# exit docker image
	exit

	# def function for abs filepath
	absfilepath () {
        FILE_OR_DIR=${1:-.} 
        echo "$(cd "$(dirname "$1")"; pwd -P)/$(basename "$1")"
	}

	# vep function?
	annotateMouseVEP () {
		# pass in an arbitrary number of VCF files

		# define local vep I/O dirs
		local_vep_input_dir="$HOME/vep_data/input"
		local_vep_output_dir="$HOME/vep_data/output"
		# define docker vep I/O dirs
		docker_vep_input_dir="/opt/vep/.vep/input"
		docker_vep_output_dir="/opt/vep/.vep/output"
		docker_vep_cache_dir="/opt/vep/.vep"


		for vcf in $@; do
			# get abs filepath for input vcf
			vcf_abs=$(absfilepath $vcf)
			# get dirname for input vcf
			vcf_dirname=$(dirname $vcf_abs)
			# get input vcf basename
			vcf_basename=$(basename $vcf_abs)
			# define vep output vcf basename
			out_vcf_basename="${vcf_basename%.vcf}.vep.vcf"
			# define local (non-docker) filepath for output vcf
			out_vcf_filepath="$vcf_dirname"/"$out_vcf_basename"

			# copy vcf to vep input dir in docker volume
			cp "$vcf_abs" "$local_vep_input_dir"
			
			# annotate with docker vep
				# activate vep docker image
				# annotate with vep inside docker image
				docker run -t -i -v "$HOME"/vep_data:/opt/vep/.vep ensemblorg/ensembl-vep \
				vep \
				--input_file "$docker_vep_input_dir"/"$vcf_basename" \
				--output_file "$docker_vep_output_dir"/"$out_vcf_basename" \
				--species "mus_musculus" \
				--cache \
				--dir_cache "$docker_vep_cache_dir" \
				--fork 4 \
				--verbose 
				# --stats_file \
				# --warning_file 
				# --offline \
				# --format vcf \
				# --vcf \
				# --force_overwrite \

				# exit docker image
				# exit
			
			# move output files back to dir where original vcf is from
			mv "$local_vep_output_dir"/"$out_vcf_basename" "$out_vcf_filepath"

			# delete files in local docker input dir
			rm "$local_vep_input_dir"/*
		done
	}

# INSTALLING VEP ON MACOS - FIXME: COULD NOT GET TO WORK

	# Installing VEP on Mac OS is slightly trickier than other Linux-based systems, and will require additional dependancies.
	# These instructions will guide you through the setup of Perlbrew, Homebrew, MySQL and other dependancies that will allow for a clean installation of VEP on your Mac OS system.

	# These instructions have been tested on macOS High Sierra (10.13) and macOS Sierra (10.12).
	# Older versions may require additional tweaks, however we shall endeavor to keep these instructions up to date for future versions of MacOS.


	# Prerequisite Setup

		# List of prerequisites: XCode, GCC, Perlbrew, Cpanm, Homebrew, mysql, DBI, DBD::mysql

	# XCode and GCC

		# VEP requires XCode and GCC for installation purposes. Fortunately, recent versions of macOS will look for (and attempt to install if required) both of these when you run the following command:

		gcc -v

	# Perlbrew

		# We recommend using Perlbrew to install a new version of Perl on your mac, to prevent messing with the vendor perl too much. This can be done with the following command:

		curl -L http://install.perlbrew.pl | bash
		# curl -L http://install.perlbrew.pl | zsh

		# echo 'source $HOME/perl5/perlbrew/etc/bashrc' >> ~/.bash_profile
		echo 'source $HOME/perl5/perlbrew/etc/bashrc' >> ~/.zshrc

		# At this point, PLEASE RESTART YOUR TERMINAL WINDOW to allow for the perlbrew changes to take effect.

		# We recommend installing Perl version 5.26.2 to run VEP, and installing cpanm to handle the installation of perl modules.
		# These steps can be completed with the commands:

		perlbrew install -j 5 --as 5.26.2 --thread --64all -Duseshrplib perl-5.26.2 --notest
		perlbrew switch 5.26.2
		perlbrew install-cpanm

	# Homebrew

		# This package management system for Mac OS would make the installation of the next prerequisite (i.e. xs) easier.

		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	# xz

		# VEP requires the installation of xz, a data-compression utility. The easiest way to install the xz package is through homebrew:

		brew install xz

	# MySQL

		# In order to connect to the Ensembl databases, a collection of MySQL related dependancies are required. Fortunately, these can be installed neatly with Homebrew and Cpanm:

		brew install mysql
		cpanm DBI
		cpanm DBD::mysql

	# Installing BioPerl

		# On some versions of macOS, the VEP installer fails to cleanly install BioPerl, so a manual install will prevent issues:

		curl -O https://cpan.metacpan.org/authors/id/C/CJ/CJFIELDS/BioPerl-1.6.924.tar.gz
		tar zxvf BioPerl-1.6.924.tar.gz
		echo 'export PERL5LIB=${PERL5LIB}:##PATH_TO##/bioperl-1.6.924' >> ~/.bash_profile
		where ##PATH_TO##/bioperl-1.6.924 refers to the location of the newly unzipped BioPerl directory.


	# Final Dependancies

		# Installing the following Perl modules with cpanm will allow for full VEP functionality:

		cpanm Test::Differences Test::Exception Test::Perl::Critic Archive::Zip PadWalker Error Devel::Cycle Role::Tiny::With Module::Build

		export DYLD_LIBRARY_PATH=/usr/local/mysql/lib/:$DYLD_LIBRARY_PATH

	# Installing VEP

		# And that should be that! You should now be able to install VEP using the installer:

		git clone https://github.com/ensembl/ensembl-vep
		cd ensembl-vep
		perl INSTALL.pl --NO_TEST