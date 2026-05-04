#include <stdlib.h>
#include <math.h>
#include "vector.h"
#include "config.h"
//compute: Updates the positions and locations of the objects in the system based on gravity.
//Parameters: None
//Returns: None
//Side Effect: Modifies the hPos and hVel arrays with the new positions and accelerations after 1 INTERVAL

__global__ void compute(vector3* pos, vector3* vel, double* mass, int n){
	//make an acceleration matrix which is NUMENTITIES squared in size;
	int i = blockIdx.x * blockDim.x + threadIdx.x;
	vector3 accel_sum = {0,0,0};

    for (int j = 0; j < n; j++) {
        if (i == j) continue;

        vector3 distance;
        distance[0] = pos[i][0] - pos[j][0];
        distance[1] = pos[i][1] - pos[j][1];
        distance[2] = pos[i][2] - pos[j][2];

        double dist_sq = distance[0]*distance[0] +
                         distance[1]*distance[1] +
                         distance[2]*distance[2];

        double dist = sqrt(dist_sq);
        double accelmag = -GRAV_CONSTANT * mass[j] / dist_sq;

        accel_sum[0] += accelmag * distance[0] / dist;
        accel_sum[1] += accelmag * distance[1] / dist;
        accel_sum[2] += accelmag * distance[2] / dist;
    }

    // update velocity and position
    for (int k = 0; k < 3; k++) {
        vel[i][k] += accel_sum[k] * INTERVAL;
        pos[i][k] += vel[i][k] * INTERVAL;
    }

}
