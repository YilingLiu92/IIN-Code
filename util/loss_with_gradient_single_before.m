function [ loss, real_x ] = loss_with_gradient_single_before( data, net )
train = data.train; % Ƿ�������K�ռ�
label = data.label; % �������Աȵ�ԭͼ
LL = double(-1:0.02:1); % ��ʽ��8���е� p
LLA = double(-1:0.02:1);
N = numel(net.layers); % ���������32
res = struct(...
    'x',cell(1,N+1),...
    'dzdx',cell(1,N+1),...
    'dzdw',cell(1,N+1)); % �ֱ���71���յ�cell��BASIC-ADMM��ֻ�С�x����һ���õ���
res(1).x = train; % ��Ƿ�������K�ռ�ŵ���һ�е�x�ĵ�һ����ǻ��
%% forward propagation 
for n = 1:N %1-32
    l = net.layers{n};
    switch l.type
       case 'X_org' % layer_2 
            res(n+1).x = xorg (res(n).x , l.weights{1} , l.weights{2} , l.weights{3});
        case 'Convo' % layer_3,9,15,21,27
            res(n+1).x = convo(res(n).x , l.weights{1});
        case 'Non_linorg' % layer_4
            res(n+1).x = zorg( LL ,res(n).x , l.weights{1});
        case 'T_org' % layer_5
            res(n+1).x = torg( LLA ,res(n-2).x ,res(1).x , l.weights{1});
        case 'P_org' % layer_6
            res(n+1).x = porg(res(n-3).x , res(n).x ,res(1).x ,l.weights{1} );
        case 'Multi_org' % layer_7
            res(n+1).x = betaorg(res(n-3).x ,res(n-2).x , l.weights{1} );
        case 'X_mid' % layer_8,14,20,26
            res(n+1).x = xmid(res(n-3).x , res(n).x, res(n-2).x ,res(n-1).x , res(1).x , l.weights{1} , l.weights{2},l.weights{3});
        case 'Non_linmid' % layer_10,16,22,28 
            res(n+1).x = zmid(LL, res(n-2).x , res(n).x , l.weights{1} );
        case 'T_mid' % layer_11,17,23,29
            res(n+1).x = tmid( LLA ,res(n-2).x ,res(n-4).x , res(1).x , l.weights{1});
        case 'P_mid' % layer_12,18,24
            res(n+1).x = pmid(res(n-5).x , res(n).x ,res(n-3).x , res(1).x ,l.weights{1} );
        case 'Multi_mid' % layer_13,19,25
            res(n+1).x = betamid(res(n-5).x , res(n-3).x , res(n-2).x ,l.weights{1}); 
        case 'P_final' % layer_30 
            res(n+1).x = pfinal(res(n-5).x ,  res(n).x ,res(n-3).x ,res(1).x ,l.weights{1} );
        case 'Multi_final' % layer_31
            res(n+1).x = betafinal(res(n-5).x , res(n-3).x , res(n-2).x ,l.weights{1});
        case 'X_final' % layer-32 
            res(n+1).x = xfinal(res(n-3).x , res(n).x, res(n-2).x ,res(n-1).x , res(1).x , l.weights{1} , l.weights{2},l.weights{3});        
        case 'loss' %  ��ʽ��11�����������һ������x��ԭͼ��NMSEֵ layer_33
            res(n+1).x = rnnloss(res(n).x, label);% ����NMSE���ָ�ͼ��ԭͼ�ľ����0.1574
        otherwise
            error('No such layers type.'); 
    end
end;
    loss = res(end).x;
    loss = double(loss); % NMSE
    real_x = res(end-1).x;  % �������ؽ���ͼ����real_x    
end
