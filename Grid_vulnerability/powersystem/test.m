
clear; clc;
define_constants;
mpc = loadcase('case14');
N=14;
A=nodeBetween(mpc);
[hehe1,index01]=sort(A);
index=zeros(2,14);
x=[1:1:N];

C=mpc2pr(mpc);
[ju,B]=pagerank(C,0.85,0.001);
[hehe2,index02]=sort(B);
index1=index01';
index2=index02';
index1=[index1;index2];
for i=1:2
    for j=1:N
    index(i,j)=find(index1(i,:)==j);%返回index中非零元素所在位置的序号，升序排列即为权重
    end
end
xlabel('重要性','FontSize',13);
ylabel('节点名','FontSize',13);
t=0:0:0;
set(gca,'xticklabel',{});
barh(x,index');
legend('电气介数','PangRank');


