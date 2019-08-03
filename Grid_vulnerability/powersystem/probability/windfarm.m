clear; clc;
define_constants;
mpc = loadcase('case39');

gen_node = 10;%IEEE39的只有发电节点为10的时候才有电压过载率；为2，1，3都没有。
pr = mpc.gen(gen_node,PG);
[MVAbase, bus, gen, branch, success, et] = runpf(mpc);
standV=bus(:,VM);
N=5000;
%第一个是lemda;第二是k
wind = wblrnd(20,1,N,1);
%wblplot(Wind);
y1 = wblpdf(wind, 20,2);
% plot(wind,y1,'.');
power = fan(wind,pr);
% [y,x]=hist(power,10); 
% y=y/length(power)/mean(diff(x));
% figure(2);
% bar(x,y,1); 
node_for_compute = mpc.bus(:,1);

result = zeros(length(node_for_compute), length(power));
for i = 1:length(power)
    mpc.gen(gen_node,PG) = power(i);
%       mpc.gen(gen_node,PG) = 0;
    [MVAbase, bus, gen, branch, success, et] = runpf(mpc);   
    diffV=abs(bus(:,VM)-standV);
    frac=diffV./standV;
    result(:,i) = frac; %电压偏差率
end
% plot(wind,result)
prob = zeros(length(node_for_compute),1);
average = zeros(length(node_for_compute),1); %初始化电压偏差的均值
variance = zeros(length(node_for_compute),1); %初始化电压偏差的方差
for j = 1:length(node_for_compute) %统计电压越线率
    overLimit=0;
    for jj = 1:length(power)
        if result(j,jj)>0.05
            overLimit=overLimit+1;
        end
    end
    prob(j)=overLimit./length(power);
    average(j)=mean(result(j,:));
    variance(j)=var(result(j,:));
end
x=[1:1:length(node_for_compute)];
figure
xlabel('节点名','FontSize',13);
ylabel('电压越线率','FontSize',13);
set(gca,'XTick',x);
set(gca,'XGrid','on');
hold on;
plot(x,prob,'rs')
figure
plot(x,average,'bx');
hold on;
xlabel('节点名','FontSize',13);
set(gca,'XTick',x);
set(gca,'XGrid','on');
plot(x,variance,'mo');
legend('电压偏差的均值','电压偏差的方差');
%  plot(wind,prob);

