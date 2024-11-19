function [soundVelocity] = inverseEofFun(timeSpaceCoordinate,Eof)
%% ����˵��
%�������ͣ�
%�������ܣ�������x,y,t���������

%% ��������
t=timeSpaceCoordinate(1);
x=timeSpaceCoordinate(2);
y=timeSpaceCoordinate(3);
order = 6;

%% ���6��pc
B = [1 x y t];
fitPc = zeros(order,1);
for iPc=1:order
    fitPc(iPc,1) = B * Eof.fitPcCoefficient(:,iPc);
end

%% �ع�
soundVelocity = Eof.averageDataMatrix(:,1) + Eof.f(:,1:order) * fitPc;
end

