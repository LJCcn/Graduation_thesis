function value = nodeBetween(mpc,node_idx)
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
define_constants;

if nargin == 1
    node_idx = mpc.bus(:,1); %[1-39]的节点名名称        
end
%% 判断电网的发电节点和负荷节点
G_Bus = find(mpc.bus(:,BUS_TYPE) == 2);
L_Bus = find(mpc.bus(:,BUS_TYPE) == 1);


edgeBet = mpc.branch(:,[F_BUS,T_BUS]); %得到节点的连接情况
edgeBet=[edgeBet,zeros(length(edgeBet),1)]; %加全零列
edgeBet(:,3) = edgeBetween(mpc); %调用edgeBetween函数，在第三列得到支路电气介数

w = weight(mpc);

value = zeros(length(node_idx),1);

for idx = 1:length(node_idx)
    
    for i = 1:length(edgeBet) % 求每个idx节点的支路电气介数
        if edgeBet(i,1) == node_idx(idx)
            value(idx) = value(idx) + edgeBet(i,3); %与节点idx相连的支路的电气介数和
        end
        if edgeBet(i,2) == node_idx(idx)
            value(idx) = value(idx) + edgeBet(i,3);
        end
    end
    if mpc.bus(node_idx(idx),BUS_TYPE) == 1 %求idx负荷节点电气介数
        j = find(L_Bus == node_idx(idx)); %求负荷节点的下标
        value(idx) = (value(idx) + sum(w(:,j)))/2;
    elseif mpc.bus(node_idx(idx),BUS_TYPE) == 2 %%求idx发电节点电气介数
        i = find(G_Bus == node_idx(idx));
        value(idx) = (value(idx) + sum(w(i,:)))/2;
    else
        value(idx) = value(idx)/2;
    end
end 


