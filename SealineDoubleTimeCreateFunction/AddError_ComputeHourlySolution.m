function [AllHouS,DayS,Es,SysEDis,GDOP11,GDOP22] = AddError_ComputeHourlySolution( X,x,TStart,TEnd,ConstantError,Amplitude,InitialAppearance,GaussianNoise  )
N = size(X,1); %%X ������
n = size(x,1); %%x ������
%% ����ѭ������
[ DayEnd,HourEnd,SecondEnd ] = ComputePeriod( TStart,TEnd );

%% %%ģ��۲����#######
%%%%           %%%%%%%
%������������Ϊ������
delat = 0.0001;
Es = [];
SysEDis=[];
DayS=zeros(DayEnd,3);
AllHouS = zeros(fix((TEnd-TStart)/3600),3);

%% ���㺣���ͺ���Ӧ����֮�伸�ξ���
for j=1:n
    for i=1:N
        Dis(j,i) = norm(X(i,:) - x(j,:));
    end
end

%% �������ھ������+��������Ӧ����֮����룬�������۲ⷽ��ʵ�ֵ������㺣�׵�����
for j = 1:DayEnd
    j
    tic
    if j==DayEnd
        hourEnd=HourEnd;
    else
        hourEnd=24;
    end
    for k = 1 : hourEnd
        if j==DayEnd && k==HourEnd
            secondEnd=SecondEnd;
        else
            secondEnd=3600;
        end
        dis=Dis(:,(j-1)*24*3600+(k-1)*3600+1:(j-1)*24*3600+(k-1)*3600+secondEnd);
        parfor i = 1 : secondEnd
            time = TStart+(j-1)*24*3600+(k-1)*3600+i;
            SysError(i)= SysE(time,ConstantError,Amplitude,InitialAppearance,GaussianNoise);
        end
        Es=[Es SysError];
        S=[];
        for ii=1:n
            parfor i = 1 : secondEnd
                S(i,ii) = dis(ii,i) + SysError(i);
                %Es =  [Es;Sys1(1:10:3600)];
            end
        end
        SysEDis=[SysEDis;S];
        P0=eye(secondEnd);
        for i=1:n
            %%% Сʱ��ʱ������
            XX=X((j-1)*24*3600+(k-1)*3600+1:(j-1)*24*3600+(k-1)*3600+secondEnd,:);
            s=S(:,i);xx=x(i,:);
            [x_LS]  = NonLinearLS_Robust(XX,s,xx,delat);   %%%��ͳ��С����
            
            %[x_LS]  =  GaussNewton(XX,s,[xx 0]',delat,1);   %%%��ͳ��С����
            
            HouS(k,:,i) = x_LS;
            AllHouS((j-1)*24 + k,:,i) = x_LS;
            
            %%% ÿ��Сʱ��GDOP
            [GDOP11((j-1)*24+k,i),A] = GDOP1(xx,XX');
            %[GDOP22((j-1)*24+k,i) A] = GDOP2(xx,XX');
            QQx = inv(24^2 * A' * A);
            GDOP22((j-1)*24+k,i) = QQx(1,1) + QQx(2,2);
        end
    end
    for i=1:n
        DayS(j,:,i) = mean(HouS(:,:,i));  %% ÿ��ƽ��ֵ
    end
    toc
end
end

