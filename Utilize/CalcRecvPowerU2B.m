function [ RecvPowerU2B ] = CalcRecvPowerU2B( uav, base )
%CALCRECVPOWER �������˻�����վ�Ļ�վ���չ���
%   uav, base��������
    PU = uav(4);    % ���˻����书��dBm
    
    
    avg = CalcPLAvgU2B(uav, base); % ·�����
    
    RecvPowerU2B = PU - avg; % ��Ҫȥ���������ü�������Ϊavg��λ��dB
    %RecvPowerU2B = PU / (power(10, avg / 10));
    
    
    
    
    
    
end

