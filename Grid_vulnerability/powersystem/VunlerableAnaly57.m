function [index] = VunlerableAnaly57(node_load,genVector)
define_constants;
% mpc = loadcase(strcat('case',num2str(caseNum)));
mpc = loadcase('case57');
const = length(node_load);%（node_load为负荷的节点名）代替原来系统的29的，118系统的负荷节点的数目是64；
standV=zeros(const,1);
[MVAbase, bus, gen, branch, success, et] = runpf(mpc);
for j=1:length(standV)
standV(j)=bus(node_load(j),VM);%额定状态各节点的电压的向量
end

N=10000;%风机功率变化的点数也是PD、QD变化的点数
power = zeros(length(genVector),N);
for i = 1:length(genVector)
    pr = mpc.gen(genVector(i),PG);
    wind = wblrnd(20,1,N,1);%%第一个是lemda;第二是k
    power(i,:) = fan(wind,pr);
end

result=zeros(const,N);
initialPQ = zeros(const,2);%获取负荷节点的额定PQ
for j=1:const
   initialPQ(j,1) = mpc.bus(node_load(j),PD);
   initialPQ(j,2) = mpc.bus(node_load(j),QD);
end
loadP = zeros(const,N);
loadQ = zeros(const,N);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j=1:const %随机负荷节点功率模型
    loadP(j,:)=normrnd(initialPQ(j,1),abs(initialPQ(j,1)*0.2),N,1);%入参分别是 均值、标准差、mxn维；
    loadQ(j,:)=normrnd(initialPQ(j,2),abs(initialPQ(j,2)*0.2),N,1);
end

%随机风电功率和随机负荷PQ同时加入得到29*N的result
for i=1:N
    for j=1:const
    mpc.bus(node_load(j),PD)=loadP(j,i);
    mpc.bus(node_load(j),QD)=loadQ(j,i);
    end
    for j=1:length(genVector)
        mpc.gen(genVector(j),PG) = power(j,i);
    end 
    [MVAbase, bus, gen, branch, success, et] = runpf(mpc);
    for j=1:const 
        if(success==1)
            result(j,i)=abs(bus(node_load(j),VM)-standV(j))./standV(j);%电压的偏差
        end
    end  
end
result
%指标一：越线率(电压偏差超过5%或者潮流不收敛了，此时都是脆弱域的)
index1=zeros(const,1);
for j=1:const
    for i=1:N
        if result(j,i)>=0.05|result(j,i)==0
            index1(j)=index1(j)+1;
        end
    end
end
index1=index1./N
%指标二：期望(潮流收敛的电压偏差的期望)
index2=zeros(const,1);
for j=1:const
    initialV = result(j,:);
    Non0V = initialV(initialV~=0);
    index2(j)=mean(Non0V);
end
index2
%指标三：方差(潮流收敛的电压偏差的方差)
index3=zeros(const,1);
for j=1:const
    initialV1 = result(j,:);
    Non0V1 = initialV1(initialV1~=0);
    index3(j)=var(Non0V1,1); %var是误差的平方和除以N,var第二个参数代表N(1)或N-1(0)
end
index3
%状态脆弱性：
index=zeros(const,4);
index(:,1)=index1;
index(:,2)=index2;
index(:,3)=index3;

index(:,4)=0.5396*index1+0.2970*index2+0.1634*index3;

end





