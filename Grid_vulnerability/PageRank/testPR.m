mpc = loadcase('case14');
A=mpc2pr(mpc);
[B,ek]=pagerank(A,0.85,0.001);