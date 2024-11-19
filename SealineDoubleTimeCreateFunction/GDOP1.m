function [GDOP1 A] = GDOP1(Unknown,Knowns)
%%%��һ��GDOP
%������� Unknown=x,Kowns=X'
[m,n]=size(Knowns); %��ȡX'���к��е�Ԫ�ظ���
A=[];
for i=1:n
    Dif=Unknown-Knowns(:,i)';
    Dis=norm(Dif);
    A=[A;Dif/Dis];
end
InvN=inv(A'*A);
GDOP1=trace(InvN);
GDOP1=sqrt(GDOP1);