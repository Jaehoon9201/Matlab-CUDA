__global__ void add2( double * v1, const double * v2 )
{
    int idx = threadIdx.x;
    v1[idx] += v2[idx];
}

__global__ void multiply1(const double * v1, const double * v2, const double * v3, const double * v4, double * v5)
{
    
    int idx = threadIdx.x;
    v5[idx] += v4[idx]*v3[idx]*v2[idx]*v1[idx]; 

}

__global__ void matrixMultiply(const double* v1, const double* v2, double* v3, int M) {
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;
   

    if ((row < M) && (col < M)) {
        float temp = 0;
        for (int k = 0; k < M; k++) {
            temp += v1[row*M + k] * v2[k*M + col];
        }
        v3[row*M + col] = temp;
    }
}