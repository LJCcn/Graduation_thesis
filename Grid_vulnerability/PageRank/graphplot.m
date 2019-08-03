mpc = loadcase('case39');
[B,A]=mpc2pr(mpc);
X=[];
Y=[];
[m,n]=size(A);
for i=1:m
    for j=1:n
        if A(i,j)~=1&A(i,j)~=0
            X=[X,i];%得到为1元素的行索引
            Y=[Y,j];%得到列索引
        end
    end
end
%画有向图
figure(1)
G = digraph(X,Y);
plot(G,'Layout','force');
t=0:0:0;
set(gca,'xtick',t);
set(gca,'ytick',t);
% %画基于电气介数权重的网络拓扑
% weight=edgeBetween(mpc);
% figure(2)
% G2 = graph(X,Y,weight);
% LWidths = 5*G2.Edges.Weight/max(G2.Edges.Weight);
% plot(G2,'LineWidth',LWidths)
% t=0:0:0;
% set(gca,'xtick',t);
% set(gca,'ytick',t);