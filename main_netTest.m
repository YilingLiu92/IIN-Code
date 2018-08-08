%% This is a cpu test code demo for IIN reconstruction.
%% Output: the average NMSE and PSNR over the test images.
clear all; clc;
%% Load trained network
load p0.3.mat
%% Load data
config
p = './test_images/';
pathForImages ='';
name_list = {'barbara256.png','house256.png','Lena256.png','peppers256.png','Cameraman256.png','baboon.tif','boats.tif','foreman.tif','pentagon.tif','straw.tif' };
DataNmber = length(name_list);
nbimgi = 2;
[M0,pp] = imread(strcat([p,pathForImages,name_list{nbimgi}]));
M0 = im2double(M0);
load noi2_p0.3.mat
data.train = M;
data.label = M0;
%% reconstrction by IIN
tic
[re_Loss, rec_image] = loss_with_gradient_single_before(data, net);
Time_Net_rec = toc; 
PSNR0 = 20*log10(255/sqrt(mean((255*M(:)-255*M0(:)).^2)))
rec_PSNR = 20*log10(255/sqrt(mean((255*rec_image(:)-255*M0(:)).^2)))
re_Loss % NMSE
aa=255*(rec_image);
M2 = M0*255;
SSIM = ssim_index(aa, M2)
figure(101);   imshow(rec_image*255,[]); 

