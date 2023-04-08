function [ RecvPowerU2U ] = CalcRecvPowerU2U( uav1, uav2 )
%CALCRECVPOWERU2U �˴���ʾ�йش˺�����ժҪ 
%   �˴���ʾ��ϸ˵��
    PU = uav1(4) ;    % ���˻����书��dBm
    dis = CalcDis(uav1, uav2);


    PL_d0 = 46.4;
    PL =PL_d0 + 10 * alpha * log10(dis);
    small_fading = abs(normrnd(5,sqrt(1)));
    RecvPowerU2U = PU - PL - small_fading;
end

