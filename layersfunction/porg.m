function [ O, O2 ,DzDw ] = porg( x, t, y, tau, DzDy1, DzDy2, DzDy3  )
%% network setting
config;
%% The forward propagation
if nargin == 4 
    O = tau*(x - y - t) ;
end
%% The backward propagation
if nargin == 7 
    DzDy = DzDy1 + DzDy2 +DzDy3;
    O =(-1) * tau * DzDy; % d(p)dt,为计算t的参数做准备
    O2 =  tau * DzDy; % d(p)dx,为计算Z的参数做准备
    temp = DzDy.*(x- y - t);
    DzDw = sum(temp(:)); % dEd(eta)
end
end
