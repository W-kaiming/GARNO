close all;clear;clc
%% ��ȡ��ǰ�ű���λ��
ScriptPath      = mfilename('fullpath');      % �ű�λ��
[FilePath] = fileparts(ScriptPath);      % �ļ���λ��
cd(FilePath);
clear FilePath;
%%
h=4000;
%
% % �켣Բ
% X0=[0,0];
% R=h;
% w=pi/1800;
% a=0;
% T=5;
% TStart=0;
% TEnd=60*45;
% alpha=pi/2;
% %%%  1������ʣ��������ͼ�Σ���1Сʱ��ɹ۲�
% [ XCircle001 ] = Circle( X0,R,w,a,T,TStart,TEnd );
% [ XCircle002 ] = CircleWAccelerated( X0,R,w,a,T,TStart,TEnd,alpha );
% draw(XCircle001,X0,'0');
% draw(XCircle002,X0,'90');

% �켣õ��
X0=[0,0];
A=2.5*h;
K=4;
w=pi/1800;
a=0;
T=1;
TStart=0;
TEnd=60*60;
alpha=pi/4;
%%%  1������ʣ��������ͼ�Σ���1Сʱ��ɹ۲�
[ XRoses ] = Roses( X0,A,K,w,a,T,TStart,TEnd );
[ XRoses001 ] = RosesWAccelerated( X0,A,K,w,a,T,TStart,TEnd,alpha );

draw(XRoses,X0,'0');
draw(XRoses001,X0,'90');
 
% % ������
% X0=[100,100];
% r=10;
% w=pi/1800;
% a=0;
% L=1;
% V=0;
% A=0;
% T=1;
% TStart=0;
% TEnd=5*60*60;
% alpha=pi/4;
% tic
% [ X000 ] = Spiral( X0,r,w,a,L,V,A,T,TStart,TEnd);
% [ X001 ] = SpiralWAccelerated( X0,r,w,a,L,V,A,T,TStart,TEnd,alpha );
% toc
% 
% draw(X000,X0,'0');
% 
% draw(X001,X0,'45');

