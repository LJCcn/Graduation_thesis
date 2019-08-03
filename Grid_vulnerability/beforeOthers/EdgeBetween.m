function [ output_args ] = EdgeBetween( G, s )
%EdgeBetween 边介数
%   此处显示详细说明
if nargin==2
    edge = s;
elseif nargin == 3
%     edge = findedge(G,s,t);
%     if edge ==0 
%         error(message('两节点之间无边'));
%     end
else
    error(message('参数错误'));
end
edge_count = 0;
count =0;
for i=1:G.numnodes
    for j=1:G.numnodes
        if i == j
            continue
        end
        sp = shortestpath(G,i,j);
        for n = 1:(length(sp)-1)
            if edge == findedge(G,sp(n),sp(n+1))
                edge_count = edge_count+1;
            end
        end
        count = count +1;
    end
end
output_args = edge_count/count;
end

