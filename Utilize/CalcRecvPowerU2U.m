function [ RecvPowerU2U ] = CalcRecvPowerU2U( uav1, uav2 )
%CALCRECVPOWERU2U 此处显示有关此函数的摘要 
%   此处显示详细说明
    PU = uav1(4) ;    % 无人机发射功率dBm
    dis = CalcDis(uav1, uav2);


    PL_d0 = 46.4;
    PL =PL_d0 + 10 * alpha * log10(dis);
    small_fading = abs(normrnd(5,sqrt(1)));
    RecvPowerU2U = PU - PL - small_fading;
end

