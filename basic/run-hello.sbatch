#!/bin/bash
##
## example-array.slurm.sh: submit an array of jobs with a varying parameter
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=group-eele565     #specify the account to use
#SBATCH --job-name=hello            # job name
##SBATCH --partition=test           # queue partition to run the job in
#SBATCH --partition=legacy          # queue partition to run the job in
#SBATCH --reservation=eele565       # reservation
#SBATCH --nodes=1                   # number of nodes to allocate
#SBATCH --ntasks-per-node=1         # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=2           # number of cpus to use
#SBATCH --mem=1900M                 # 1900 MB of Memory allocated; set --mem with care
#SBATCH --time=0-01:00:00           # Maximum job run time
#SBATCH --output=hello-%j.out
#SBATCH --error=hello-%j.err

## Run 'man sbatch' for more information on the options above.

date                             # print out the date
echo "Hello from $(hostname -s)!" # print a message from the compute node
module load Julia
julia hello.jl
date                             # print the date again

