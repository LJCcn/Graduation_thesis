clc;
define_constants;
mpc = loadcase('case39');
node_load = [];
N = 10000; %负荷功率改变次数
for i=1:39 %得到负荷节点的索引向量；
    if mpc.bus(i,2) == 1 %负荷节点的type是1；
        node_load = [node_load;mpc.bus(i,1)]; %得到负荷节点的节点名；
    end
end
const = length(node_load); % node_load为负荷的节点名
standV = zeros(const,1);
V_up = zeros(const,1);
V_down = zeros(const,1);
marg = zeros(const,1);
[MVAbase, bus, gen, branch, success, et] = runpf(mpc); %初始化潮流计算

%额定状态各节点的电压的向量
for j=1:length(standV)
    standV(j) = bus(node_load(j),VM); %额定状态各节点的电压的向量
    V_down(j) = standV(j)*0.9; %电压下线
    V_up(j) = standV(j)*1.1; %电压上线
    marg(j) = standV(j)*0.1; %电压区间
end

result1 = zeros(const,N);
result2 = zeros(const,N);
initialPQ = zeros(const,2);%获取负荷节点的额定PQ

%初始状态下的P、Q值
for j=1:const
   initialPQ(j,1) = mpc.bus(node_load(j),PD);
   initialPQ(j,2) = mpc.bus(node_load(j),QD);
end

%初始化负荷模型
loadP = zeros(const,N);
loadQ = zeros(const,N);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j=1:const %随机负荷节点功率模型
    loadP(j,:)=normrnd(initialPQ(j,1),abs(initialPQ(j,1)*0.2),N,1);%入参分别是 均值、标准差、mxn维；
    loadQ(j,:)=normrnd(initialPQ(j,2),abs(initialPQ(j,2)*0.2),N,1);
end

%随机负荷PQ同时加入得到29*N的result
for i=1:N
%      mpc.bus(node_load(1),PD)=loadP(1,i);
%      mpc.bus(node_load(1),QD)=loadQ(1,i);
    %所有负荷节点都变化
    for k=1:const
    mpc.bus(node_load(k),PD)=loadP(k,i);
    mpc.bus(node_load(k),QD)=loadQ(k,i);
    end

    [MVAbase, bus, gen, branch, success, et] = runpf(mpc);
    for j=1:const
%         if(success==1)
%             result1(j,i)=abs(bus(node_load(j),VM)-standV(j))./standV(j);%电压的偏差百分比
            
            if and((bus(node_load(j),VM) >= standV(j)),(bus(node_load(j),VM) < V_up(j)))
                result2(j,i)= vpa((V_up(j) - bus(node_load(j),VM))./marg(j),12);
            if (bus(node_load(j),VM)>=V_up(j))
                result2(j,i) = 0;
            if and(bus(node_load(j),VM) <= standV(j),bus(node_load(j),VM)>V_down(j))
                result2(j,i)= vpa((bus(node_load(j),VM)- V_down(j))./marg(j),12);
            if (bus(node_load(j),VM)<=V_down(j))
                result2(j,i) = 0;
            end
            end
            end
            end        
    end  
end
% result1
result2;
%result
%指标一：电压越线率(电压偏差超过5%或者潮流不收敛了，此时都是脆弱域的)
% index1=zeros(const,1);
% for j=1:const
%     for i=1:N
%         if result1(j,i)>=0.05|result1(j,i)==0
%             index1(j)=index1(j)+1;
%         end
%     end
% end
% index1=index1./N
%指标二：电压稳定裕度(潮流收敛的电压偏差的期望)
index2=zeros(const,1);
for j=1:const
    index2(j) = sum(result2(j,:))./N;
end
xlswrite('index1-2.xls',index2);
% %指标三：方差(潮流收敛的电压偏差的方差)
% index3=zeros(const,1);
% for j=1:const
%     initialV1 = result(j,:);
%     Non0V1 = initialV1(initialV1~=0);
%     index3(j)=var(Non0V1,1); %var是误差的平方和除以N,var第二个参数代表N(1)或N-1(0)
% end
% index3
% %状态脆弱性：
% index=zeros(const,4);
% index(:,1)=index1;
% index(:,2)=index2;
% index(:,3)=index3;
% 
% index(:,4)=0.5396*index1+0.2970*index2+0.1634*index3;
% 
% end





