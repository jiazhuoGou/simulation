function [ link_quality ] = U2UComResDec( uav1, uav2 )
%U2UCOMRESDEC ���˻������˻�����·����
%   ���ص��ǵ÷�
    snr = CalcSNRU2U(uav1, uav2);
    rate = CalcRate( snr(2));
        
    link_quality = CalcLinkQuality( snr(1), rate);  % ��һ�������ʣ��ڶ����������
    
end

