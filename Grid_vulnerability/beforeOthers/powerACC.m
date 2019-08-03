function value = powerACC(mpc)
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
define_constants;
branch = mpc.branch(:,[F_BUS,T_BUS]);
G=graph(branch(:,1),branch(:,2));
weight = edgeBetween(mpc);
sum=0;
for i = 1:G.numnodes
    N = neighbors(G,i);
    n_count = length(N);
    weightBt = [];
    t = 0;
    for m = 1:(n_count-1)
        for n = m+1:n_count
            edge = findedge(G,N(m),N(n));
            if edge ~= 0
                t= t + 1;
                weightBt=[weightBt,weight(edge)];
            end
        end
    end
    if isempty(weightBt)
        w=0;
    else
    w=std(weightBt);
    end
    if n_count == 1
        c=0;
    else
        c = 2*t/(n_count*(n_count-1))*w;
    end
    sum = sum+c;
end
value=sum/G.numnodes;
end

