#!/bin/bash

smoothing="10"
meas="volume thickness area"
hemi="lh rh"
while [[ $# -gt 0 ]]; do
	key="$1"
	case $key in
		--subjects-dir)
		export SUBJECTS_DIR=$2
		shift 2
		;;
		--fsgd)
		fsgd="$2"
		shift 2
		;;
		--smoothing)
		smoothing="$2"
		shift 2
		;;
		--meas)
		meas="$2"
		shift 2
		;;
		--hemi)
		hemi="$2"
		shift 2
		;;
		--preproc-dir)
		preproc_dir="$2"
		shift 2
		;;	
		-h|--help)
		echo "run mris_preproc from freesurfer"
		echo "--subjects-dir Freesurfer SUBJECTS_DIR env variable"
		echo "--fsgd         Path to .fsgd file"
		echo "--smoothing    smoothing val [DEFAULT: 10]"
		echo "--meas         measure (options: thickness, volume, area) [DEFAULT: \"thickness, volume, area\"]"
		echo "--hemi         hemisphere (options: lh, rh) [DEFAULT: \"lh rh\"]"
		echo "--preproc-dir  preproc output directory path"
		exit
		;;
		*)
		echo "unknown option specified: $1"
		exit
		;;
	esac
done

# make sure all required inputs received

mkdir -p "${preproc_dir}"


for h in ${hemi} ; do
  for s in ${smoothing}; do
    for m in ${meas}; do	
      mris_preproc --fsgd "${fsgd}" \
        --cache-in "${m}.fwhm${s}.fsaverage" \
        --target fsaverage \
        --hemi "${h}" \
        --out "${preproc_dir}/${h}.${m}.${s}.mgh" > "${preproc_dir}/${h}.${m}.${s}.log"
    done
  done
done
