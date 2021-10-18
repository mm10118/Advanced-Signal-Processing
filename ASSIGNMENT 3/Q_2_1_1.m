clear all;
%%
% sunspot series
load sunspot.dat
zmdata = zscore(sunspot(:,2)); % zero mean data
data = sunspot(:,2); % original data
N = length(data);

% periodogram zero mean data
[zmP, zmf] = pgm(zmdata, N);
zmP = zmP(1:N/2);

% periodogram original data
[P,f] = pgm(data, N);
P = P(1:N/2);

% array with different model orders to calculate
p = [1, 2, 6, 10];

for i = 1:length(p)
    [a, var] = aryule(data, p(i)); %calculates coefficients and variance
    [h1,w1]=freqz([sqrt(var)],a,N/2);

    [zma, zmvar] = aryule(zmdata, p(i)); %calculates coefficients and variance
    [h2,w2]=freqz([sqrt(zmvar)],zma,N/2);
    
    subplot(2,4,i)
    plot(w1/(2*pi),P) %periodogram of data
    hold on
    plot(w1/(2*pi),(abs(h1).^2),'LineWidth',1.5) % model based estimation
    xlim([0 0.5])
    ylim([0 400000])
    title([ 'original periodogram, AR(',num2str(p(i)),')'],'FontSize',10)
    ylabel("Magnitude",'FontSize',10)
    xlabel("Frequency f (Hz)",'FontSize',10)
    legend('Periodogram','Model Based PSD')
   
    subplot(2,4,i+4) 
    plot(w2/(2*pi),(zmP)) %periodogram of zero mean data
    hold on
    plot(w2/(2*pi),(abs(h2).^2),'LineWidth',1.5) %model based estimation
    xlim([0 0.5])
    title([ 'zero-mean periodogram, AR(',num2str(p(i)),')'],'FontSize',10)
    ylabel("Magnitude",'FontSize',10)
    xlabel("Frequency f (Hz)",'FontSize',10)
    
   
end 


