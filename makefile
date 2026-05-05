NVCC = nvcc
CFLAGS = -lm

all: nbody

nbody: nbody.cu compute.cu
	$(NVCC) $(CFLAGS) -o nbody nbody.cu compute.cu

clean:
	rm -f nbody
