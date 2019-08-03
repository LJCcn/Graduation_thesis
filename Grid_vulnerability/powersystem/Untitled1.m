clc;
data = xlsread('ÁÙ½ç¹¦ÂÊ.xlsx');
data1 = xlsread('voltage.xlsx')
critP = data(:,2);
for i = 1:29
    for j = 1:3000
        if critP(i)<=j
            data1(j,i) = 0;
        end
    end
end
xlswrite('voltageP.xlsx',data1);