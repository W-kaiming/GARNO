function [GlobalRefT, GlobalRefP,GlobalArmLength,GlobalRefH,GlobalRefc,GlobalDepthH,Globalc1,Interval, HardDelay] = Simulation_GlobalParSetting(INIData)

GlobalRefT = INIData.LaunchRT(2:end);  % �ο�ת��ʱ��
%% ���峱Ϊ��; 
GlobalRefP = [-2686643.38952782,5410552.69054612,2039760.98252097]; % �ο�ת����                        
GlobalRefH = 0;           % �ο�ת���߳�      
GlobalDepthH  = 3069;

GlobalArmLength = [INIData.Forward;INIData.Rightward;INIData.Downward];

Globalc1     = 1.479047302627320e+03;
GlobalRefc   = 1.479047302627320e+03;

Interval = 8;
HardDelay = 0;
end







