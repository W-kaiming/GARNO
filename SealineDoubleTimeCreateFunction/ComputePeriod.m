function [ DayEnd,HourEnd,SecondEnd ] = ComputePeriod( TStart,TEnd )
TIME=TEnd-TStart;
% �����λ��
DayEnd=fix(TIME/(24*3600))+1;

% Сʱ����λ��
HourEnd=fix((TIME-(DayEnd-1)*24*3600)/3600)+1;

% �����λ��
SecondEnd=TIME-(DayEnd-1)*24*3600-(HourEnd-1)*3600;

if HourEnd==0
    HourEnd=24;
    DayEnd=DayEnd-1;
end
if SecondEnd==0
    SecondEnd=3600;
    HourEnd=HourEnd-1;
    if HourEnd==0
        HourEnd=24;
        DayEnd=DayEnd-1;
    end
end

end

