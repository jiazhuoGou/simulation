DeR=[15;16;17;11];   DeI=[7;8;9;10]; % ʱ��
    JiR=[1;1;1;1];      JiI=[3;4;5;6];  % ����
    PLR=[5;5;5;5];      PLI=[2;3;4;5];  % ����
    K=length(DeR);%ά��
   
    dwde=DeR+DeI.*rand(K,1);
    dwjit=JiR+JiI.*rand(K,1);
    dwpac=PLR+PLI.*rand(K,1);
    
    A=[dwde';dwjit';dwpac'];%������̬���߾���
    j = 1;
    disp(A(:,j));

    [rows, cols]=size(A);
    
    %���ԵĹ淶������Ϊ���Ƕ��Ǽ�С�����ݣ�ԽСԽ��
      for j = 1 : cols
           a = max(A(:,j));
           A(:,j) = a - A(:,j);
      end
    % �淶��
%     for j = 1:size(A, cols)
%             A(:,j) = A(:,j) ./ sqrt(sum(A(:,j).^2));
%     end

function [max] = getMax(array)
    rows = size(array, 1);
    max = 0;
    for i = 1 : rows
        if max < array(i)
            max = array(i);
        end
    end
end
    
    

 
 
 
