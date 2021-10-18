%% 4.1: Weiner filter
clear all
%%
% input 
x = randn(1,1000);
% filter coefficients 
b = [1,2,3,2,1];
a = [1];
% output 
y = filter(b,a,x);
% normalized output
s1 = std(y);
y = y/s1;
% sequence with std = 0.1
n = randn(1, 1000);
n = 0.1*n;
% Signal to noise ratio
z = y + n;
zSNR = snr(y,n); 

% 4.1.1
% cross correlation between z and x
maxlag = 4;
pzx = xcorr(z,x,maxlag);
pzx = pzx(maxlag+1:end);
pzx = transpose(pzx);
rxx = xcorr(x,maxlag);
rxx = rxx(maxlag+1:end);
rxx = toeplitz(transpose(rxx), rxx);
Wopt = inv(rxx)*pzx.*s1

% 4.1.2
s2 = [0.1, 1, 3, 6, 8, 10];
n2 = zeros(6,1000);
z2 = zeros(6,1000);
zSNR2 = zeros(6,1);
corr = zeros(6,9);
pzx2 = zeros(5,6);
Wopt2 = zeros(5,6);

for i = 1:length(s2)
    
    n2(i,:) = s2(i).*randn(1,1000);
    z2(i,:) = y + n2(i,:);
    zSNR(i) = snr(y,n2(i,:))
    maxlag = 4;
    corr(i,:) = xcorr(z2(i,:),x,maxlag);
    pzx2(:,i) = corr(i,maxlag+1:end);
    Wopt2(:,i) = inv(rxx)*pzx2(:,i).*s1
end

% for different values of maxlag

maxlag2 = [5,8];
for i = 1:2
    corr3 = xcorr(z,x,maxlag2(i));
    pzx3 = corr3(maxlag2(i)+1:end);
    pzx3 = transpose(pzx3);
    rxx = xcorr(x,maxlag2(i));
    rxx = rxx(maxlag2(i)+1:end);
    rxx = toeplitz(transpose(rxx), rxx);
    Wopt3 = inv(rxx)*pzx3.*s1

end

%% LMS algorithm
%4.2.1
% apply the lms algorithm
gain = 0.1;
[y,err,w] = lms(x,z,gain,(maxlag + 1));
w = w*s1;
n = [1:1:length(x)];
figure(1)
plot(n,w(1,1:1000))
hold on
plot(n,w(2,1:1000))
hold on
plot(n,w(3,1:1000))
hold on
plot(n,w(4,1:1000))
hold on
plot(n,w(5,1:1000))
title('LMS weights for \mu = 0.1','FontSize',12)
xlabel('Time n','FontSize',12)
ylabel('Coefficients','FontSize',12)

    
% 4.2.2 
gain = [ 0.002, 0.01, 0.1, 0.3, 0.5];

for i = 1:length(gain)
    [y,err,w] = lms(x,z,gain(i),(maxlag + 1));
    w = w*s1;
    n = [1:1:length(x)];
    figure(2)
    subplot(2,5,i)
    plot(n,w(1,1:1000))
    hold on
    plot(n,w(2,1:1000))
    hold on
    plot(n,w(3,1:1000))
    hold on
    plot(n,w(4,1:1000))
    hold on
    plot(n,w(5,1:1000))
    title(['LMS weights for \mu = ', num2str(gain(i))],'FontSize',12)
    xlabel('Time n','FontSize',12)
    ylabel('Coefficients','FontSize',12)
    legend('W1','W2','W3','W4','W5','FontSize',7);
    % squared error
    subplot(2,5,i+5)
    plot(n,(err.^2))
    title('squared error','FontSize',12);
    xlabel('Time n','FontSize',12)
    ylabel('Magnitude','FontSize',12)
    
end

% 4.3
%% gear shifting
gain = 0.3;
[y1,err1,w1] = lms(x,z,gain,(maxlag+1));
[y2,err2,w2, gain_array] = lms_GearShifting(x,z,gain,(maxlag + 1));
w1 = w1*s1;
w2 = w2*s1;
n = [1:1:length(x)];



figure(4)
subplot(1,4,1)
plot(n,w2(1,1:1000))
hold on
plot(n,w2(2,1:1000))
hold on
plot(n,w2(3,1:1000))
hold on
plot(n,w2(4,1:1000))
hold on
plot(n,w2(5,1:1000))
ylim([-0.5 3.5])
title('LMS weights for time varying \mu','FontSize',14)
xlabel('Time n','FontSize',14)
ylabel('Coefficients','FontSize',14)
legend('weight 1', 'weight 2','weight 3','weight 4','weight 5','FontSize',10)

subplot(1,4,2)
plot(n,w1(1,1:1000))
hold on
plot(n,w1(2,1:1000))
hold on
plot(n,w1(3,1:1000))
hold on
plot(n,w1(4,1:1000))
hold on
plot(n,w1(5,1:1000))
title(['LMS weights for \mu = ', num2str(gain)],'FontSize',14)
xlabel('Time n','FontSize',14)
ylabel('Coefficients','FontSize',14)
legend('weight 1', 'weight 2','weight 3','weight 4','weight 5','FontSize',10)


% squared error

subplot(1,4,3)
n1 = [1:1:length(x)+1];
plot(n1,(err2.^2))
title('Squared error for varying \mu','FontSize',12);
xlabel('Time n','FontSize',12)
ylabel('Magnitude','FontSize',12)

subplot(1,4,4)
plot(n,(err1.^2))
title('Squared error for non varying \mu','FontSize',12);
xlabel('Time n','FontSize',12)
ylabel('Magnitude','FontSize',12)

figure(6)
semilogy(gain_array)
xlim([0,1000]);
title('Value of the adaptation gain through time','FontSize',12)
xlabel('Time n','FontSize',12)
ylabel('\mu','FontSize',12)
