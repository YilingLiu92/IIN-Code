%% This is a traning code for IIN by L-BFGS optimizing.
clear all;close all;clc;
%% Network initialization
net = InitNetSPD ( ); 
%% Initial loss 
wei0 = netTOwei(net); 
l0 = loss_with_gradient_total(wei0) 
%% L-BFGS optimiztion
fun = @loss_with_gradient_total; 
% parameters in the L-BFGS algorithm
low = -inf*ones(length(wei0),1); 
upp = inf*ones(length(wei0),1); 
opts.x0 = double(gather(wei0)); 
opts.m = 3;
opts.maxIts = 150; 
opts.maxTotalIts = 1000;
opts.printEvery = 1; 
tic;
[wei1, l1, info] = lbfgsb(fun, low, upp, opts); 
time = toc;
time = time/3600;
wei1=single(wei1);
net1 = weiTOnet(wei1); 
fprintf('Before training, error is %f; after training, error is %f.\n', l0, l1);
fprintf('The training time is %2.1f hours.\n', time);