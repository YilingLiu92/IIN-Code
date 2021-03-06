function net = InitNetSPD ( )
%% Network initialization 
%% network setting
config; 
fN = nnconfig.FilterNumber; 
fS = nnconfig.FilterSize; 
WD = nnconfig.WeightDecay; 
LL = nnconfig.LinearLabel; 
LLA = nnconfig.LinearLabelA; 
stageN = nnconfig.Stage; 
s = fS*fS; 
%% network parameters  
% Filter coefficients
gamma = eye(s-1,fN); 
% penalty parameters
for i = 1:fN 
    Rho(i) = (1e-3) * 20; 
end
Epsilon = 0.2; 
% update rate
for i=1:fN
    Eta(i) = 2;
end
tau = 0.12;
% control points
r = (1 / 20);
linew = zeros(101 , fN , 'double'); 
for i=1:fN
    linew (: , i) = nnsoft (LL, r);
end
u = (1 / 14);
linewa = zeros(101 , fN , 'double'); 
for i=1:fN
    linewa(:,i)  = nnsoft (LLA, u);
end
%% Network structure
net.layers = {};
%the first stage
net.layers{end+1} = struct('type','X_org',...
    'weights',{{ gamma , Rho , Epsilon }},...
    'learningRate', ones(1, 3, 'double'), ...
    'weightDecay', WD, ...
    'momentum', {{0,0,0}});
net.layers{end+1} = struct('type', 'Convo',...
    'weights',{{ gamma }},...
    'learningRate', ones(1, 1, 'double'), ...
    'weightDecay', WD, ...
    'momentum', {{0}});
net.layers{end+1} = struct('type', 'Non_linorg',...
    'weights',{{linew}},...
    'learningRate', ones(1, 1, 'double'), ...
    'weightDecay', WD, ...
    'momentum', {{0}});
net.layers{end+1} = struct('type', 'T_org',...
    'weights',{{linewa}},...
    'learningRate', ones(1, 1, 'double'), ...
    'weightDecay', WD, ...
    'momentum', {{0}});
net.layers{end+1} = struct('type', 'P_org',...
    'weights',{{tau}},...
    'learningRate', ones(1, 1, 'double'), ...
    'weightDecay', WD, ...
    'momentum', {{0}});
net.layers{end+1} = struct('type', 'Multi_org',...
    'weights',{{Eta}},...
    'learningRate', ones(1, 1, 'double'), ...
    'weightDecay', WD, ...
    'momentum', {{0}});
%the middle stages
for i = 1:1:stageN-2
    net.layers{end+1} = struct('type', 'X_mid',...
        'weights',{{ gamma,Rho,Epsilon }},...
        'learningRate', ones(1, 3, 'double'), ...
        'weightDecay', WD, ...
        'momentum', {{0,0,0}});
    net.layers{end+1} = struct('type', 'Convo',...
        'weights',{{ gamma }},...
        'learningRate', ones(1, 1, 'double'), ...
        'weightDecay', WD, ...
        'momentum', {{0}});
    net.layers{end+1} = struct('type', 'Non_linmid',...
        'weights',{{linew}},...
        'learningRate', ones(1, 1, 'double'), ...
        'weightDecay', WD, ...
        'momentum', {{0}});
    net.layers{end+1} = struct('type', 'T_mid',...
        'weights',{{linewa}},...
        'learningRate', ones(1, 1, 'double'), ...
        'weightDecay', WD, ...
        'momentum', {{0}});
    net.layers{end+1} = struct('type', 'P_mid',...
        'weights',{{tau}},...
        'learningRate', ones(1, 1, 'double'), ...
        'weightDecay', WD, ...
        'momentum', {{0}});
    net.layers{end+1} = struct('type', 'Multi_mid',...
        'weights',{{Eta}},...
        'learningRate', ones(1, 1, 'double'), ...
        'weightDecay', WD, ...
        'momentum', {{0}});
end
%the final stage
net.layers{end+1} = struct('type', 'X_mid',...
    'weights',{{ gamma,Rho,Epsilon }},...
    'learningRate', ones(1, 3, 'double'), ...
    'weightDecay', WD, ...
    'momentum', {{0,0,0}});
net.layers{end+1} = struct('type', 'Convo',...
    'weights',{{ gamma }},...
    'learningRate', ones(1, 1, 'double'), ...
    'weightDecay', WD, ...
    'momentum', {{0}});
net.layers{end+1} = struct('type', 'Non_linmid',...
    'weights',{{linew}},...
    'learningRate', ones(1, 1, 'double'), ...
    'weightDecay', WD, ...
    'momentum', {{0}});
net.layers{end+1} = struct('type', 'T_mid',...
    'weights',{{linewa}},...
    'learningRate', ones(1, 1, 'double'), ...
    'weightDecay', WD, ...
    'momentum', {{0}});
net.layers{end+1} = struct('type', 'P_final',...
    'weights',{{tau}},...
    'learningRate', ones(1, 1, 'double'), ...
    'weightDecay', WD, ...
    'momentum', {{0}});
net.layers{end+1} = struct('type', 'Multi_final',...
    'weights',{{Eta}},...
    'learningRate', ones(1, 1, 'double'), ...
    'weightDecay', WD, ...
    'momentum', {{0}});
net.layers{end+1} = struct('type', 'X_final',...
    'weights',{{ gamma,Rho,Epsilon }},...
    'learningRate', ones(1, 3, 'double'), ...
    'weightDecay', WD, ...
    'momentum', {{0,0,0}});
% loss layer
net.layers{end+1}.type = 'loss';
end