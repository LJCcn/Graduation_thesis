clear; clc;
define_constants;
mpc = loadcase('case9');

gen_node = 3;
pr = mpc.gen(gen_node,PG);

speed =  linspace(5,17,100);
power = fan(speed, pr);
%mpc.gen(gen_node,PG) =0;
initailLoad = runpf(mpc);
result_branch = zeros(length(power),1);
result_vol = zeros(length(power),1);


for i = 1:length(power)
    mpc.gen(gen_node,PG) = pr + power(i);
    tempLoad = runpf(mpc);
    sum = 0;
    sumV = 0;
    real = 0;
    for j = 1:size(tempLoad.branch,1)
        temp = abs(tempLoad.branch(j,PF))-abs(initailLoad.branch(j,PF));
        if(temp>0&&initailLoad.branch(j,PF)~=0)
        sum = sum + temp/abs(initailLoad.branch(j,PF));
        real = real +1;
        end
    end
    for s = 1:size(tempLoad.bus,1)
        temp = tempLoad.bus(s,VM)/tempLoad.bus(s,VMAX);
        if(tempLoad.bus(s,VM)>=tempLoad.bus(s,VMAX))
            ["wow:",s,tempLoad.bus(s,VM)]
        end
        sumV = sumV + temp;
    end
    sum = sum;
    if real ==0
        result_branch(i) = 0;
    else
    result_branch(i) = sum/real;
    end
    result_vol(i) = sumV/size(tempLoad.bus,1);
end

%边的功率的增长率均值
figure(1);
plot(speed, result_branch);
figure(3);
plot(speed, power);
%电压与最大值之比
figure(2);
plot(speed, result_vol);