function [ output_args ] = NodeBetween( G, node )
%NodeBetween 节点介数
%   此处显示详细说明
node_count=0;
count = 0;
for i=1:G.numnodes
    for j=1:G.numnodes
        if i == j
            continue
        end
        sp = shortestpath(G,i,j);
        if find(sp == node)
            node_count = node_count+1;
        end
        count = count+1;
    end
end
output_args = node_count/count;
end

