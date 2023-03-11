# FreeSurfer_Group-level_Analysis

The scripts in this repository are to run Group level analysis on structural MRI data using FreeSurfer. The repository contains the following three scripts: *runMrisPreproc.sh*, *runGLMs.sh*, and *runClustSims.sh*

## STEP 1: Creating a group file with `mris_preproc` 
 - *runMrisPreproc.sh* 
    - In order to run a group analysis, we first need to combine all of our individual structural images into a single dataset. 
    - The data are also resampled to the fsaverage template, which is in MNI space.
    - Uses a single command `mris_preproc` - requires the following arguments
      - --fsgd: An FSGD file
      - --target: A template to resample to (fsaverage) 
      - --hemi: Indicate which hemisphere to resample (lh, rh, or both)
      - --cache-in: Specify which smoothed images we want to use in the analysis
    - The *runMrisPreproc.sh* script allows the `mris_prepoc` command to be executed flexibly across studies depending on the needs of the user
    
## STEP 2: Fitting the general linear model with `mri_glmfit` 
- *runGLMs.sh*
  - After running `mris_preproc` the subjects are concatenated into a single dataset. Now we can fit a general linear model with FreeSurfer’s `mri_glmfit` command
  - `mri_glmfit` requires the following arguments
     - --y: The concatenated dataset containing all of the subjects’ structural maps
     - --fsgd: An FSGD file
     - --C: A list of contrasts
     - --surf: The hemisphere of the template to analyze
     - --cortex: A mask to restrict our analysis only to the cortex
     - --glmdir: An output label for the directory containing the results
  - The *runGLMs.sh* script allows the `mri_glmfit` command to be executed flexibly across studies depending on the needs of the user
 
## STEP 3: Cluster Correction with `mri_glmfit-sim` 
- *runClustSims.sh*
  - After running the general linear model with the `mri_glmfit` command and creating group-level contrast maps, it is necessary to correct for the number of tests that have been run.
  - Cluster correction is conducted using the `mri_glmfit-sim` command
  - `mri_glmfit-sim` requires the following arguments
     - --glm-dir: Directory containing output files for glm 
     - --cache: Vertex-wise threshold & direction of test (options: pos, neg, abs)
     - --cwp: Cluster-wise p-threshold (always set to .05)
     - --2spaces: Correction for analyzing both hemispheres
  - The *runClustSims.sh* script allows the `mri_glmfit-sim` command to be executed flexibly across studies depending on the needs of the user
