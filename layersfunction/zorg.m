function [ O, DzDw ] = zorg( p, c, q, DzDy1, DzDy2 )
%% network setting
config;
%% The forward propagation
if nargin == 3
    temp = double(c);
    q = double(q);
    O = nnlinemex(p, q , temp);
end
%% The backward propagation
if nargin == 5
    DzDy = DzDy1 + DzDy2; % dE/dz
    xvar = double(c);
    yvar = double(DzDy);
    q = double(q);
    [O, DzDw] = nnlinemex(p, q, xvar, yvar); % OΪdz/d(C)��Ϊ�´μ���C�Ĳ�����׼����DzDwΪdE/dq
end
end
