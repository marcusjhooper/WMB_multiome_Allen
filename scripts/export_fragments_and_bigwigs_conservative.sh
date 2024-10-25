#!/usr/bin/env bash
#
# =============================================================================
#
#SBATCH --job-name=snap2    # Job name
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=marcus.hooper@alleninstitute.org     # Where to send mail
#SBATCH --nodes=1                     # Run on a single CPU
#SBATCH --exclusive
#SBATCH --cpus-per-task=10             # Run on a single CPU
#SBATCH --mem=100G                     # Job memory request (per node)
#SBATCH --time=2-00:00:00               # Time limit hrs:min:sec
#SBATCH --partition celltypes         # Partition used for processing
#SBATCH --tmp=100G                     # Request the amount of space your jobs needs on /scratch/fast
#SBATCH -o /allen/programs/celltypes/workgroups/rnaseqanalysis/mouse_multiome/people/marcus/scripts/slurm_output/%j.out
################################################################################
cd /allen/programs/celltypes/workgroups/rnaseqanalysis/mouse_multiome/people/marcus/scripts/

echo "Pre profile"
echo $SLURM_ARRAY_TASK_ID
echo "Post profile"
echo $SLURM_ARRAY_TASK_ID


echo "singularity exec --bind /scratch/fast/${SLURM_JOB_ID} /allen/programs/celltypes/workgroups/mct-t200/marcus/docker/snapatac2.sif python3 export_fragments_and_bigwigs_conservative.py --args ${SLURM_ARRAY_TASK_ID}"
echo "$(env)" #print environment variables
echo "resolution: $1"


##1201 supertype label, 337 subclass, 35 class -in batches - array-values = supertype:0-24 subclass: 0-6, class: 0
#example running this script for all levels of resolution
#sbatch --array=0 export_fragments_and_bigwigs_conservative.sh 'class_label'
#sbatch --array=0-6%1 export_fragments_and_bigwigs_conservative.sh 'subclass_label'
#sbatch --array=0-24%1 export_fragments_and_bigwigs_conservative.sh 'supertype_label'

singularity exec --bind /scratch/fast/$SLURM_JOB_ID /allen/programs/celltypes/workgroups/mct-t200/marcus/docker/snapatac2.sif python3 export_fragments_and_bigwigs_conservative.py --args $SLURM_ARRAY_TASK_ID --resolution $1
















#old
#add to PATH
#export PATH="/usr/lib64/qt-3.3/bin:/opt/moab/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/marcus.hooper/.local/bin:/home/marcus.hooper/bin:/allen/programs/celltypes/workgroups/mct-t200/marcus:/allen/programs/celltypes/workgroups/mct-t200/marcus/python/bin:/allen/programs/celltypes/workgroups/mct-t200/marcus/python/condabin:/allen/programs/celltypes/workgroups/mct-t200/marcus/github/aws/dist:/allen/programs/celltypes/workgroups/mct-t200/marcus/github/OpenBLAS/bin:/allen/programs/celltypes/workgroups/mct-t200/marcus/python/lib/python3.9/site-packages:/allen/programs/celltypes/workgroups/mct-t200/marcus/github/bwa:/allen/programs/celltypes/workgroups/mct-t200/marcus/bashtools:/allen/programs/celltypes/workgroups/mct-t200/marcus/docker:/allen/programs/celltypes/workgroups/mct-t200/marcus/bashtools/ncbi-blast-2.14.0+/bin:/allen/programs/celltypes/workgroups/mct-t200/marcus/python/envs/magick/bin:$PATH"
#add to PATH - use in python script
# path_list = ['/usr/lib64/qt-3.3/bin','/opt/moab/bin','/usr/local/bin','/usr/bin','/usr/local/sbin','/usr/sbin','/home/marcus.hooper/.local/bin','/home/marcus.hooper/bin','/allen/programs/celltypes/workgroups/mct-t200/marcus','/allen/programs/celltypes/workgroups/mct-t200/marcus/python/bin','rcus.hooper/.local/bin:/home/marcus.hooper/bin:/allen/programs/celltypes/workgroups/mct-t200/marcus:/allen/programs/celltypes/workgroups/mct-t200/marcus/python/bin:allen/programs/celltypes/workgroups/mct-t200/marcus/python/condabin','/allen/programs/celltypes/workgroups/mct-t200/marcus/github/aws/dist','/allen/programs/celltypes/workgroups/mct-t200/marcus/github/OpenBLAS/bin','/allen/programs/celltypes/workgroups/mct-t200/marcus/python/lib/python3.9/site-packages','/allen/programs/celltypes/workgroups/mct-t200/marcus/github/bwa','/allen/programs/celltypes/workgroups/mct-t200/marcus/bashtools','/allen/programs/celltypes/workgroups/mct-t200/marcus/docker','/allen/programs/celltypes/workgroups/mct-t200/marcus/bashtools/ncbi-blast-2.14.0+/bin','/allen/programs/celltypes/workgroups/mct-t200/marcus/python/envs/magick/bin']
# for p in path_list:
#     sys.path.append(p)

#note 1374 mouse multiome fragment files-- process each individually
#snapatac2

#/usr/local/bin,/usr/bin,

#singularity exec --bind /usr/lib64/qt-3.3/bin,/usr/local/sbin,/usr/sbin,/home/marcus.hooper/.local/bin,/home/marcus.hooper/bin,/allen/programs/celltypes/workgroups/mct-t200/marcus,/allen/programs/celltypes/workgroups/mct-t200/marcus/python/bin,/allen/programs/celltypes/workgroups/mct-t200/marcus/python/condabin,/allen/programs/celltypes/workgroups/mct-t200/marcus/github/aws/dist,/allen/programs/celltypes/workgroups/mct-t200/marcus/github/OpenBLAS/bin,/allen/programs/celltypes/workgroups/mct-t200/marcus/python/lib/python3.9/site-packages,/allen/programs/celltypes/workgroups/mct-t200/marcus/github/bwa,/allen/programs/celltypes/workgroups/mct-t200/marcus/bashtools,/allen/programs/celltypes/workgroups/mct-t200/marcus/docker,/allen/programs/celltypes/workgroups/mct-t200/marcus/bashtools/ncbi-blast-2.14.0+/bin,/allen/programs/celltypes/workgroups/mct-t200/marcus/python/envs/magick/bin,/usr/local/bin,/scratch/fast/$SLURM_JOB_ID,/allen/programs/celltypes/workgroups/mct-t200/marcus/tmp,/home/marcus.hooper,/allen/programs/celltypes/workgroups/rnaseqanalysis/mouse_multiome/people/marcus/peak_calling/class_conservative,/allen/programs/celltypes/workgroups/rnaseqanalysis/mouse_multiome/people/marcus/peak_calling/subclass_conservative,/allen/programs/celltypes/workgroups/rnaseqanalysis/mouse_multiome/people/marcus/peak_calling/supertype_conservative,/allen/programs/celltypes/workgroups/rnaseqanalysis/mouse_multiome/results/bigwigs/class_label_conservative,/allen/programs/celltypes/workgroups/rnaseqanalysis/mouse_multiome/results/bigwigs/subclass_label_conservative,/allen/programs/celltypes/workgroups/rnaseqanalysis/mouse_multiome/results/bigwigs/supertype_label_conservative /allen/programs/celltypes/workgroups/mct-t200/marcus/docker/snapatac2.sif python3 export_fragments_and_bigwigs_conservative.py --args $SLURM_ARRAY_TASK_ID


