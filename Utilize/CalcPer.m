function [ PER ] = CalcPer( snr_db )
%CALCPERU2U �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    
    an = 90.2514;
    gn = 3.4998;
    gamma = 1.0942; %(dB)
    
    if ( snr_db < gamma && snr_db > 0)
       res = 1; 
    else
        res = an * exp( (-gn) * snr_db );
    end
    
    if res <= 0.01
        res = 0.01;
    elseif res >=1
        res = 0.95;
    end
    PER = res; 

end

