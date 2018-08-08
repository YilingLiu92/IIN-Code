function [ O,  O2, DzDw ] = zmid(p, beta, c, q, DzDy1, DzDy2 )
%% network setting
config;
%% The forward propagation
if nargin == 4
    I = c + beta;
    temp = double(I);
    q = double(q);
    O = nnlinemex( p, q , temp); 
end
%% The backward propagation
if nargin ==6
    DzDy = DzDy1 + DzDy2; % dE/dz
    I = c + beta;
    xvar = double(I);
    yvar = double(DzDy);
    q = double(q);
    [O, DzDw] = nnlinemex(p, q, xvar, yvar); % OΪdz/d(beta)��Ϊ�´μ���M�Ĳ�����׼����DzDwΪdE/dq
    O2 = O; % O2Ϊdz/dc��Ϊ�´μ���C�Ĳ�����׼��
end
end
