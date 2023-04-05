function [ CanNet ] = CalcCanNet( uav)
% CALCCANNET
% 返回一个N行5列的矩阵 第一列id， 第二列速率，第三列链路，第四列匹配度，第五列QoE

 BS = readmatrix('D:\simulation\data\InfoBs.xlsx','Sheet','InfoBsSheet');
 DATA = readmatrix('D:\simulation\data\InfoData.xlsx','Sheet','InfoDataSheet');

BS_NUM = size(BS, 1);
DATA_NUM = size(DATA, 1);
CanNet_Temp = [];

data_type = 0;
for i = 1 : DATA_NUM
    if DATA(i, 1) ==  uav(8)
        uav(8) = DATA(i, 1);
        data_type = DATA(i, 3);
    end
end


%%  先找出关联的基站
flag = false;
for i = 1 : BS_NUM
    bs = BS(i, :);
    db = CalcSNRU2B(uav, bs);
    if  CalcDis(uav, bs) <= bs(4) || db(1) >= 10
        CanNet_Temp = [CanNet_Temp ; bs];
        rate_temp = CalcRate(db(1));
        if data_type == 2 && bs(7) >= 6 && rate_temp >= 10 
            flag = true;
        elseif data_type == 1 && rate_temp >= 6
            flag = true;
        end
    end
end

% 如果关联的基站剩余量够50%，并且速率超过12Mbps，并且链路超过10 ,qoe超过5直接接最好的基站不需要无人机
if flag == false
    CanNet_Temp = [CanNet_Temp ; ConstructCluster(uav)]; %
end

CanNet_Temp_Size = size(CanNet_Temp, 1);


%%  先把速率，链路算出来
Rate = zeros(CanNet_Temp_Size, 1);
LinkQuality = zeros(CanNet_Temp_Size, 1);
for i = 1 : CanNet_Temp_Size
    can_net = CanNet_Temp(i,:);
    if  can_net(3) == 0 %   基站
        snr = CalcSNRU2B(uav, can_net);
        Rate(i) = CalcRate( snr(2));
        LinkQuality(i) = CalcLinkQuality(snr(1), Rate(i));
    else %  无人机
        snr = CalcSNRU2U(uav, can_net);
        Rate(i) = CalcRate( snr(2));
        LinkQuality(i) = CalcLinkQuality(snr(1), Rate(i));
    end
end
%% 速率第10列

%% Link质量第11列

%% 业务匹配度 12列
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
    else
        BPM(i) = e;
    end
end


%% QoE参数融合， 13列
QoE = zeros(CanNet_Temp_Size, 1); % 传输视频的QoE参考你懂的那篇论文， 越大越好
w1 = 0.9;
w2 = 0.1;
beta = 400; % 常量
seta = 0.8; % 常量
error =  0.05 + (0.11-0.05).*rand(1,1);
% 450是一分钟的帧数
for i = 1 : CanNet_Temp_Size
    if data_type == 1
        QoE(i) =  w1 * seta * ( log(beta * Rate(i) / 0.5) - error ) + w2 * abs(normrnd(5,sqrt(2)));
    else
        QoE(i) =  w1 * seta * ( log(beta *  Rate(i) / 3) - error ) + w2 * abs(normrnd(5,sqrt(2)));
    end
end


%% 取id那一列
CanNet = CanNet_Temp(:,8);
CanNet = horzcat(CanNet, Rate, LinkQuality, BPM, QoE );

end

