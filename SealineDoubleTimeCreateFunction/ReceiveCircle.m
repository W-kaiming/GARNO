function [ X,LTStart,LTEnd,T] = ReceiveCircle(MP,H,DT,HT)
%% ���ݶ�ȡ
X0=MP(1:2);R=MP(3);w=MP(4);a=MP(5);T=MP(6);TStart=MP(7);TEnd=MP(8);alpha=MP(9);
% ���ĵ�����X0���뾶R�����ٶ�w���Ǽ��ٶ�a���������ʱ��T
LTStart = TStart + DT;LTEnd = TEnd + DT;
%% DT+HTʱ�����������(����ٽӿ�)
b = 0;
c = 0;
number = (TEnd - TStart) / T;
if nargin<4||isempty(HT)
    DT = DT * ones(floor(number),1);
    HT = 0;
end
for k=1:1:number + 1 + fix(max(DT + HT))
    t = (k - 1) * T;
    %% ���ٶ���ʱ��Ĺ�ϵʽ
    A(k) = a + b * t + c * t^2;
    %----------------------%
end
 %% ������ѧģ��
X = zeros(floor(number),3);
W = w;
TT = (DT + HT) / T;
for k = 1 : max(size(DT))
    w = W;
    Angle = alpha;
    for i = 1:1:(k-1)+TT(k)
        angle = w * T + 1/2 * (A(i + 1) + A(i)) / 2 * T^2;
        w = w + (A(i + 1) + A(i)) / 2 * T;
        Angle = Angle + angle;
    end
    if isempty(i)
        i=1;
    end
    RT = (TT(k) - fix(TT(k))) * T;
    angle = w * RT + 1/2 * (A(i + 1) + A(i))/2 * RT^2;
    Angle = Angle + angle;
    
    X(k,1:2) = [R * cos(Angle),R * sin(Angle)] + X0; 
    X(k,3)=ErrorFunction(H,(k-1)*T+TT(k)+RT);
end

end 