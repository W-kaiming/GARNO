close all; clear all; clc
a = 2000
k = 2
k1 = 4
k2 = 3

%%%  1������ʣ��������ͼ�Σ���1Сʱ��ɹ۲�
if k/2 == fix(k/2)
   delt = pi/1800
else
   delt = pi/3600
end
[theta rho X] = RosesConfig(a,k,delt,k1,k2);

% h = polar(theta,rho)
% figure(1);
% set(h,'color',[1,0,0],'LineWidth',2)

%%%ÿ��Сʱ��GDOP
X(:,3) = 0;
n = size(X,1);
h = 4000;
x = [0 0 h];
[GDOP11 A] = GDOP1(x,X');
[GDOP22 A] = GDOP2(x,X');
A' * A;

%%%%����õ�����ߵ��ظ�����Ϊ 1 hour-->[0 2pi] or [0 pi],��Ӧ��������cos(ka)��
%%%% С��1Сʱ���źŰ���5���ӣ�

%%%%ģ��۲����#######
%%%%           %%%%%%%
%������������Ϊ������
delat = 0.0001;
Es = [];
DayS=zeros(365,4);
AllHouS = zeros(365*24,4);
for i=1:3600
    Dis(i) = norm(X(i,:) - x);
end
for j = 1:365
    j
    for k = 1 : 24
        parfor i = 1 : 3600
            time = (j-1) * 24 * 3600  + (k-1) * 3600 + i;
            S(i,:) = Dis(i) + SysE(time,0.05);
            %Es =  [Es;Sys1(1:10:3600)];
        end
        %%% Сʱ��ʱ������
        %[x_LS dL Aalf sig1]  = NonLinearLS_Robust(X,S,x,delat);   %%%��ͳ��С����

        [x_LS]  =  GaussNewton(X,S,[x 0]',delat,1);   %%%��ͳ��С����
       
        HouS(k,:) = x_LS;
        AllHouS((j-1)*24 + k,:) = x_LS;
    end
    DayS(j,:) = mean(HouS);
end
save('DaySs.mat');
save('AllHouS.mat');
save('Es.mat');
