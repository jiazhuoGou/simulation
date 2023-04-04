function [ score] = U2BComResDec( uav )
%UNTITLED �������˻��ĵ���վ��ͨ����Դ������һ������������Ҫ�����Լ�ȥ����Ȩ��ȷ��Ȩ��
%   uav : ��Ҫ�������˻�
%   Res�� ͨ����Դ���֣�0-1��
    
    BS = readmatrix('D:\simulation\data\InfoBs.xlsx','Sheet','InfoBsSheet');
    
    
    %% �����жϸ����˻�����Щ��վ����
    [bs_num, ~] = size(BS);
    k = 1;
    link_quality = 0;
    for i = 1 : bs_num
        bs = BS(i, :);
        snr  = CalcSNRU2B(uav, bs);
        rate = CalcRate(snr(2));
        if snr(1) >= 10 || rate >= 1 % ���� ����Ҫ��Ū��������Ȼ��Ȩ��ȷ��Ȩ��Ҫgg
            % ������·����
            link_quality = CalcLinkQuality(snr(1), rate) + link_quality;
            k  = k + 1;
        end
    end
    
    % �ò�η������õ㣬�������ֻ��һ��Ҳ���Դ���
    score = link_quality / k;
   
end

