#!/bin/bash
#SBATCH --job-name=macs3    # Job name
#SBATCH --ntasks=4                    # Run on a single CPU
#SBATCH --mem=500gb                     # Job memory request (per node)
#SBATCH --time=01-00:00:00               # Time limit hrs:min:sec
#SBATCH --output=macs3.log   # Standard output and error log
#SBATCH --partition celltypes         # Partition used for processing
#SBATCH --tmp=75G                     # Request the amount of space your jobs needs on /scratch/fast
#SBATCH -o /allen/programs/celltypes/workgroups/rnaseqanalysis/mouse_multiome/people/marcus/peak_calling/slurm_output/%j.out
##########################################################################################
 
cd /allen/programs/celltypes/workgroups/rnaseqanalysis/mouse_multiome/people/marcus/peak_calling/supertype_conservative
singularity exec --bind /scratch/fast/$SLURM_JOB_ID /allen/programs/celltypes/workgroups/mct-t200/marcus/docker/snapatac2.sif python3 /allen/programs/celltypes/workgroups/rnaseqanalysis/mouse_multiome/people/marcus/peak_calling/supertype_conservative/scripts/run_macs3_single_group.py --args $SLURM_ARRAY_TASK_ID
