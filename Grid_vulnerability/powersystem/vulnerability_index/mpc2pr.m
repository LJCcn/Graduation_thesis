function [A,B] = mpc2pr(mpc)
define_constants;
[MVAbase, bus, gen, branch, success, et] = runpf(mpc);
num = size(bus);
A = zeros(num(:,1));
for i=1:length(branch(:,1))
    powerP=branch(i,PF);
    powerQ=branch(i,QF);
    powerS=sqrt(powerP.^2+powerQ.^2);
    fromBus = branch(i,F_BUS);
    toBus = branch(i,T_BUS);   
    if powerP>=0
        A(fromBus,toBus)=powerS;
    else
        A(toBus,fromBus)=powerS;
    end
end
B=A;
for i=1:length(bus(:,1))   
    if sum(A(i,:))==0
        for j=1:length(bus(:,1)) 
            A(i,j)=1;         
        end
    end
end
A
end


