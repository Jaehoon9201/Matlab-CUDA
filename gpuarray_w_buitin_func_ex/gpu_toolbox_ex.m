close all; clc;
gpuDeviceCount("available")
gpuDevice(1)

tic
A = gpuArray([1 0 1; -1 -2 0; 0 1 -1]);
e = eig(A)
toc

tic
A = [1 0 1; -1 -2 0; 0 1 -1];
e = eig(A)
toc