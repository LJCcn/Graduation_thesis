clear; clc;
define_constants;
mpc = loadcase('case39');
branch = mpc.branch(:,[F_BUS,T_BUS]);
G=graph(branch(:,1),branch(:,2));
plot(G,'-*b','Layout','force','LineWidth',1);
