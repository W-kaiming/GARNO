close all; clear all; clc

kk=2
k1 = 4
k2 = 3


%%%  1������ʣ��������ͼ�Σ���1Сʱ��ɹ۲�
if kk/2 == fix(kk/2)
   delt = pi/1800
else
   delt = pi/3600
end

h = 4000;
x = [0 0 h];

NN = 0
for a = 2000:1000:25000
    NN = NN +1
    %a = 2000
    [theta rho X] = RosesConfig(a,kk,delt,k1,k2);

    % h = polar(theta,rho)
    % figure(1);
    % set(h,'color',[1,0,0],'LineWidth',2)

    %%%ÿ��Сʱ��GDOP
    X(:,3) = 0;
    n = size(X,1);

    [GDOP11(NN) A] = GDOP1(x,X');
    %[GDOP22(NN) A] = GDOP2(x,X');
    QQx = inv(24^2 * A' * A);
    GDOP22(NN) = QQx(1,1) + QQx(2,2);
    %%%%����õ�����ߵ��ظ�����Ϊ 1 hour-->[0 2pi] or [0 pi],��Ӧ��������cos(ka)��
    %%%% С��1Сʱ���źŰ���5���ӣ�

    %%%%ģ��۲����#######
    %%%%           %%%%%%%
    %������������Ϊ������
    delat = 0.0001;
    Es = [];

    for s=1:3600
        Dis(s) = norm(X(s,:) - x);
    end
    for j = 1:10
        for k = 1 : 24
            parfor i = 1 : 3600
                time = (j-1) * 24 * 3600  + (k-1) * 3600 + i;
                S(i,:) = Dis(i) + SysE(time,1);
                %Es =  [Es;Sys1(1:10:3600)];
            end
            %%% Сʱ��ʱ������
            [x_LS dL Aalf sig1]  = NonLinearLS_Robust(X,S,x,delat);   %%%��ͳ��С����
            %[x_LS]  =  GaussNewton(X,S,[x 0]',delat,1);   %%%��ͳ��С����

            %HouS(k,:) = x_LS;
            AllHouS((j-1)*24 + k,:) = x_LS;
        end
        %DayS(j,:) = mean(HouS);
    end
    DD=var(AllHouS);
    PositionalP2(NN) = DD(1) + DD(2);
    PositionalP3(NN) = DD(1) + DD(2) + DD(3);
end
% save('DaySs.mat');
% save('AllHouS.mat');
% save('Es.mat');
