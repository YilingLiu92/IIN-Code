function name = saveName(n, l)%(1,2)
name = num2str(n);%数值n=1转换成字符串'1'
for i=1:l-length(name)
    name = ['0' name];%[01]
end
end
