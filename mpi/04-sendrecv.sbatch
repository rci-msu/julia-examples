#!/bin/bash
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=group-rci             # specify the account to use
##SBATCH --reservation=eele565
#SBATCH --partition=legacy              # queue partition to run the job in
#SBATCH --job-name=04-sendrecv    
#SBATCH --nodes=8                       # number of nodes to allocate
#SBATCH --ntasks-per-node=16            # number of MPI tasks per node
#SBATCH --cpus-per-task=2               # number of cores to allocate
#SBATCH --mem-per-cpu=1000M 
#SBATCH --time=0-00:01:00               # Maximum job run time
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err

## Run 'man sbatch' for more information on the options above.

module load OpenMPI/4.1.1-GCC-11.2.0
module load Julia/

mpiexec --mca pml ob1 --mca btl tcp,self julia 04-sendrecv.jl 
