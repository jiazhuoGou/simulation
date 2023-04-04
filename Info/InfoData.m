%% ================================���˻�����������Ϣ=========================================
%  无人机回传数据量MByte

ID  = (101:1:120)';
DATA_SIZE = zeros(1,20)';
TYPE = zeros(1, 20)';

%先随机五个传小数据
small_id = randi([101,120], 1, 5);
for i = 1 : 5
   DATA_SIZE(small_id(i) - 100) = randi([20, 30], 1, 1); 
   TYPE(small_id(i) - 100) = 1;
end

% 剩下15个传大数据
for i = 101 : 120
   if ~ismember(i, small_id) 
        DATA_SIZE(i - 100) = randi([80, 120], 1, 1);
        TYPE(i - 100) = 2;
   end
end

DATA = horzcat(ID, DATA_SIZE, TYPE);
writematrix(DATA, 'D:\simulation\data\InfoData.xlsx', 'Sheet','InfoDataSheet');

