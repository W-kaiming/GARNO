function [ X ] = Spiral( X0,r,w,a,L,V,A,T,TStart,TEnd )
% ���ĵ����� x0
% ��ʼ�뾶 r.
% ��ת���ٶ� w
% ��ת�Ǽ��ٶ� a
% ������ʼ�ݾ� L
% �ݾ��������ٶ� V
% �ݾ��������ٶ� A
% �۲���ʱ�� T
% TStartΪ��ʼʱ��
% TEndΪ��ֹʱ��

b=0;B=0;
c=0;C=0;
for k=1:1:TEnd/T+1
    t=(k-1)*T;
    %% ���ٶ���ʱ��Ĺ�ϵʽ
    aa(k)=a+b*t+c*t^2;  % ��ת���ٶ�
    AA(k)=A+B*t+C*t^2;  % �ݾ���ٶ�
    %----------------------%
end

Angle(1)=0;
S(1)=L;
j=0;
for i=1:1:TEnd/T
    angle=w*T+1/2*(aa(i+1)+aa(i))/2*T^2;
    s=V*T+1/2*(AA(i+1)+AA(i))/2*T^2;
    w=w+(aa(i+1)+aa(i))/2*T;
    AC=V+(AA(i+1)+AA(i))/2*T;
    Angle(i+1)=Angle(i)+angle;
    S(i+1)=S(i)+s;
    if i>fix(TStart/T)
        j=j+1;
        theta(j)=Angle(i+1);
        R(j)=r+S(i+1)*theta(j);
    end
end
[x,y]=pol2cart(theta, R); %��������ת��Ϊ�ѿ�������
x=x+X0(1,1);
y=y+X0(1,2);
X = [x' y'];

end

