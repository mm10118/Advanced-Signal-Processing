clear all
%%
load sunspot.dat;
figure(1)
% original data
[ar,nvar,rc] = aryule(sunspot(:,2),10);
figure(1)
stem(-rc)
xlim([0 11])
conf95 = sqrt(2)*erfinv(0.95)/sqrt(288);
[X,Y] = ndgrid(xlim,conf95*[-1 1]);



% standarised data
m = mean(sunspot(:,2));
var = std(sunspot(:,2));

[ar,nvar,rc] = aryule((sunspot(:,2)-m)/var,10);
hold on
stem(-rc)
hold on
plot(X,Y,'--r')
hold off
title('Partial Autocorrelation (PAC) for sunspot series','FontSize',14)
xlabel('Correlation lag','FontSize',14)
ylabel('Correlation','FontSize',14)
legend('Original data','standardised data','Confidelnce interval 95%','FontSize',14)

% calculate MDL

N = 288;
MDL(1) = 0;
AIC (1)= 0;
AICc (1)= 0;

for p = 1:10
    
    [ar,err,rc] = aryule((sunspot(:,2)-m)/var,p);
    
    MDL(p) = log(err) + (((p*log(N)))/N);
    AIC(p) = log(err) + 2*p/N;
    AICc(p) = AIC(p) + (2*p*(p+1))/(N-p-1);
    
end

figure(2)
plot(MDL);
hold on
plot(AIC);
hold on
plot(AICc);
legend('MDL','AIC','AICc','FontSize',14)
title('MDL, AIC and AICc for increasing model order','FontSize',14)
xlabel('model order p','FontSize',14)
ylabel('magnitude','FontSize',14)
xlim([0,10])
    