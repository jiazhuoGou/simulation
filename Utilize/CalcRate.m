function [ RateU2U ] = CalcRate(  snr_ratio )
%CALCRATEU2U �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    B = 2; % ��λ��Mhz
    
    
    RateU2U = B * log2(1 + snr_ratio); % mbps

end

