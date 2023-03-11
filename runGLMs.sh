#!/bin/bash

smoothing="10"
meas="volume thickness area"
hemi="lh rh"
cortex=""
while [[ $# -gt 0 ]]; do
	key="$1"
	case $key in
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
		--con-dir)
		con_dir="$2"
		shift 2
		;;
		--cortex)
		cortex="--cortex"
		shift 1
		;;
		--preproc-dir)
		preproc_dir="$2"
		shift 2
		;;
		--glm-dir)
		glm_dir="$2"
		shift 2
		;;	
		-h|--help)
		echo "run mris_preproc from freesurfer"
		echo "--fsgd         Path to .fsgd file"
		echo "--smoothing    smoothing val [DEFAULT: 10]"
		echo "--meas         measure (options: thickness, volume, area) [DEFAULT: \"volume thickness area\"]"
		echo "--hemi         hemisphere (options: lh, rh) [DEFAULT: \"lh rh\"]"
		echo "--con-dir      directory containing analysis .mtx files"
		echo "--preproc-dir  directory containing output of mris_preproc"
		echo "--glm-dir      output directory for freesurfer glm"
		echo "--cortex       restrict analysis to cortex [DEFAULT: False]"
		exit
		;;
		*)
		echo "unknown option specified: $1"
		exit
		;;
	esac
done

# make sure all required inputs received

mkdir -p "${glm_dir}"
contrast=$(for con in ${con_dir}/*.mtx; do echo "--C ${con}"; done)

for h in ${hemi} ; do
  for s in ${smoothing}; do
    for m in ${meas}; do
      mri_glmfit \
        --y "${preproc_dir}/${h}.${m}.${s}.mgh" \
	--fsgd "${fsgd}" \
	$(echo ${contrast}) \
	--surf fsaverage "${h}" \
	${cortex} \
	--glmdir "${glm_dir}/${h}.${m}.${s}.glmdir" > "${glm_dir}/${h}.${m}.${s}.GLMs.log"
    done
  done
done
