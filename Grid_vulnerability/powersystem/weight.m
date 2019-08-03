function value = weight(mpc)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
define_constants;

%% 判断电网的发电节点和负荷节点
G_Bus = find(mpc.bus(:,BUS_TYPE) == 2);
L_Bus = find(mpc.bus(:,BUS_TYPE) == 1);
%% 计算发电节点功率总和
sum_g = sum(mpc.gen(:, PG));
%% 计算负荷节点功率总和
sum_l = sum(mpc.bus(:,PD));
value = zeros(length(G_Bus), length(L_Bus));
    %% 遍历发电机和负荷节点
for i = 1 :length(G_Bus)
    g_idx =find(mpc.gen(:,GEN_BUS) == G_Bus(i));%% 查询发电机节点在 mpc.gen 的 下标 
    for j = 1:length(L_Bus)
        l_idx = find(mpc.bus(:, BUS_I)==L_Bus(j));%% 查询负荷节点在 mpc.bus 的 下标 
        value(i,j) = min(mpc.gen(g_idx, PG)/sum_g, mpc.bus(l_idx,PD)/sum_l); % 计算权重w
    end
end

end

