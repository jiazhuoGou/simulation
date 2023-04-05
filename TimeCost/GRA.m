function [time_cost] = GRA(selected_numbers)
%GRA 灰色关联选网
%   选择的参数跟自己的参数是一样的

time_cost = 0;

UAV = readmatrix('D:\simulation\data\InfoUAV.xlsx','Sheet','InfoUAVSheet');
BS = readmatrix('D:\simulation\data\InfoBs.xlsx','Sheet','InfoBsSheet');
DATA = readmatrix('D:\simulation\data\InfoData.xlsx','Sheet','InfoDataSheet');

%% 数据
[uav_rows, ~] = size(UAV);
time_cost = 0;
%% 具体流程
for i = 101 : uav_rows + 100
    uav = UAV(i-100, :); % i是无人机编号
    if ~ismember(selected_numbers, uav(8)) % 如果该无人机不在，那么不用回传
        continue;
    end
    t1 = clock();
    tic;
    candiate_net = CalcCanNet_GRA(uav); % 因为灰色关联也是那些
    target_net = GRA_select(candiate_net);
    flag = false;
    % 遍历target, 还是要优先  判断接入网络资源是否足够，选择资源够的接入，并且更新资源快
    % 需要接入无人机才接入，在候选网络的时候应该要更改
    for j = 1 : size(target_net, 1)
        ap_id = target_net(1);
        if ap_id < 100
            if DATA(i-100, 3) == 1 &&  BS(ap_id, 7) >= 2 % 说明这个基站可以接小数据
                BS(ap_id, 7) = BS(ap_id,7) - 2; % 更新资源快
                best_net = target_net(j,:); % 第j个就是最优的
                flag = true;
                break;
            elseif DATA(i-100, 3) == 2 && BS(ap_id, 7) >= 5 % 说明可以接大数据
                BS(ap_id, 7) = BS(ap_id,7) - 5; % 更新资源快
                best_net = target_net(j,:); % 第j个就是最优的
                flag = true;
                break;
            end
        else
            if DATA(i-100, 3) == 1 && UAV(ap_id - 100, 5) >= 2
                UAV(ap_id - 100, 5) = BS(ap_id - 100,5) - 2;
                best_net = target_net(j,:);
                flag = true;
                break;
            elseif DATA(i-100, 3) == 2 && UAV(ap_id - 100, 5) >= 5
                BS(ap_id - 100, 5) = BS(ap_id - 100,5) - 5;
                best_net = target_net(j,:);
                flag = true;
                break;
            end
        end
    end % 候选网络的j循环
     % 都不是选一个负载率最低的
    if ~flag
        target_net = sortrows(target_net, 2, "ascend");
        best_net  = target_net(1);
    end
    t2 = clock;
    elapsed_time = toc;
    time_cost = time_cost + elapsed_time;
    
end % 整个大的for循环






end




function [CanNet] = CalcCanNet_GRA(uav)
    % 首先还是计算候选网络
    BS1 = readmatrix('D:\simulation\data\InfoBs.xlsx','Sheet','InfoBsSheet');
    DATA1 = readmatrix('D:\simulation\data\InfoData.xlsx','Sheet','InfoDataSheet');

    BS_NUM = size(BS1, 1);
    DATA_NUM = size(DATA1, 1);
    CanNet_Temp = [];

    data_type = 0;
    for i = 1 : size(DATA1, 1);
        if DATA1(i, 1) ==  uav(8)
            uav(8) = DATA1(i, 1);
            data_type = DATA1(i, 3);
        end
    end

    % 先把能够连接的基站找出来，跟那个多属性决策是一样的
     % 首先判断有哪些接入点可以接入，选好了之后再来计算那三个参数，最后返回
    for i = 1 : BS_NUM % 这里通过计算距离来判定是否可以接入
        db = CalcSNRU2B(uav, BS1(i, :)); 
        dis = CalcDis(uav, BS1(i,:));
        if dis >= 0 && dis <= BS1(i, 4) % 第4列是基站半径
            CanNet_Temp = [CanNet_Temp ; BS1(i,:)];
        end
    end
    CanNet_Temp = [CanNet_Temp ; ConstructCluster(uav)];
    
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
    M = max(abs(RSS - 0)); % 正向化指标，因为RSS是一个负数
    RSS = 1 - abs(RSS) ./ M;


    % QoE
    QoE = zeros(CanNet_Temp_Size, 1); % 传输视频的QoE参考你懂的那篇论文， 越大越好
    w1 = 0.9;
    w2 = 0.1;
    beta = 400; % 常量
    seta = 0.8; % 常量
    error =  0.05 + (0.11-0.05).*rand(1,1);
    % 450是一分钟的帧数
    for i = 1 : CanNet_Temp_Size
        if data_type == 1
            QoE(i) =  w1 * seta * ( log(beta * Rate(i) / 0.5) - error ) + w2 * abs(normrnd(5,sqrt(2))) ;
        else
            QoE(i) = w1 * seta * ( log(beta *  Rate(i) / 3) - error ) + w2 * abs(normrnd(5,sqrt(2))) ;
        end
    end


    % 拼接起来
    CanNet = CanNet_Temp(:,8); % 先取id那一列
    CanNet = [CanNet, Rate, RSS, QoE];

end

function [TargetNet] = GRA_select(CanNet)
    % 这是一个N行4列的矩阵，后3列才是有用的
    
    % 参数预处理，每一列除以这一列的均值
    CanNet_temp = CanNet(:,2:4);
    col_mean = mean(CanNet_temp, 1); % 求出每列的均值 ，第一类id不要动
    B = bsxfun(@rdivide, CanNet_temp, col_mean); % B是不带id的有用矩阵
    
    % 将每行的最大值抽出来组成一个新的母序列
    y = max(B,[],2);
    n = size(B, 1);
    array = y - B; % 极差矩阵
    a = min(array); % 关联系数
    b = max(array);
    grey_d = mean((a + 0.5 * b) ./ (array + 0.5 * b), 1); %灰色关联度
    weights = grey_d ./ sum(grey_d);

    % 归一化前的得分
    s  = zeros(n, 1);
    for i = 1 : n
        s(i) = weights(1) * B(i,1) + weights(2) * B(i,2) + weights(3) * B(i,3);
    end
    s = s ./ sum(s);
    TargetNet = [CanNet(:,1), B, s]; 
    TargetNet = sortrows(TargetNet, 5, 'descend'); %第一个就是最好的
end

