clear; clc;
mpc = loadcase('case39');
N=39;
index_status=[];
vector = [];
% index_status=multiVunlerableAnaly(vector);

for i=1:10
    vector = [vector i];
    index_status = [index_status;multiVunlerableAnaly(vector)];
end

xlswrite('39脆弱性指标',index_status,'状态脆弱性指标','L3')

