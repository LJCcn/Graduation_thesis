clear; clc;
define_constants;
mpc = loadcase('case39');
gen_node = 10;
pr = mpc.gen(gen_node,PG);
N=100;
%PD,QD是负荷的有功功率和无功功率；
node_for_compute = mpc.bus(:,1);
node_for_plot = 5;
num=500;%PD、QD变化的点数
result=zeros(length(node_for_compute), num);
result_plot=zeros(length(node_for_plot), num);
result2=zeros(N, num);
result3D1=zeros(num,num);
overLimit = zeros(num,1);
load_node = 3;

pdList = mpc.bus(:,PD);
pd = mpc.bus(load_node,PD);
qd = mpc.bus(load_node,QD);
vm = mpc.bus(load_node,VM)
PDarray1=linspace(0,886,num);
PDarray2=linspace(0,1900,num);
VMarray1=zeros(num,1);
QDarray=linspace(0,qd*500,num);
VMarray2=zeros(num,1);

wind = wblrnd(20,1,N,1);
power = fan(wind,pr);

%无风能接入单个P或者Q的变化对电压的影响
for a=1:num
mpc.bus(load_node,PD)=PDarray2(a);
[MVAbase, bus, gen, branch, success, et] = runpf(mpc);%每次改变PD值重新进行潮流计算
    if success==1 %潮流计算成功时
%     VMarray2(a)=bus(load_node,VM);
    result(:,a)=bus(:,VM);%结果用矩阵保存
    end
end
figure;
xlabel('负荷有功功率(MW)','FontSize',13);
ylabel('电压幅值(p.u.)','FontSize',13);
% xlim([0,2500]);
hold on
grid on;
for j=1:10
result(end,:)=[];
end
result_plot=result([1 3 4 7 12],:);
plot(PDarray2,result_plot);
legend('母线一','母线二','母线三','母线四','母线五','Location','Best');

%无风能接入PQ的同时变化对电压的影响
%[X,Y]=meshgrid(PDarray,QDarray);
% for I=1:num
%     for J=1:num
%         mpc.bus(load_node,PD)=X(I,J);
%         mpc.bus(load_node,QD)=Y(I,J);
%         [MVAbase, bus, gen, branch, success, et] = runpf(mpc);
%         if success ==1
%         result3D1(I,J)=bus(load_node,VM);
%         end
%     end
% end
% surf(X,Y,result3D1);

% %有风能接入
% for i=1:num
% mpc.bus(load_node,PD)=PDarray1(i);
%     for ii=1:length(power)
%         hehe=power(ii);
%         mpc.gen(gen_node,PG) = power(ii);
%         [MVAbase, bus, gen, branch, success, et] = runpf(mpc);
%         if(success==1)
%         result2(ii,i)=bus(load_node,VM);
%         end
%     end
% end
% %风能接入下load_node负荷节点随输入功率变化的平均值
% for m=1:num
%     VMarray1(m)=mean(result2(:,m));
% end
% figure;
% xlabel('负荷有功功率(MW)','FontSize',13);
% ylabel('电压幅值(p.u.)','FontSize',13);
% hold on
% grid on;
% plot(PDarray1,VMarray1);

%风能接入下load_node负荷节点的收敛率随负荷有功功率的变化图
% for m=1:num
%     sum=0;
%     for n=1:N
%         if result2(n,m)==0
%             sum = sum+1;
%         end
%     end
%     overLimit(m)=sum/N;
% end
% plot(PDarray,overLimit);

%风能接入下load_node负荷节点的电压随负荷有功功率的变化图，为0代表潮流不收敛
%plot(PDarray,result2,'*');

%无风能接入的load_node负荷节点的电压随负荷有功功率的变化图，功率已经到了收敛的极限

%plot(PDarray,VMarray);
% legend;
% grid on;
%text(pd,vm,'x');




