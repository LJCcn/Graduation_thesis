clear; clc;
define_constants;
mpc = loadcase('case39');

gen_node = 10;%IEEE39的只有发电节点为10的时候才有电压过载率；为2，1，3都没有。
load_node = 3;
pr = mpc.gen(gen_node,PG);
pd = mpc.bus(load_node,PD);
qd = mpc.bus(load_node,QD);
[MVAbase, bus, gen, branch, success, et] = runpf(mpc);
standV=bus(:,VM);
N=5000;
%第一个是lemda;第二是k
wind = wblrnd(20,1,N,1);
%wblplot(Wind);
y1 = wblpdf(wind, 20,2);
% plot(wind,y1,'.');
power = fan(wind,pr);
loadP = normrnd(pd,3.3,N,1);%入参分别是 均值、标准差、mxn维；
loadQ = normrnd(qd,3.3,N,1);
node_for_compute = mpc.bus(:,1);
result = zeros(length(node_for_compute), length(power));
for i = 1:length(power)
    mpc.gen(gen_node,PG) = power(i);
    mpc.bus(load_node,PD) = loadP(i);
    mpc.bus(load_node,QD) = loadQ(i);
    [MVAbase, bus, gen, branch, success, et] = runpf(mpc);   
    diffV=abs(bus(:,VM)-standV);
    frac=diffV./standV;
    result(:,i) = frac;
end
prob = zeros(length(node_for_compute),1);
for j = 1:length(node_for_compute)
    overLimit=0;
    for jj = 1:length(power)
        if result(j,jj)>0.05
            overLimit=overLimit+1;
        end
    end
    prob(j)=overLimit./length(power);
end
x=[1:1:length(node_for_compute)];
figure
xlabel('节点名','FontSize',13);
ylabel('电压越线率','FontSize',13);
set(gca,'XTick',x);
set(gca,'XGrid','on');
hold on;
plot(x,prob,'rs')