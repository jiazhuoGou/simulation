function [ SNRU2B ] = CalcSNRU2B( uav, base )
%CALCSNRU2B 此处显示有关此函数的摘要
%   计算信噪比

    recv = CalcRecvPowerU2B(uav, base); % 单位是dBm
    
    sigma = -96;%-96dBm方差的噪声，不用生成
    I =  abs(normrnd(1.5,sqrt(0.5)));     %%模拟干扰信号强度(dBm)
    
    SNRU2B_db = recv - (sigma) - I; % dBm - dBm得到的是分贝 这里的单位是分贝,这里P的单位用的dBm，不是w，所以是用减法不是除法
    SNRU2B_ratio = power(10, SNRU2B_db / 10);
    SNRU2B = [SNRU2B_db, SNRU2B_ratio];    % 第一列分贝，第二列从分贝转化为比值
    
%{ 
    可能要大改 另一个做法，下面的是另一个做法，暂时不用
    PU = uav(4); 
    dis = CalcDis(uav, base);
    B = uav(6) * 1e6; % HZ
    beta = -2.3;
    N0 = -110; % dBm
    
    % 视距与非视距概率
    angle = asin( (uav(3) - base(3)) / dis);  % 就是弧度
    angle = angle * (180 / pi); % 要得到角度
    D = -0.16;
    C = 8.97;
    P_Los = 1 / ( 1 + C * exp(D * (angle-C))  );
    P_NLos = 1 - P_Los;
    MU_Los = 0.1;
    MU_NLos = 21; 
    KI = P_Los * MU_Los + P_NLos * MU_NLos;
    %SNRU2B = (PU * power(dis, beta)) / (N0 * B * KI); 
%}
end

