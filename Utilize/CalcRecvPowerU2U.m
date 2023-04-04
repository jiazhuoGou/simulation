function [ RecvPowerU2U ] = CalcRecvPowerU2U( uav1, uav2 )
%CALCRECVPOWERU2U 此处显示有关此函数的摘要 被废弃
%   此处显示详细说明
    PU = uav1(4) ;    % 无人机发射功率dBm
    PU = power(10, PU / 10);
    
    G = -31.5;
    G = power(10, G / 10);
    
    dis = CalcDis(uav1, uav2);
    alpha = 2;
    
    RecvPowerU2U = PU * G * power(dis, -alpha) ; % 这是mw，再转换为dBm
    RecvPowerU2U = 10 * log10(RecvPowerU2U);
end

