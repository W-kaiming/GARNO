function [ X ] = SeafloorPolygonPoints(MP,h)
%% ���ݶ�ȡ
x0 = MP(1:2);S = MP(3);R = MP(4);alpha = MP(5);
%������������� x0������εı��� S����������Բ�뾶 R���������ת�Ƕ� alpha��
%% ���������
theta=linspace(alpha,alpha+2*pi,S+1);
X = [R*cos(theta'),R*sin(theta')] + x0;
X=X(1:S,:);

X(:,3)=ErrorFunction(h,0:S-1);
end

