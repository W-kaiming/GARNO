function [ X ] = RosesWAccelerated( Roses )
% X0Ϊ��������
% AΪ����뾶
% KΪ����Ҷ�ӵĸ�����Ҷ�ӵĴ�С�����ڲ���
% w Ϊ���ٶ�
% a Ϊ�Ǽ��ٶ�
% T Ϊ�۲���ʱ��
% TStartΪ��ʼʱ��
% TEndΪ��ֹʱ��

X0=Roses.X0;A=Roses.A;K=Roses.K;w=Roses.w;a=Roses.a;
T=Roses.T;TStart=Roses.TStart;TEnd=Roses.TEnd;alpha=Roses.Alpha;
if A==0
    X=X0.*ones(max(size(TStart+T:T:TEnd)),2);
    return;
end

b=0;
c=0;
number=(TEnd-TStart)/T;
for k=1:1:number+1
    t=(k-1)*T;
    %% ���ٶ���ʱ��Ĺ�ϵʽ
    AA(k)=a+b*t+c*t^2;
    %----------------------%
end

Angle(1)=0;
j=0;
for i=1:1:number
    angle=w*T+1/2*(AA(i+1)+AA(i))/2*T^2;
    w=w+(AA(i+1)+AA(i))/2*T;
    Angle(i+1)=Angle(i)+angle;
    j=j+1;
    theta(j)=Angle(i+1);
end
rho=A*cos(K*theta);
%[theta, r]=cart2pol(x,y) %���ѿ�������ת��Ϊ������

[x,y]=pol2cart(theta+alpha, rho); %��������ת��Ϊ�ѿ�������

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
