#!/bin/bash
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=group-rci     # specify the account to use
##SBATCH --reservation=eele565
#SBATCH --partition=unsafe      # queue partition to run the job in
#SBATCH --job-name=mpi-hello     
#SBATCH --nodes=4               # number of nodes to allocate
#SBATCH --ntasks-per-node=64    # number of MPI tasks per node
#SBATCH --cpus-per-task=2       # number of cores to allocate
#SBATCH --mem-per-cpu=1000M     
#SBATCH --time=0-00:01:00       
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err

## Run 'man sbatch' for more information on the options above.

module load OpenMPI/4.1.4-GCC-11.3.0
module load Julia/

ENV_NAME="mpi"

mpiexec --mca pml ob1 --mca btl tcp,self julia --project="${ENV_NAME}" mpi-hello.jl 
