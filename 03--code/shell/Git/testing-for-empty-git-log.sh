#!/usr/bin/env bash

cd "/Volumes/Pursell-Lab-HD/Pursell-lab/02--projects/project_02--DNA-seq-analysis"

type $(gl1 --after="1 second ago")


gl1 --after="1 day ago"

if [[ -n $(gl1 --after="1 day ago") ]]; then
	echo "EXPORTING COMMIT HISTORY FOR TIME PERIOD"
else
	echo "NO OUTPUT"
fi
