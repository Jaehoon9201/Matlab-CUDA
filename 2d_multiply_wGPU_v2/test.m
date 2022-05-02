%% 1d add example

clear all; clc;
% ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
% ■■■■■■■■■■ add2 example ■■■■■■■■■■
% ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
% k = parallel.gpu.CUDAKernel('test.ptx','test.cu','add2');
% N = 128;
% k.ThreadBlockSize = N;
%
% in1 = gpuArray.ones(N,1);
% in2 = gpuArray.ones(N,1);
% result = feval(k,in1,in2)
%% 1d multiply example

clear all; clc;
% ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
% ■■■■■■■■ multiply1 example ■■■■■■■
% ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
% tic
% k = parallel.gpu.CUDAKernel('test.ptx','test.cu','multiply1');
% N = 1024;
% k.ThreadBlockSize = N;
%
% in1 = 3.* gpuArray.ones(N,1);
% in2 = 4.* gpuArray.ones(N,1);
% in3 = 5.* gpuArray.ones(N,1);
% in4 = 6.* gpuArray.ones(N,1);
% in5 =     gpuArray.ones(N,1);
%
% for i= 1:1:1
%     result = feval(k, in1, in2, in3, in4, in5);
% end
% toc


%% 2d multiply example (@GPU)
clear all; clc;
% ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
% ■■■■■■■■ multiply_dim2 example ■■■■■■■
% ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
tic
k = parallel.gpu.CUDAKernel('test.ptx','test.cu','matrixMultiply');
N = 1024;

% [Reference] https://tododiary.tistory.com/57?category=734704
k.ThreadBlockSize = 8;   % how many blocks to make
k.GridSize = [N N];      % how many threads to use . Size--> must be 'N'

in1 = 5.* gpuArray.ones(N,N);
in2 = 4.* gpuArray.ones(N,N);
in3 =     gpuArray.ones(N,N);

result = feval(k, in1, in2, in3, N);
% wait(gpuDevice); % 이 명령어를 사용하면 gpu에 계산된 데이터값의 이동시간까지 측정하게됨.
toc
% N = 1024 :  경과 시간은 0.028534초입니다. (성분 원소 값 20480)
% N = 4096 :  경과 시간은 0.031023초입니다. (성분 원소 값 81920)
%% 2d multiply example (@CPU)
clear all; clc;
% ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
% ■■■■■■■■ multiply_dim2 using CPU ■■■■■■■
% ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
tic

N=4096;
in1 = 5.* ones(N,N);
in2 = 4.* ones(N,N);
in3 =     ones(N,N);

in3 = in1 * in2;
toc
% 경과 시간은 0.017463초입니다. (성분 원소 값 20480)
% 경과 시간은 0.705032초입니다. (성분 원소 값 81920)