function [ C ] = ACC( G )
%ACC 平均聚类系数
%   平均聚类系数
sum=0;
for i = 1:G.numnodes
    N = neighbors(G,i);
    n_count = length(N);
    t = 0;
    for m = 1:(n_count-1)
        for n = m+1:n_count
            edge = findedge(G,N(m),N(n));
            if edge ~= 0
                t= t + 1;
            end
        end
    end
    if n_count == 1
        c=0;
    else
        c = 2*t/(n_count*(n_count-1));
    end
    sum = sum+c;
end
C=sum/G.numnodes;
end

