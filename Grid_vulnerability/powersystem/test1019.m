clc;
clear;
vin=5;
vout=20;
vr=15;
N = 100;
Pr=10;
x = linspace(0,20,N);
y=zeros(1,N);
for i=1:N
    if x(i)<vin|x(i)>vout
        y(i)=0;
    elseif x(i)>=vr&&x(i)<=vout
        y(i)=Pr;
    else
        y(i)=(vin^2-x(i)^2)/(vin^2-vr^2)*Pr;
    end
end

set(gca,'XColor','w');
set(gca,'YColor','w');
set(gca,'xtick',[],'ytick',[]);
plot(x,y,'k','LineWidth',1);
axis off;
% plot(x,y,'k','LineWidth',1)