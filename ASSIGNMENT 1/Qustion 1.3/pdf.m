%% Assignment 1: Exercise 1.3.1
% create function !!!!
v = randn(1,10000); % random process with gaussian distribution
figure(4)
bins = 50;
[f, x] = hist(v, bins); % Create histogram from a normal distribution.
bar(x, f / trapz(x, f)); 

title('PDF estimate of stationary process','FontSize',14)
xlabel('x','FontSize',14)
ylabel('P(x)','FontSize',14)