function  wei = netTOwei(net)
%% This operation transforms the network to a weight vector
wei = [];
N = length(net.layers); % 32
for n = 1:N
    if isfield(net.layers{n}, 'weights')% 只有31层中存在“weights”，最后一层是“loss”
        for i = 1:length(net.layers{n}.weights) % 将每一层里面要训练的参数转换为列向量都放到一列中
            weight = net.layers{n}.weights{i};
            wei = [wei;weight(:)]; 
        end
    end
end % 5*(X(gamma_8*8+rho_8+Epsilon_1)+C(8*8)+Z(q_101*8)+T(v_101*8)+P(tau_1)+M(eta_8))+X_OUTPUT(8*8+8+1)= 8883
end
