function B = filter_base( )
%%%%%%%%%%%%%%%%%%%%DCT base
 config;
 fS = nnconfig.FilterSize ;
 fN = nnconfig.FilterNumber;% 8_lee
 fS_sqrt = fS^2;

 DCT = dctmtx(fS);%使用dctmtx函数实现离散余弦变换，返回fs*fs的DCT变换矩阵lee
 DCT = kron(DCT, DCT);%克罗内克张量积,9*9,lee
 B = zeros(fS_sqrt, fN);
 for i = 2 : fS_sqrt
 B(:, i-1) = DCT(i, :);
 end


end

