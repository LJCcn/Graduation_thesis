clc;clear;
load('Data\case14.mat')
branch = Net0.Branch;
s=branch(:,2)';
t=branch(:,3);
G=graph(s,t);
N=numedges(G)
plot(G,'-or');
