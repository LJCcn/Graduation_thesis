
% a = 12.5;
% b = 2.2;
a = 20;
b=2;
N = 1000;
pd = makedist('Weibull','a',a,'b',b)
r = wblrnd(a,b,[1 N]);
x = linspace(0,50,N);
y = pdf(pd,x);
grid on;
plot(x,y,'LineWidth',2)
hold on 
%histogram(r,20,'Normalization','pdf')   
%title('Weibull Distribution of Wind Speeds')
xlabel('风速(m/s)');
%ylabel('概率密度');