# INSTALLING VEP ON MACOS AND TULANE CYPRESS (LINUX)

# LINUX INSTALL (CYPRESS)
	# cd to home dir to install
	cd "/lustre/project/zpursell/leo/code-packages-external"

	# clone git repo
	git clone https://github.com/Ensembl/ensembl-vep.git
	cd ensembl-vep

	# set DYLD_LIBRARY_PATH="/Users/leo/ensembl-vep/htslib"
	echo 'export DYLD_LIBRARY_PATH="/Users/leo/ensembl-vep/htslib:$DYLD_LIBRARY_PATH"' >> ~/.bash_profile

	# try and straight install
	perl INSTALL.pl # didnt work straight on Cypress
	# warnings
		# DBD::mysql not installed


		# if this fails, try running with --NO_HTSLIB
		perl INSTALL.pl --NO_HTSLIB 

		# Bio::Root::Version is not installed
		# ERRORS/WARNINGS FOUND IN PREREQUISITES.  You may wish to install the versions of the modules indicated above before proceeding with this installation

		# Run 'Build installdeps' to install missing prerequisites.

		# -------------------- EXCEPTION --------------------
		# MSG: ERROR: Cannot use format gff without Bio::DB::HTS::Tabix module installed
	
	# follow the errors
		# install perlbrew
		curl -L http://install.perlbrew.pl | bash
		# curl -L http://install.perlbrew.pl | zsh
		# echo 'source $HOME/perl5/perlbrew/etc/bashrc' >> ~/.bash_profile
		echo 'source $HOME/perl5/perlbrew/etc/bashrc' >> ~/.bash_profile
		# restart terminal window and call command to check if installed
		perlbrew # done

		# install perl 5.26.2 (recommended) and cpanm to handle modules
		perlbrew install -j 5 --as 5.26.2 --thread --64all -Duseshrplib perl-5.26.2 --notest # NOTE: only worked with zsh. likely due to all the setups with zshrc and startup source files
		perlbrew switch 5.26.2
		perlbrew install-cpanm

		# install xz (was installed with conda)
		conda install xz

		# install mysql with conda and SQL perl modules with cpanm (only for running online? i.e. irrelevant in cache mode?)
		conda install mysql
		cpanm DBI DBD::mysql
		# error: Configuring DBD-mysql-4.050 ... N/A
		# ! Configure failed for DBD-mysql-4.050. See /home/lwilli24/.cpanm/work/1608087970.11870/build.log for details.
		# 4 distributions installed
		# (combio)
		#  -- may need to come back to figure out how to install. but hopefully SQL isnt needed if running from cache

		# install other dependencies for full functionality
		cpanm Test::Differences Test::Exception Test::Perl::Critic Archive::Zip PadWalker Error Devel::Cycle Role::Tiny::With Module::Build
		echo 'export DYLD_LIBRARY_PATH="/usr/local/mysql/lib/:$DYLD_LIBRARY_PATH"' >> ~/.bash_profile

		# FAILED to build Bio::DB:HTS: ! Bio::Root::Version is not installed
		cpanm Bio::Root::Version





# MACOS INSTALL ################
	# check that gcc is installed
	gcc -v

	# install perlbrew
	curl -L http://install.perlbrew.pl | bash
	# curl -L http://install.perlbrew.pl | zsh
	# echo 'source $HOME/perl5/perlbrew/etc/bashrc' >> ~/.bash_profile
	echo 'source $HOME/perl5/perlbrew/etc/bashrc' >> ~/.zshrc
	# restart terminal window and call command to check if installed
	perlbrew

	# install perl 5.26.2 (recommended) and cpanm to handle modules
	perlbrew install -j 5 --as 5.26.2 --thread --64all -Duseshrplib perl-5.26.2 --notest # NOTE: only worked with zsh. likely due to all the setups with zshrc and startup source files
	perlbrew switch 5.26.2
	perlbrew install-cpanm

	# install Homebrew

	# install xz with homebrew
	brew instal xz

	# install mysql with homebrew and SQL perl modules with cpanm
	brew install mysql
	cpanm DBI DBD::mysql

	# TODO: manually install BioPerl if VEP installer failts to do so
	# NOTE: I HAD TO DO THIS EVENTUALLY BC THE PERL MODULES KEPT BEING UNABLE TO BE FOUND
	curl -O https://cpan.metacpan.org/authors/id/C/CJ/CJFIELDS/BioPerl-1.6.924.tar.gz
	tar zxvf BioPerl-1.6.924.tar.gz
	# echo 'export PERL5LIB=${PERL5LIB}:##PATH_TO##/bioperl-1.6.924' >> ~/.bash_profile
	# echo 'export PERL5LIB=${PERL5LIB}:________/bioperl-1.6.924' >> ~/.zshrc
	echo 'export PERL5LIB=${PERL5LIB}:~/ensembl-vep/BioPerl-1.6.924' >> ~/.zshrc
	# source .zshrc
	sz
	# confirm bioperl is in path
	echo $PERL5LIB

	# install other dependencies for full functionality
	cpanm Test::Differences Test::Exception Test::Perl::Critic Archive::Zip PadWalker Error Devel::Cycle Role::Tiny::With Module::Build
	echo 'export DYLD_LIBRARY_PATH="/usr/local/mysql/lib/:$DYLD_LIBRARY_PATH"' >> ~/.zshrc

	# INSTALL VEP - should work now - DOES NOT, PERL MODULES STILL NOT WORKING, MAY NEED MANUAL BIOPERL INSTALL OR INSTALL EVERY PACKAGE THAT IT SAYS IT CANT FIND
	git clone https://github.com/ensembl/ensembl-vep
	cd ensembl-vep
	echo 'DYLD_LIBRARY_PATH="/Users/leo/ensembl-vep/htslib":$DYLD_LIBRARY_PATH' >> ~/.zshrc
	perl INSTALL.pl --NO_TEST # ok, but prolly better to specifically install each cache with better options like in the conda example:
	perl INSTALL.pl --NO_HTSLIB --NO_BIOPERL -a cf -s "homo_sapiens" -y GRCh38

	# errors
		# --NO_HTSLIB
		# Bio::Root::Version is not installed
		# ERRORS/WARNINGS FOUND IN PREREQUISITES.  You may wish to install the versions of the modules indicated above before proceeding with this installation
		# Run 'Build installdeps' to install missing prerequisites.

	# add vep to PATH
	echo 'export PATH="~/ensembl-vep:$PATH"' >> .zshrc
	# run vep
	./vep
	# ERRORS
		# --> Working on Bio::PrimarySeqI

		

# ON LINUX (CYPRESS)
	# cd to user-installed packages dir
	cd "/lustre/project/zpursell/leo/code-packages-external"

