function [outputArg1,outputArg2] = CalcBlockProbability(inputArg1,inputArg2)
%CALCBLOCKPROBABILITY 

%PR 计算网络阻塞率
q=25; %网络的信道数量
x=0:1:q;
Pb(1)=1;
for i=1:length(wireless)
    %其中normrnd(0.8,0.4)产生随机服务时长service_time；
    %random('Poisson',)产生在网络当前用户量情况下产生的呼叫次数k；
    
    A=normrnd(0.29,0.1)*random('Poisson',floor(wireless(i).currentuser*0.3));
    %A=normrnd(0.29,0.1)*random('Poisson',40);    
    
    %Pb(i)=(A^q/factorial(q))/sum(A^x/factorial(x));
    %Pb(i)=(power(A,q)/factorial(q))/sum(power(A,x)/factorial(x));
    Pb(i)=yf(A,q);
    
    sum=0;
    for i=0:q
        sum=sum+A^i/factorial(i);
    end
    s=A^q/factorial(q)/sum;
    end


end

