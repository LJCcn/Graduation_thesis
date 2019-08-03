% clc;
% define_constants;
% mpc = loadcase('case39');
% initial_PD = mpc.bus(:,3);
% data = xlsread("cost0.1_P.xlsx");
% % for i = 1:29
% %     x = linspace(initial_PD(i)*0.9,initial_PD(i)*1.1,100);
% %     y = data(:,i);
% %     figure(1)
% %     plot(x,y,'LineWidth',1.5);
% % %     legend_str{i} = ['节点' num2str(i)];
% %     xlabel('负荷有功功率（MW）','FontSize',12);
% %     ylabel('电网支路有功损耗（MW）','FontSize',12);  
% %      hold on;
% % end
% % % legend (legend_str)
% x = linspace(initial_PD(1)*0.9,initial_PD(1)*1.1,100);
% y = data(:,1);
% subplot(2,2,1)
% plot(x,y,'LineWidth',1.5);
% xlabel('负荷有功功率（MW）','FontSize',12);
% ylabel('电网支路有功损耗（MW）','FontSize',12);
% 
% x = linspace(initial_PD(3)*0.9,initial_PD(3)*1.1,100);
% y = data(:,3);
% subplot(2,2,2)
% plot(x,y,'LineWidth',1.5);
% xlabel('负荷有功功率（MW）','FontSize',12);
% ylabel('电网支路有功损耗（MW）','FontSize',12);
% 
% x = linspace(initial_PD(4)*0.9,initial_PD(4)*1.1,100);
% y = data(:,4);
% subplot(2,2,3)
% plot(x,y,'LineWidth',1.5);
% xlabel('负荷有功功率（MW）','FontSize',12);
% ylabel('电网支路有功损耗（MW）','FontSize',12);
% 
% x = linspace(initial_PD(9)*0.9,initial_PD(9)*1.1,100);
% y = data(:,9);
% subplot(2,2,4)
% plot(x,y,'LineWidth',1.5);
% xlabel('负荷有功功率（MW）','FontSize',12);
% ylabel('电网支路有功损耗（MW）','FontSize',12);

clc;
data = xlsread("state_index.xls");
y = data(:,1);                        %电压稳定裕度和灵敏度
x = linspace(1,29,29);
bar(x,y)
xlabel('节点名','FontSize',12);
ylabel('节点灵敏度值','FontSize',12);
legend ('灵敏度值');