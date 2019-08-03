% 节点 度 分布
function NDD( G )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
d = degree(G);
d_unique = sort(unique(d));
d_unique
y=zeros(length(d_unique));
for i=1:length(d_unique)
    num = sum(d>=d_unique(i));
    y(i)=num/length(d);
end
plot(d_unique,y);
