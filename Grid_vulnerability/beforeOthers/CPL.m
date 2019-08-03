% characteristic path length 特征路径长度
function [ L ] = CPL( G )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
sum = 0;
for i=1:(G.numnodes-1)
   for j=i+1:G.numnodes
       if i == j
           continue;
       end
       [~,d] = shortestpath(G,i,j);
       sum = sum+d;
   end
end
L=sum/(G.numnodes*(G.numnodes-1))*2;
end

