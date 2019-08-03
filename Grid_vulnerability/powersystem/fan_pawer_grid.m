clear; clc;
define_constants;
mpc = loadcase('case9');

gen_node = 3;
pr = mpc.gen(gen_node,PG);

speed =  linspace(5,16,100);
power = fan(speed, pr);

node_for_compute = mpc.bus(:,1);

result = zeros(length(node_for_compute), length(power));
result_std = zeros(length(power),1);
for i = 1:length(power)
    mpc.gen(gen_node,PG) = power(i);
    result(:,i) = nodeBetween(mpc);
    result_std(i) = std(result(:,i));
end

figure(1);
plot(speed, result);
legend(sprintfc('%g',node_for_compute));

figure(2);
plot(speed, result_std);
