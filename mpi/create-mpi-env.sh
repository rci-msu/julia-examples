#!/bin/bash

module load Julia

# Setup julia environment so we can isolate our packages
ENV_NAME="mpi"
julia -e "using Pkg; Pkg.activate(\""${ENV_NAME}"\"); Pkg.add(\"MPI\")"
julia --project="${ENV_NAME}" -e "using MPI; MPI.install_mpiexecjl()'"

# Set MPI.jl to use the cluster's OpenMPI module.
# In our testing, 4.1.4-GCC-11.3.0 is the latest OpenMPI version that works
# on the legacy nodes.
#module load OpenMPI/4.1.4-GCC-11.3.0

julia --project="${ENV_NAME}" -e 'using Pkg; Pkg.add("MPIPreferences")'
#julia --project="${ENV_NAME}" -e 'using MPIPreferences; MPIPreferences.use_system_binary()'
julia --project="${ENV_NAME}" -e 'using MPIPreferences; MPIPreferences.use_jll_binary("OpenMPI_jll")'

module purge
