function Y = rnnloss_0726(X, I, DzDy ) % I为原图
%% rnnloss: calculate the NMSE of restored image and original image
%% X: reconstructed image of size m*n;
%% I: ground-truth image of size m*n;

X = double(X);
I = double(I);
B=norm(I,'fro');

if nargin == 2 % 重建
%  S = X - I ;
%  Y = norm(S,'fro') / B ;
 Y = sum(abs(X(:) - I(:))) /prod(size(X));
elseif nargin ==3 % 训练
%  S = X - I ;
%  Y1 = norm(S,'fro') ;   
%  Y = S /(B*Y1); % dE/dx,为计算X做准备
 Y = sign(X - I)/prod(size(X));
else
    error('Input arguments number not proper.');
end;
end