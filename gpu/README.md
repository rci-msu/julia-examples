# Julia GPU examples

## Configuration
In order to use the GPUs in Julia, we need to install the [CUDA.jl](https://cuda.juliagpu.org/stable/) package. However, hte package needs to know that we have NVIDIA GPUs available, which means we have to create the Julia environment on a GPU node.

To create an environment, run the `create-gpu-env.sbatch` file: 
```
sbatch create-gpu-env.sbatch
```
You may want to modify the environment name in the `create-gpu-env.sbatch` file.

## Running examples
Each example Julia file has an associated `run-<example-name>.sbatch` file. To run an example, run the associated sbatch file, e.g.:
```
sbatch run-gpu-hello.sbatch
```
