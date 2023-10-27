#!/bin/bash
##
## example-array.slurm.sh: submit an array of jobs with a varying parameter
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=group-eele565     # specify the account to use
#SBATCH --reservation=eele565       # specify the reservation
#SBATCH --job-name=threads          # job name
#SBATCH --partition=legacy          # queue partition to run the job in
#SBATCH --nodes=1                   # number of nodes to allocate
#SBATCH --ntasks-per-node=16        # number of descrete tasks
#SBATCH --cpus-per-task=2           # number of cores to allocate
#SBATCH --mem-per-cpu=1900M         # Memory per cpu
#SBATCH --time=0-01:00:00           # Maximum job run time
#SBATCH --output=threads-%j.out
#SBATCH --error=threads-%j.err

## Run 'man sbatch' for more information on the options above.

date                             # print out the date
echo "Hello from $(hostname -s)!" # print a message from the compute node
echo "NTASK = $SLURM_TASKS_PER_NODE"
module load Julia
julia --threads=$SLURM_TASKS_PER_NODE threads.jl
date                             # print the date again

