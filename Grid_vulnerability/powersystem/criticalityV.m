clc;
define_constants;
mpc = loadcase('case39');
voltage = zeros(2000,1);
initial_PD = mpc.bus(:,PD);
node_load = [];
for k=1:39 %得到负荷节点的索引向量；
    if mpc.bus(k,2) == 1 %负荷节点的type是1；
        node_load = [node_load;mpc.bus(k,1)]; %得到负荷节点的节点名；
    end
end
const = length(node_load);
%统计29各负荷节点
for i = 1:const  
    for j = 1:3000
        mpc.bus(i,PD) = j;
        [MVAbase, bus, gen, branch, success,et] = runpf(mpc);
        
        voltage(j,i) = min(bus(:,VM));
        mpc.bus(i,PD) = initial_PD(i);%恢复原功率值
    end
end
xlswrite('voltage.xlsx',voltage);
xlswrite('critV.xlsx',critV);

% data1 = xlsread('voltage1.xlsx');
% x=linspace(1,2000,2000);
% y = data1;
% plot(x,y);
% xlabel('负荷有功功率（MV）','FontSize',12);
% ylabel('电压幅值（p.u.）','FontSize',12);
% legend ('节点1');
    


















% node_load = [];
% for i=1:39 %得到负荷节点的索引向量；
%     if mpc.bus(i,2) == 1 %负荷节点的type是1；
%         node_load = [node_load;mpc.bus(i,1)]; %得到负荷节点的节点名；
%     end
% end