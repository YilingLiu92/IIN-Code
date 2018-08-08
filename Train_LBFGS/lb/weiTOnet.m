function net = weiTOnet(wei)
%% This operation transforms the weight vector to the network.
net = InitNetSPD ();
N = length(net.layers);%N=32
id = 0;
for n = 1:N
    l = net.layers{n};
    if isfield(l, 'weights')
        for i = 1:length(l.weights)% 1-3
            idp = id + numel(l.weights{i});
            weitemp = wei(id+1:idp);%赋值与临时变量weitemp
            net.layers{n}.weights{i} = reshape(weitemp, size(l.weights{i}));
%返回size为l.weight{i}矩阵， 矩阵元素是按列从weitemp中得到的
            id = idp;
        end
    end
end
end