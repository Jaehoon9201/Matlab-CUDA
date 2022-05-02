clear all; clc;

k = parallel.gpu.CUDAKernel('test.ptx','test.cu','add2');
N = 128;
k.ThreadBlockSize = N;
in1 = gpuArray.ones(N,1);
in2 = gpuArray.ones(N,1);
result = feval(k,in1,in2)