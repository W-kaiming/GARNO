function [ X ] = Roses( X0,A,K,w,a,T,TStart,TEnd )
% X0Ϊ��������
% AΪ����뾶
% KΪ����Ҷ�ӵĸ�����Ҷ�ӵĴ�С�����ڲ���
% w Ϊ���ٶ�
% a Ϊ�Ǽ��ٶ�
% T Ϊ�۲���ʱ��
% TStartΪ��ʼʱ��
% TEndΪ��ֹʱ��

b=0;
c=0;

for k=1:1:TEnd/T+1
    t=(k-1)*T;
    %% ���ٶ���ʱ��Ĺ�ϵʽ
    AA(k)=a+b*t+c*t^2;
    %----------------------%
end

Angle(1)=0;
j=0;
for i=1:1:TEnd/T
    angle=w*T+1/2*(AA(i+1)+AA(i))/2*T^2;
    w=w+(AA(i+1)+AA(i))/2*T;
    Angle(i+1)=Angle(i)+angle;
    if i>fix(TStart/T)
        j=j+1;
        theta(j)=Angle(i+1);
    end
end
if K==fix(K)
   if K/2 == fix(K/2)
    % ��kΪ������Ϊż��ʱ��õ����Ҷ�ӵĸ���Ϊ2*k������Ϊ2*pi��
    rho=A*cos(K*theta);
   else
    %%%��kΪ������Ϊ����ʱ��õ����Ҷ�ӵĸ���Ϊk������Ϊpi��
    rho=A*cos(K*theta);
   end
else
    z=rats(K);
    [~,~,~, matches]=regexp(z,'\d+');
    for i=1:length(matches)
        Z(i)=str2num(cell2mat(matches(i)));
    end
    k1=Z(1);
    k2=Z(2);
    if k1/2 ~= fix(k1/2)
        if k2/2 ~= fix(k2/2)
            rho=A*cos(K*theta);
        else
            rho=A*cos(K*theta);
        end
    else
        %% TODO
            rho=A*cos(K*theta);
    end
end
%[theta, r]=cart2pol(x,y) %���ѿ�������ת��Ϊ������

[x,y]=pol2cart(theta, rho); %��������ת��Ϊ�ѿ�������

x=x+X0(1,1);
y=y+X0(1,2);
X = [x' y'];
end

%õ���߷��̵ı������ͼ��
%rho=a*sin(k*theta)
%rho=a*cos(k*theta)��
%��kΪ������Ϊ����ʱ��õ����Ҷ�ӵĸ���Ϊk������Ϊpi��
%��kΪ������Ϊż��ʱ��õ����Ҷ�ӵĸ���Ϊ2*k������Ϊ2*pi��
%��kΪ������N/D��������N��ĸD��Ϊ����ʱ��õ����Ҷ����ΪN������ΪD*pi������N��ĸD��һ��Ϊż��ʱ��õ����Ҷ����Ϊ2*N������Ϊ2*D*pi��
