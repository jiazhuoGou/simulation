function [ dis ] = CalcDis( i, j )
%CALC_DIS �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
dis =  sqrt( power(abs(i(1) - j(1)),2) + power(abs(i(2) - j(2)),2) +  ... 
    power(abs(i(3) - j(3)),2) );
end

