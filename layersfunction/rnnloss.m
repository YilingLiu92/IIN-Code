function Y = rnnloss(X, I, DzDy ) % I为原图
%% rnnloss: calculate the NMSE of restored image and original image
%% X: reconstructed image of size m*n;
%% I: ground-truth image of size m*n;

X = double(X);
I = double(I);
B=norm(I,'fro'); % 矩阵每个元素平方和再开方

if nargin == 2 % 重建
 S = X - I ;
 Y = norm(S,'fro') / B ;
elseif nargin ==3 % 训练
 S = X - I ;
 Y1 = norm(S,'fro') ;  %弗罗贝尼乌斯范数 
 Y = S /(B*Y1); % dE/dx,为计算X做准备
else
    error('Input arguments number not proper.');
end;
end