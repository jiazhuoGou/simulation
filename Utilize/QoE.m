function [ qoe ] = QoE(  )
%QOE ����һ��3��Ԫ�ص����������������qoe�÷֣���ʵҲ����Ҫ���룬��ֱ�Ӹ�������һ��
%   ÿ����ʱ�ӣ������ʣ�����
    DeR=[15;16;17;11];   DeI=[10;9;8;8]; % ʱ��
    JiR=[1;1;1;1];      JiI=[5;5;5;5];  % ����
    PLR=[5;5;5;5];      PLI=[5;5;5;5];  % ����
    K=length(DeR);%ά��
   
    dwde=DeR+DeI.*rand(K,1);
    dwjit=JiR+JiI.*rand(K,1);
    dwpac=PLR+PLI.*rand(K,1);
    
    A=[dwde; dwjit; dwpac];%������̬���߾���
    [rows, cols]=size(A);
    
    %���ԵĹ淶������Ϊ���Ƕ��Ǽ�С�����ݣ�ԽСԽ��
    total = zeros(1,3);  
    for j = 1 : cols
           a = getMax(A(:,j));
           A(:,j) = a - A(:,j);
           total(j) = sum(A(:,j)) / 3;
     end
      qoe = total(1) * 0.4 + total(2) * 0.3 + total(3) * 0.3;
    
end

    function [max] = getMax(array)
    rows = size(array, 1);
    max = 0;
    for i = 1 : rows
        if max < array(i)
            max = array(i);
        end
    end


end

