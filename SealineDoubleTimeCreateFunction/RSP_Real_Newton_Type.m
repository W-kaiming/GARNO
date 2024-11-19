function [x0 k QQ sig0_2 dL xx] = RSP_Real_Newton_Type(X,L,x0,P0,p,type,delt,flag,P)
%%
% X ���Ƶ�����
% L ����۲�
% x0 ��ֵ
% P0 �۲�Ȩ
% p ������p=2Ϊ��С���ˣ�p=1Ϊ1�������ƣ�һ��ȡ1<p<2
% type������type=0Ϊ��˹ţ�ٷ���type=1Ϊţ�ٷ�(���)
% delt �������
% flag:0 ���Ӳ�
%      1 ���Ӳ�
% P ������Ϣx0��Ȩ
[n m]=size(X);
Pior = x0;
k=0;
xx=[];
while (1)
    if flag == 0
        for i = 1 : n
            dif    = X(i,:) - x0';
            dis    = norm(dif);
            A(i,:) = dif./dis;
            dL(i)  = dis - L(i);
            
            abs_v = abs(dL(i));
            if abs_v<0.0001
            abs_v = 0.0001;
            end
            P_p(i,i) = abs_v^(p-2); %%�˴������Ǵ洢�ͼ���ɱ�,Ȩ����Ը��û�б�Ҫ������p
            
            if type==1
              S(i,i) = L(i)/dis;
            end
        end
    else
        x00 = x0(1:m)';
        c_off = x0(m+1);
        for i = 1:n
            dif    = X(i,:) - x00;
            dis    = norm(dif);
            A(i,:) = dif./dis;
            dL(i)  =  dis - c_off - L(i);
            
            abs_v = abs(dL(i));
            if abs_v<0.0001
            abs_v = 0.0001;
            end
            P_p(i,i) = abs_v^(p-2); %%�˴������Ǵ洢�ͼ���ɱ�,Ȩ����Ը��û�б�Ҫ������p
            
            if type==1
            %%ToDO
              S(i,i)=(L(i) + c_off)/dis;
            end
        end
    end
    
    P1 = P0 * P_p; %%�˴�δ���Ǽ���ɱ�
    
    if flag == 1 %%���Ӳ����
        Kn = ones(n,1);
        AA = [A Kn];
        if type==1
            N      = A' * S *P1*A + (trace(P0)-trace(S)) * eye(m); %%�����ڿ������ʱЧ�������룡��
            %����1��%%%����Ч���ã�����p>2ʱЧ�����ܲ�
            %N      = A' *  P1*A + (trace(P0)-trace(S)) * eye(m); 
            %����2��%%%����Ч���ã�����p>2ʱЧ�����ܲ�
            %N      = A'*S*P1*A; 
            
            N      = [N  A'*Kn; Kn'*A n];
        else
            N      = (p-1) * AA'*P1*AA; %%0.01
        end
    dx = inv(N)*AA'*P0*(dL'.^(p-1));
    else  %%���Ӳ����
        if type==1
          N      = A'*S*P1*A + (trace(P0)-trace(S)) * eye(m);
        else
          N      = A'*P1*A;
        end
    dx = inv(N)*A'*P1*dL';
    end
    
    
    
    x0 = x0 + dx;
    
    k = k + 1;
    xx = [xx x0];
    
    %%ֹͣѭ��
    if norm(dx)<delt
      break
    end
    if k > 1000
      break
    end
end
%%��������
if flag == 1
    VV = dL'-AA*dx;
    sig0_2 = VV'*P1*VV/(n-m-1);
    QQ = inv(AA'*P1*AA)* sig0_2;
else
    VV = dL'-A*dx;
    sig0_2 = VV'*P1*VV/(n-m);
    QQ = inv(A'*P1*A)*sig0_2;
end
    
%%%�˼�������Ϣ
    x0 = inv(N + P) * (N * x0 + P * Pior);
end