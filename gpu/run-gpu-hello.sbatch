#!/bin/bash
##
## Create a Julia environment so we can run Julia on the GPU nodes.
##
## The environment needs to be created on a GPU node, that way the CUDA
## libraries are available for CUDA.jl to use. If we try to create the
## environment on the login node, CUDA.jl will try to download CUDA drivers
## for us...
##
#SBATCH --account=group-rci	# priority account to use
#SBATCH --job-name=gpu-hello           # job name
#SBATCH --partition=gpuunsafe         # queue partition to run the job in
#SBATCH --nodes=1                       # number of nodes to allocate
#SBATCH --ntasks-per-node=1             # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=1		# number of cores to allocate - do not allocate more than 16 cores per GPU
#SBATCH --gres=gpu:a40:1
#SBATCH --mem=4G                    # 2000 MB of Memory allocated - do not allocate more than 128000 MB mem per GPU
#SBATCH --time=0-00:10:00               # Maximum job run time
#SBATCH --output=gpu-hello-%j.out 	# standard output file (%j = jobid)
#SBATCH --error=gpu-hello-%j.err 	# standard error file
## Run 'man sbatch' for more information on the options above.

module load Julia
module load CUDA/11.8.0

ENV_NAME="gpu-env"

julia --project="${ENV_NAME}" gpu-hello.jl

