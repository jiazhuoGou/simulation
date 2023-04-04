function [ RecvPowerU2U ] = CalcRecvPowerU2U( uav1, uav2 )
%CALCRECVPOWERU2U �˴���ʾ�йش˺�����ժҪ ������
%   �˴���ʾ��ϸ˵��
    PU = uav1(4) ;    % ���˻����书��dBm
    PU = power(10, PU / 10);
    
    G = -31.5;
    G = power(10, G / 10);
    
    dis = CalcDis(uav1, uav2);
    alpha = 2;
    
    RecvPowerU2U = PU * G * power(dis, -alpha) ; % ����mw����ת��ΪdBm
    RecvPowerU2U = 10 * log10(RecvPowerU2U);
end

