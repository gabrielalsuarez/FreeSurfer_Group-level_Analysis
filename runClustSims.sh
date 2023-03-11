#!/bin/bash

smoothing="10"
meas="volume thickness area"
hemi="lh rh"
while [[ $# -gt 0 ]]; do
	key="$1"
	case $key in
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
		--out-dir)
		out_dir="$2"
		shift 2
		;;
		--cache)
		cache="$2 $3"
		shift 3
		;;	
		-h|--help)
		echo "run cluster sim from freesurfer"
		echo "--smoothing    smoothing val [DEFAULT: 10]"
		echo "--meas         measure (options: thickness, volume, area) [DEFAULT: \"volume thickness area\"]"
		echo "--hemi         hemisphere (options: lh, rh) [DEFAULT: \"lh rh\"]"
		echo "--out-dir      directory containing output files for glm"
		echo "--cache        vertex-wise threshold & direction of test (options: pos, neg, abs) [DEFAULT: 3.0 abs]"
		exit
		;;
		*)
		echo "unknown option specified: $1"
		exit
		;;
	esac
done

# make sure all required inputs received

for h in ${hemi} ; do
  for s in ${smoothing}; do
    for m in ${meas}; do
     	 mri_glmfit-sim \
        --glmdir "${out_dir}/${h}.${m}.${s}.glmdir" \
	--cache ${cache} \
	--cwp 0.05 \
	--2spaces > "${out_dir}/${h}.${m}.${s}.log"
    done
  done
done
