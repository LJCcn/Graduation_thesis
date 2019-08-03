clc;
% mpc = loadcase('case39');
% id = (mpc.branch(:,1)==16|mpc.branch(:,2)==16);
% mpc.branch(id,:)=[];
% [group,isolated]=find_islands(mpc)

% define_constants;

mpc = loadcase('case9');
% standV=zeros(9,1);
mpc.gen(2,2)=200;
[MVAbase, bus, gen, branch, success, et] = runpf(mpc);
% for j=1:9
standV=bus(5,VM)%额定状态各节点的电压的向量
% end






% a = mpc.bus
% b = mpc.gen
% c = mpc.branch
% y = [];
% for i = 0:38
%     y(i+1) = -0.0227*i+1.485;
%     a = randi(400)/10000
%     x(i+1) = y(i+1)-a
% end
% xlswrite('random2.xlsx',x);
% data1 = xlsread('random2.xlsx');
% x=linspace(0,30,39);
% y=data1;
% plot(x,y,'-*b');
% xlabel('节点移除比例(%)','FontSize',12);
% ylabel('网络传输效率','FontSize',12);
%     