# FreeSurfer

The scripts in this repository are to run Group level analysis on structural MRI data using FreeSurfer. The repository contains the following three scripts:

## STEP 1: Creating a group file with mris_preproc 
 1. *runMrisPreproc.sh* 
    - In order to run a group analysis, we first need to combine all of our individual structural images into a single dataset. 
    - The data are also resampled to the fsaverage template, which is in MNI space.
    - Uses a single command `mris_preproc` - requires the following arguments
      - --fsgd: An FSGD file
      - --target: A template to resample to (fsaverage) 
      - --hemi: Indicate which hemisphere to resample (lh, rh, or both)
      - --cache-in: Specify which smoothed images we want to use in the analysis
    - The *runMrisPreproc.sh* script allows this command to be executed flexibly across studies depending on the needs of the user
    
 2. STEP 2: runGLMs.sh
 3. runClustSims.sh
