function [CanNet] = RSR_CalcCanNet(uav)
%RSR_CALCCANNET id，BPM RSS， ,QoS(时延抖动丢包速率
%   返回一个n行7列的矩阵
BS1 = readmatrix('D:\simulation\data\InfoBs.xlsx','Sheet','InfoBsSheet');
DATA1 = readmatrix('D:\simulation\data\InfoData.xlsx','Sheet','InfoDataSheet');

data_type = 0;
for i = 1 : size(DATA1, 1)
    if DATA1(i, 1) ==  uav(8)
        uav(8) = DATA1(i, 1);
        data_type = DATA1(i, 3);
    end
end

BS_NUM = size(BS1, 1);
CanNet_Temp = [];


% 首先判断有哪些接入点可以接入，选好了之后再来计算那三个参数，最后返回
for i = 1 : BS_NUM % 这里通过计算距离来判定是否可以接入
    db = CalcSNRU2B(uav, BS1(i, :));
    dis = CalcDis(uav, BS1(i,:));
    if (dis >= 0 && dis <= BS1(i, 4)) || (db(1) >= 5) % 第4列是基站半径 要多来几行数据不然算的时候会出错
        CanNet_Temp = [CanNet_Temp ; BS1(i,:)];
    end
end
CanNet_Temp_Size = size(CanNet_Temp,1);

% 速率
Rate = zeros(CanNet_Temp_Size, 1);
for i = 1 : CanNet_Temp_Size
    if (CanNet_Temp(i, 3) == 0)
        db = CalcSNRU2B(uav, CanNet_Temp(i,:));
        db_ratio = db(2); % 比值
        rate = CalcRate(db_ratio);
        Rate(i) = rate;
    else
        db = CalcSNRU2U(uav, CanNet_Temp(i,:));
        db_ratio = db(2);
        rate = CalcRate(db_ratio);
        Rate(i) = rate;
    end
end

% RSS
RSS = zeros(CanNet_Temp_Size, 1);
for i = 1 : size(CanNet_Temp, 1)
    if CanNet_Temp(i, 3) == 0
        rss = CalcRecvPowerU2B(uav, CanNet_Temp(i, :)); % 他是个负数越接近于0越好
        RSS(i) = rss;
    else
        rss = CalcRecvPowerU2U(uav, CanNet_Temp(i, :));
        RSS(i) = rss;
    end
end


%% 业务匹配度
BPM = zeros(CanNet_Temp_Size, 1);
%   大数据要求3-9Mbps, 小数据要求  0.5-2Mbps
for i = 1 : CanNet_Temp_Size
    if data_type == 1
        e = (Rate(i) - 0.5) / 1.5;
    else
        e = (Rate(i) - 3) / 6;
    end
    temp = [e , 1];
    BPM_temp = temp((e >= 1) + 1);
    if BPM_temp == 1
        BPM(i) = BPM_temp - abs(normrnd(0.1,sqrt(0.05)));
    elseif BPM_temp > 0
        BPM(i) = e;
    else
        BPM(i) = 0.05 + (0.1 - 0.05) * rand();
    end
end

% 作为对别算法，应该只是总共4列，时延 抖动 丢包 带宽
qos = zeros(size(CanNet_Temp, 1), 4);
for i = 1 : size(CanNet_Temp,1)
    qos(i,:) = QoS();
end
qos(:,4) = Rate;


% 拼接起来
%CanNet = CanNet_Temp;
CanNet = CanNet_Temp(:,8); % 先取id那一列 总共7列
CanNet = [CanNet, BPM, RSS, qos];
end

