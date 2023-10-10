import MPI
using Statistics

MPI.Init()

comm = MPI.COMM_WORLD
size = MPI.Comm_size(comm)
rank = MPI.Comm_rank(comm)

# pre-allocate a buffer for our received message
recv_mesg = zeros(100,1)

if rank == 0
    
    # send message to all other workers
    for i = 1:size-1
        send_mesg = rand(100,1)
        MPI.Send(send_mesg, i, 0, comm)
    end
else
    MPI.Recv!(recv_mesg, 0, 0, comm)
end

m = mean(recv_mesg)

sleep(rank * 2)
println("Results on rank ", rank, ": ", m)

MPI.Barrier(comm)
MPI.Finalize()
