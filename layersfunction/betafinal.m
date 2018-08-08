function [ O, O2, O3 ,DzDw] = betafinal( beta, c, z, Eta, DzDy )
%% network setting
config;
fN = nnconfig.FilterNumber ;
%% The forward propagation; 
if nargin == 4 
    for i = 1:1:fN
        O(:,:,i) = beta(:,:,i) +Eta(i)*( c(:,:,i) - z(:,:,i)); 
    end
end
%% The backward propagation
if nargin ==5 
    for i=1:fN
        O(:,:,i) = DzDy(:,:,i); % d(beta)d(beta),为下一次计算M的参数(dEd(eta))做准备
        O2(:,:,i) = Eta(i)*DzDy(:,:,i); % d(beta)dc,为计算C的参数做准备
        O3(:,:,i) = (-1)*Eta(i)*DzDy(:,:,i); % d(beta)dz,为计算Z的参数做准备
        temp = DzDy(:,:,i).*(c(:,:,i) - z(:,:,i));
        DzDw(i) = sum(temp(:)); % dEd(eta)
    end
end
end

