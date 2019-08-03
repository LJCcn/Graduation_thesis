clear; clc;
mpc = loadcase('case118');
N=118;

node_load=[];
node_gen_non0=[];%P不为0的发电节点索引
for i=1:118%得到负荷节点的索引向量
    if mpc.bus(i,2) == 1%负荷节点的type是1
        node_load = [node_load;mpc.bus(i,1)];
    end
end
for i=1:length(mpc.gen(:,1))%得到P不为0的发电节点的索引向量
    if mpc.gen(i,2)~=0
        node_gen_non0=[node_gen_non0;i];
    end
end
temp=[];
index_status=[];
index_status=VunlerableAnaly118(node_load,node_gen_non0);
% for i=1:length(node_gen_non0)
%     temp = [temp;node_gen_non0(20-i)];
%     index_status = [index_status;VunlerableAnaly118(node_load,temp)];
% end
xlswrite('118脆弱性指标',index_status,'状态脆弱性指标','V1155');

% index_fabric = zeros(N,4);
% valueDu = electricDu(mpc); %电气度结果
% [a1,duIndex]=sort(valueDu);
% weight = linspace(0,1,N);
% 
% valueNodeB = nodeBetween(mpc);
% [a2,nodeIndex]=sort(valueNodeB);
% 
% A=mpc2pr(mpc);
% [B,ek]=pagerank(A,0.85,0.001);
% [a3,rankIndex]=sort(ek);
% 
% for i=1:N
%     index_fabric(duIndex(i),1)=weight(i);
%     index_fabric(nodeIndex(i),2)=weight(i);
%     index_fabric(rankIndex(i),3)=weight(i);    
% end
% 
% index_fabric(:,4)=0.2599.*index_fabric(:,1)+0.4126.*index_fabric(:,2)+0.3275.*index_fabric(:,3);
% xlswrite('118脆弱性指标',index_fabric,'结构脆弱性指标','B2')

% node_idx = mpc.gen(:,1);
% for i = 1:length(node_idx)
% %     if mpc.bus(i,2) == 2%负荷节点的type是1
%         index_status = [index_status;mpc.gen(i,1) mpc.gen(i,2)]
% %     end
% end
% xlswrite('118model',index_status,'Sheet1','H2');
