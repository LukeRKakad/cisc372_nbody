#ifndef __COMPUTE_H__
#define __COMPUTE_H__
#include "vector.h"
__global__ void compute(vector3* pos, vector3* vel, double* mass, int n);
#endif
