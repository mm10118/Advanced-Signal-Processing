%% Assignment 1: Exercise 1-1-5

v = randn(1000, 1); % generate the random process
m = mean(v);
s = std(v);
temp = [1:1:1000]; % time vector to plot the values against

figure(1)
scatter(temp, v, 5, 'b')
set(gcf, 'PaperPositionMode', 'auto');
ylabel('x[n]','FontSize',14)
xlabel('n','FontSize',14)
title('Plot of the randomly generated vector x','FontSize',14)

temp = [0:1:9];
m1 = zeros(1,10); % vector of the mean of each realization
s1 = zeros(1,10); % vector of the standard deviations of each realization



for i = 1:10 % iterate through 10 different realizations
    v = randn(10000,1);
    m1(i) = mean(v); % calculate the mean for each realization
    s1(i) = std(v); % calculate the standard deviation of each realization
    
   
end
figure (2)
scatter(temp, m1, 25);
ylim([-1,1])
hold on
y1 = 0; % theoretical mean
yline(y1,'m')
set(gcf, 'PaperPositionMode', 'auto');
title('sample mean','FontSize',14)
ylabel('sample mean','FontSize',14)
legend('estimated mean','theoretical mean','FontSize',14)
xlabel('sample realizations','FontSize',14)

figure(3)
y2 = 1; % theoretical standard deviation
scatter(temp, s1, 25);
ylim([0,2])
hold on
yline(y2,'m')
set(gcf, 'PaperPositionMode', 'auto');
title('sample standard deviation','FontSize',14)
ylabel('sample standard deviation','FontSize',14)
xlabel('sample realizations','FontSize',14)
legend('estimated standard deviation','theoretical standard deviation','FontSize',14)

figure(4)
[f, x] = hist(v, 80); % Create histogram from a normal distribution.
g = 1 / sqrt(2 * pi) * exp(- x .^ 2); % theoretical pdf
bar(x, f / trapz(x, f),'HandleVisibility','off'); hold on
plot(x, g, 'r--','LineWidth', 2); hold off
set(gcf, 'PaperPositionMode', 'auto');
grid on;
title('Normalized histogram for bins = 80','FontSize',14)
xlabel('x','FontSize',14)
ylabel('P(x)','FontSize',14)
legend('theoretical PDF','FontSize',14)


