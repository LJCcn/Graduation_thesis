% clc;
% data = xlsread('voltage.xlsx');
% x=linspace(1,3000,3000);
% for i=1:6
%     y = data(:,i);
% %     figure(i)
%     plot(x,y);
%     xlabel('负荷有功功率（MV）','FontSize',12);
%     ylabel('电压幅值（p.u.）','FontSize',12);
%     legend ('节点1','节点2','节点3','节点4','节点5','节点6');
%     hold on;
% end
%     


% clc;
% mpc = loadcase('case39');
% initial_P = mpc.bus(:,3); %取额定功率
% data = xlsread('costPloss.xlsx'); %损耗变化数据
% data1 = xlsread('临界功率.xlsx');

% %从额定功率到临界功率增加负荷
% for i =1:29
%     x =linspace(round(initial_P(i))+1,data1(i,2),data1(i,2)-round(initial_P(i)));
%     y = data(:,i);
%     y(find(y==0))=[];
%     figure(1)
%     plot(x,y,'LineWidth',1.5);
%     legend_str{i} = ['节点' num2str(i)];
%     xlabel('负荷有功功率（MV）','FontSize',12);
%     ylabel('电网支路有功损耗（MW）','FontSize',12);  
%     hold on;
% end
% legend (legend_str);

% %从0-额定功率增加负荷
% for i =1:29
%     x =linspace(1,round(initial_P(i)*1.1+1),round(initial_P(i)*1.1+1));
%     y = data(:,i);
%     y(find(y==0))=[];
%     figure(1)
%     plot(x,y,'LineWidth',1.5);
%     legend_str{i} = ['节点' num2str(i)];
%     xlabel('负荷有功功率（MW）','FontSize',12);
%     ylabel('电网支路有功损耗（MW）','FontSize',12);  
%     hold on;
% end
% legend (legend_str);


% %电压稳定裕度归一化处理
% data = xlsread('index1-2.xls');
% max_index = max(data);
% for i = 1:length(data)
%     newdata(i) = max_index - data(i);
% end
% max1 = max(newdata);
% min1 = min(newdata);
% for j = 1:length(newdata)
%     index1(j) = (newdata(j) - min1)./(max1 - min1);
% end
% xlswrite('index1-3.xls',index1');

% 节点1负荷增加其支路的有功损耗变化
% data = xlsread('costbranch1.xlsx');
% x = data(:,1);
% branch1 = data(:,2);
% branch2 = data(:,3);
% subplot(2,1,1);
% figure(1);
% plot(x,branch1,'LineWidth',1.5);
% xlabel('负荷1有功功率（MW）','FontSize',12);
% ylabel('支路有功损耗（MW）','FontSize',12);
% legend ('支路1-2');
% subplot(2,1,2);
% plot(x,branch2,'LineWidth',1.5);
% xlabel('负荷1有功功率（MW）','FontSize',12);
% ylabel('支路有功损耗（MW）','FontSize',12);
% legend ('支路1-39');

%数据拟合
mpc = loadcase('case39');
initial_P = mpc.bus(:,3); %取额定功率
data = xlsread('costP1(pd-3000).xlsx');
for i =1:29
    y = data(:,i);
    y(find(y==0))=[];
end








% node_load = [];
% for i=1:39 %得到负荷节点的索引向量；
%     if mpc.bus(i,2) == 1 %负荷节点的type是1；
%         node_load = [node_load;mpc.bus(i,1)]; %得到负荷节点的节点名；
%     end
% end