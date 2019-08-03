clc;
define_constants;
P1 = zeros(39,1);
P2 = zeros(39,1);
P3 = zeros(39,1);

data1 = xlsread("stric_index.xls","A1");%电气介数归一化数据
data2 = xlsread("stric_index.xls","B1");%电气度归一化数据
data3 = xlsread("stric_index.xls","C1");%PageRank值归一化数据
A = data1(:,3);
B = data2(:,3);
C = data3(:,3);
sumA = sum(A);
sumB = sum(B);
sumC = sum(C);
%计算每个节点指标值在总和中的比重；
for i = 1:39
    P1(i) = A(i)./sumA;
    P2(i) = B(i)./sumB;
    P3(i) = C(i)./sumC;
end
sum_sh1=0;
sum_sh2=0;
sum_sh3=0;
for k = 1:29
    sum_sh1 = sum_sh1 + P1(k)*log(P1(k));
    sum_sh2 = sum_sh2 + P2(k)*log(P2(k));
    sum_sh3 = sum_sh3 + P3(k)*log(P3(k));
end
    e(1) = -1./log(39)*(-2.5096);
    e(2) = -1./log(39)*(-2.7293);
    e(3) = -1./log(39)*(-2.9402);
for j = 1:3
    w(j) = (1-e(j))./sum(1-e);
end
% xlswrite('stric_index.xls',w,'D1')


% %对熵权法进行改进，异常数据进行处理：
% data1 = xlsread("stric_index.xls","A1");%电气介数归一化数据
% data2 = xlsread("stric_index.xls","B1");%电气度归一化数据
% data3 = xlsread("stric_index.xls","C1");%PageRank值归一化数据
% %计算平移值：
% A = data1(:,2);
% B = data2(:,2);
% C = data3(:,2);
% sumA = sum(A);
% sumB = sum(B);
% sumC = sum(C);
% meansA = mean(A)
% meansB = mean(B)
% meansC = mean(C)
% A1 = 0;
% B1 = 0;
% C1 = 0;
% for i = 1:39
%     A1 = A1+(A(i)-meansA)^2;
%     B1 = B1+(B(i)-meansB)^2;
%     C1 = C1+(C(i)-meansC)^2;
% end
% a = data1(:,3);
% b = data2(:,3);
% c = data3(:,3);
% sumA1 = sum(a);
% sumB1 = sum(b);
% sumC1 = sum(c);
% meansA1 = mean(a)
% meansB1 = mean(b)
% meansC1 = mean(c)
% A2 = 0;
% B2 = 0;
% C2 = 0;
% for i = 1:39
%     A2 = A2+(a(i)-meansA1)^2;
%     B2 = B2+(b(i)-meansB1)^2;
%     C2 = C2+(c(i)-meansC1)^2;
% end
% %信息损失率
% a1 = A2./A1
% a2 = B2./B1
% a3 = C2./C1  

    



    
