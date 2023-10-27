# Julia MPI examples

This directory contains some MPI examples using Juila and the [MPI.jl](https://juliaparallel.org/MPI.jl/stable/) library. Most of the examples were taken or modified from the [official MPI.jl examples](https://github.com/JuliaParallel/MPI.jl/tree/master/docs/examples).

## Overivew of examples
TODO

## MPI configuration
### Julia environment
The preferred way to configure MPI.jl is to use Julia environments, that way
- you don’t clutter your default Julia depot (~/.julia) with the MPI packages.
- you can easily create the environment’s MPI preferences and reuse them in different projects, directories, etc., just by telling Julia to load your environment.



1. Load Julia

    ```
    module load Julia
    ```

2. Create the environment and Install MPI.jl. This will install the MPI.jl package in the environment’s directory (which is in the folder you launched Julia from)

    ```
    julia -e 'using Pkg; Pkg.activate("environment-name"); Pkg.add("MPI")'.
    ```

3. Configure Julia to use the cluster’s OpenMPI module

    1. Install the [MPIPreferences.jl](https://juliaparallel.org/MPI.jl/latest/reference/mpipreferences/) package:

        ```
        julia --project="environment-name" -e 'using Pkg; Pkg.add("MPIPreferences")'
        ```
    
    2. Load your desired OpenMPI module. As of 10/10/2023, the latest working OpenMPI on the legacy nodes is `OpenMPI/4.1.4-GCC-11.3.0`

        ```
        module load OpenMPI/4.1.4-GCC-11.3.0
        ```

    3. Configure Julia to use the system-provided MPI library

        ```
        julia --project="environment-name" -e 'using MPIPreferences; MPIPreferences.use_system_binary()'
        ```

### OpenMPI parameters
`mpiexec` needs to be explicitly told which transport protocols to use, otherwise it will tend to try protocols that our hardware does not support. More info on the available protocols can be found [here](https://docs.open-mpi.org/en/main/mca.html).
- Specify the point-to-point messaging later (`pml`) as `ob1`.
- Specify the byte transport layer (`btl`) protocols as `self,tcp`.

The resulting `mpiexec` call looks like this:
```
mpiexec --mca pml ob1 --mca btl tcp,self julia --project="environment-name" <julia-file>
```
