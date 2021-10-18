clear all
%%
% pde of original heart rates
load RRI-DATA.mat
figure(1)
h = 60./xRRI1;
[f, x] = hist(h, 50); 
bar(x, f / trapz(x, f));
xlim([85,125])
ylim([0,0.1])
title('PDE of original heart rate','FontSize',14);
xlabel('Samples (BPM)','FontSize',14)
ylabel('Probability','FontSize',14)

% pde for avaraged heart rates for different value of alpha
%% alpha = 1
count = 1;
a = 1;
avgh = zeros(1,99);
for i = 1:10:990
    for j = i:i+9
        avgh(count) = avgh(count) + a*h(j);
    end 
    avgh(count) = avgh(count)/10;
    count = count + 1;
  
end

figure(2)
[f, x] = hist(avgh,40); 
bar(x, f / trapz(x, f));
xlim([85,120])
ylim([0,0.12])
title('PDE of averaged heart rate (a = 1)','FontSize',14);
xlabel('Samples (BPM)','FontSize',14)
ylabel('Probability','FontSize',14)

%% alpha = 0.6
count = 1;
a = 0.6;
avgh = zeros(1,99);
for i = 1:10:990
    for j = i:i+9
        avgh(count) = avgh(count) + a*h(j);
    end 
    avgh(count) = avgh(count)/10;
    count = count + 1;
  
end

figure(3)
[f, x] = hist(avgh,50); 
bar(x, f / trapz(x, f));
xlim([53,72])

title('PDE of averaged heart rate (a = 0.6)','FontSize',14);
xlabel('Samples (BPM)','FontSize',14)
ylabel('Probability','FontSize',14)
