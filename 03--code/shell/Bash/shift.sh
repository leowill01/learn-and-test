foo () {
	outdir=$1
	shift

	echo "files going into $outdir are: "
	echo "$@"
}

foo2 () {
	outdir=$1
	# shift

	echo "files going into $outdir are: "
	echo "$@"
}

# compare with and without shift
foo ~/"Documents" file1 file2 file3
foo2 ~/"Documents" file1 file2 file3
