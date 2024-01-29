function [theta rho X]=RosesConfig(a,k,delt,k1,k2)

%
%õ���߷��̵ı������ͼ��
%rho=a*sin(k*theta)
%rho=a*cos(k*theta)��
%��kΪ������Ϊ����ʱ��õ����Ҷ�ӵĸ���Ϊk������Ϊpi��
%��kΪ������Ϊż��ʱ��õ����Ҷ�ӵĸ���Ϊ2*k������Ϊ2*pi��
%��kΪ������N/D��������N��ĸD��Ϊ����ʱ��õ����Ҷ����ΪN������ΪD*pi������N��ĸD��һ��Ϊż��ʱ��õ����Ҷ����Ϊ2*N������Ϊ2*D*pi��

if k==fix(k)
   if k/2 == fix(k/2)
    % ��kΪ������Ϊż��ʱ��õ����Ҷ�ӵĸ���Ϊ2*k������Ϊ2*pi����õ���߷���rho=10*cos(4*theta)Ϊ������ͼ��
    theta=delt:delt:2*pi;
    rho=a*cos(k*theta);
   else
    %%%��kΪ������Ϊ����ʱ��õ����Ҷ�ӵĸ���Ϊk������Ϊpi����õ���߷���rho=10*cos(3*theta)Ϊ������ͼ��
    theta=delt:delt:pi;
    rho=a*cos(k*theta);
   end
else
    if k1/2 ~= fix(k1/2)
        if k2/2 ~= fix(k2/2)
            theta=delt:delt:k2*pi;
            rho=a*cos(k*theta);
        else
            theta=delt:delt:2*k2*pi;
            rho=a*cos(k*theta);
        end
    else
        %% TODO
            theta=delt:delt:2*k2*pi;
            rho=a*cos(k*theta);
    end
end
%[theta, r]=cart2pol(x,y) %���ѿ�������ת��Ϊ������

[x,y]=pol2cart(theta, rho); %��������ת��Ϊ�ѿ�������
X = [x' y'];