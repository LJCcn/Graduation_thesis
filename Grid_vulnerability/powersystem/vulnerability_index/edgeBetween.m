function value = edgeBetween(mpc, br_idx)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
%% default arguments

define_constants;
if nargin == 1
    br_idx = 1:size(mpc.branch,1); %边的个数      
end

%% 判断电网的发电节点和负荷节点
G_Bus = find(mpc.bus(:,BUS_TYPE) == 2);%2为发电节点
L_Bus = find(mpc.bus(:,BUS_TYPE) == 1);%1为负荷节点
%% 计算发电节点功率总和
sum_g = sum(mpc.gen(:, PG));
%% 计算负荷节点功率总和
sum_l = sum(mpc.bus(:,PD));
%% 初始潮流计算结果
[~, ~, ~, init_branch, ~, ~] = runpf(mpc);

value = zeros(length(br_idx),1); %生成一列全零阵  
%% 分别计算 br_idx 边的电气介数
for idx = 1:length(br_idx)
    %% 初始 边 传递的功率
    init_trans_power = init_branch(br_idx(idx), PF);
    %% 初始化边的电气介数
    result = 0;
    %% 遍历发电机和负荷节点
    for i = 1 :length(G_Bus)
        g_idx =find(mpc.gen(:,GEN_BUS) == G_Bus(i));%% 查询发电机节点在 mpc.gen 的 下标 
        init_pg = mpc.gen(g_idx, PG); % 记录 g_idx 的初始功率
        %mpc.gen(g_idx, PG) = init_pg +1;  % 发电 g_idx 机功率 ＋1 
        for j = 1:length(L_Bus) %计算每一个发电节点与负荷节点边的电气介数
            l_idx = find(mpc.bus(:, BUS_I)==L_Bus(j)); % 查询负荷节点在 mpc.bus 的 下标 
            w = min(mpc.gen(g_idx, PG)/sum_g, mpc.bus(l_idx,PD)/sum_l); % 计算发电和负荷节点的权重w

            init_pd = mpc.bus(l_idx, PD); % 记录 l_idx 的初始功率
            mpc.gen(g_idx, PG) = init_pg +1;  % 发电 g_idx 机功率 ＋1 
            mpc.bus(l_idx, PD) = init_pd +1; % 负荷节点 l_idx 功率 ＋1 
            [~, ~, ~, branch, ~, ~] = runpf(mpc); %计算变化后的电网
            P = branch(br_idx(idx), PF) - init_trans_power; % br_idx 上的传输功率变化
            result = result + w*P;
            mpc.bus(l_idx, PD) = init_pd; % 恢复l_idx初始功率,计算下一个
            mpc.gen(g_idx, PG) = init_pg; % 恢复g_idx初始功率，计算下一个
        end
        
    end
    value(idx) = abs(result);
end
end

