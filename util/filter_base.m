function B = filter_base( )
%%%%%%%%%%%%%%%%%%%%DCT base
 config;
 fS = nnconfig.FilterSize ;
 fN = nnconfig.FilterNumber;% 8_lee
 fS_sqrt = fS^2;

 DCT = dctmtx(fS);%ʹ��dctmtx����ʵ����ɢ���ұ任������fs*fs��DCT�任����lee
 DCT = kron(DCT, DCT);%�����ڿ�������,9*9,lee
 B = zeros(fS_sqrt, fN);
 for i = 2 : fS_sqrt
 B(:, i-1) = DCT(i, :);
 end


end

