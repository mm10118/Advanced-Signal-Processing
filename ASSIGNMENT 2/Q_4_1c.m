clear all
%%
load NASDAQ.mat
N = 1:50:1001;
var = 1:50:1001;

% standarise the data
m = mean(NASDAQ.Close);
var2 = std(NASDAQ.Close);
data = (NASDAQ.Close-m)/var2;
r = (std(data))^2;

for i = 1:length(var)
    for j = 1:length(N)
        Noisevar(i,j) = (2*(var(i))^2)/N(j);
        Avar(i,j) = var(i)/(N(j)*r);
    end
end 

figure(1)
subplot(1,2,1)
heatmap(var, N ,Noisevar, 'ColorScaling','log');
colormap default
xlabel('N')
ylabel('variance')
title('Heatmap of noise variance')
set(gca,'fontsize', 14)

subplot(1,2,2)
heatmap(var, N ,Avar, 'ColorScaling','log');
colormap default
xlabel('N')
ylabel('variance')
title('Heatmap of the variance of a_1')
set(gca,'fontsize', 14)

% finding the value of var{a}
[ar,nvar,a1] = aryule(NASDAQ.Close,1);
-a1; %we calulate the value of the single cofficient 