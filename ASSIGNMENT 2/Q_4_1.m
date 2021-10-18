clear all
%%
load NASDAQ.mat
m = mean(NASDAQ.Close);
s = std(NASDAQ.Close);
figure(1)
% original data
[ar,nvar,rc] = aryule(NASDAQ.Close,10);
figure(1)
stem(-rc)
xlim([0 11])
conf95 = sqrt(2)*erfinv(0.95)/sqrt(294);
[X,Y] = ndgrid(xlim,conf95*[-1 1]);

% standarised data

[ar,nvar,rc] = aryule((NASDAQ.Close-m)/s,10);
hold on
stem(-rc)
hold on
plot(X,Y,'--r')
hold off
title('Partial Autocorrelation (PAC)','FontSize',14)
xlabel('Correlation lag','FontSize',14)
ylabel('Correlation','FontSize',14)
legend('Original data','standardised data','Confidelnce interval 95%','FontSize',14)


% MDL, AIC and AICc
N = 924;
for p = 1:10
    
    [ar,err,rc] = aryule((NASDAQ.Close-m)/s,p);
   
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

    