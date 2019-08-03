function [A,ek]=pagerank(p,d,e)
%p:连接矩阵
%d:分配分数
%e:误差值
x=sum(p,2);%包含每一行总和的列向量
n=size(p,1);
for i=1:n
    if x(i)~=0
    p(i,:)=p(i,:)/x(i);
    end
end
%概率转移矩阵
p=p';
o=ones(n);
A=d*p+(1-d)*o/sum(sum(p'))%转移概率矩阵
e0=ones(n,1);
ek=zeros(n,1);
s=norm(e0-ek);%计算欧式距离
i=0;
%幂法迭代，求PR值
while(s>e)
    ek=A*e0;
    s=norm(e0-ek);
    e0=ek;
    i=i+1;
end
disp(['迭代次数为',num2str(i),'次','误差为',s]);
disp(['最后的Rank结果为：']);
ek
end

