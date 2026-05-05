NVCC = nvcc
CFLAGS = -lm
FLAGS = -DDEBUG
all: nbody

nbody: nbody.cu compute.cu
	$(NVCC) $(CFLAGS) $(FLAGS) -o nbody nbody.cu compute.cu

clean:
	rm -f nbody
