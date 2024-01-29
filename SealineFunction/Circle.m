function [ X ] = Circle( X0,R,w,a,T,TStart,TEnd )

% �������
% X0ΪԲ������
% RΪԲ�İ뾶
% wΪ�����еĽ��ٶ�
% aΪ�����еĽǼ��ٶ�
% TΪ�������ʱ��
% TStartΪ��ʼʱ��
% TEndΪ��ֹʱ��

b=0;
c=0;

for k=1:1:TEnd/T+1
    t=(k-1)*T;
    %% ���ٶ���ʱ��Ĺ�ϵʽ
    A(k)=a+b*t+c*t^2;
    %----------------------%
end

Angle(1)=0;
j=0;
for i=1:1:TEnd/T
    angle=w*T+1/2*(A(i+1)+A(i))/2*T^2;
    w=w+(A(i+1)+A(i))/2*T;
    Angle(i+1)=Angle(i)+angle;
    if i>fix(TStart/T)
        j=j+1;
        theta(j)=Angle(i+1);
    end
end

x=R*cos(theta)+X0(1,1);
y=R*sin(theta)+X0(1,2);

X=[x' y'];

end

