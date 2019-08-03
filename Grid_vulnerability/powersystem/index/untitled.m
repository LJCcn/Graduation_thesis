clc;
%结构指标写入表格
define_constants;
mpc = loadcase('case39');
% index1 = nodeBetween(mpc);
% xlswrite('stric_index.xls',index1,'A1');
% 
% index2 = electricDu(mpc);
% xlswrite('stric_index.xls',index2,'B1');
% 
% A=mpc2pr(mpc);
% [B,ek]=pagerank(A,0.85,0.001);
% index3 = ek;
% xlswrite('stric_index1.xls',index3,'C1');

% % 归一化结构指标[0.1]
% data1 = xlsread('stric_index.xls','C1')
% data_min = min(data1)
% data_max = max(data1)
% for i = 1:length(data1)
%     index1_1(i) = (data1(i)-data_min)./(data_max-data_min)
% end
%  xlswrite('stric_index.xls',index1_1','C1','B1');

%归一化结构指标[0.002,0.998]
data1 = xlsread('stric_index.xls','C1');
data_min = min(data1(:,1));
data_max = max(data1(:,1));
for i = 1:length(data1)
    index1_1(i) = 0.996*((data1(i)-data_min)./(data_max-data_min))+0.002;
end
 xlswrite('stric_index.xls',index1_1','C1','C1');

% %归一化灵敏度指标
% data1 = xlsread('index_sense.xlsx')
% data_min = min(data1)
% data_max = max(data1)
% for i = 1:length(data1)
%     index1_1(i) = (data1(i)-data_min)./(data_max-data_min)
% end
%  xlswrite('state_index.xls',index1_1','sheet1','B1');


