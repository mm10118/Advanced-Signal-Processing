clear all;

%% 3.3.3 and 3.3.4 estimation of AR coefficients using LSE approach
load sunspot.dat

% original and zero mean data

data = sunspot(:,2);
m = mean (sunspot(:,2));
zmdata = data - m;

% autocorrelation of the data
acorr = xcorr(zmdata, 'biased');
M = length(data);

% calculate AR parameters for orders = 1...10
H = zeros(M,1); % observation matrix
err = zeros(10,1); % mean squared error
a = zeros(10); % matrix with coefficient values

for p = 1:10 % iterate over each model order
    for i = 1:p % calculate H for each model order
        for j = M:length(acorr)
            H(j+1-M,i) = acorr(j-i); % observation matrix
        end
    end
       a(1:p,p) = inv((H')*H)*(H')*acorr(M:end); % coefficients for each model order
       x = (acorr(M:end)-H*a(1:p,p)).^2;
       err(p) = mean(x); % mean squared error
       
end

err = err/max(err); % normalize the mean squared error
model = 1:1:10; 
figure(1)
plot(model,err,'LineWidth',1.5)
title('Mean Squared Error (MSE)','FontSize',12)
xlabel('Model order p','FontSize',12)
ylabel('Magnitude','FontSize',12)

% 3.3.5 Power spectrum calculation
[P, freq] = pgm(acorr,575); % periodogram


p = [1 2 6 10];
figure(2)
plot(freq, P);
hold on

for i = 1:length(p)
    [Pxx, f] = pyulear(H(:,1:p(i))*a(1:p(i),p(i)),p(i),length(acorr),1);
    plot(f,Pxx,'LineWidth',1.5);
    hold on;
end 
xlim([0, 0.5]);
title('Power Spectrum of sunspot series', 'FontSize', 12);
xlabel('Frequency f (Hz)', 'FontSize',12);
ylabel('Magnitude', 'FontSize', 12)
legend('Periodogram','PSD for AR(1)', 'PSD for AR(2)','PSD for AR(6)','PSD for AR(10)','FontSize',12); 
zoom on

% 3.3.6. approximation error for different data lengths
N = 10:5:250;
mse = zeros(length(N),1);
for i = 1:length(N)
    acorr = xcorr(zmdata(1:N(i)),'biased');
    s = H(1:N(i),1:2)*a(1:2,2);
    x = (acorr(N(i):end)-H(1:N(i),1:2)*a(1:2,2)).^2;
    err(i) = mean(x); % mean squared error
end
err = err/max(err);
figure(3)
plot(N, err,'LineWidth',1.5);
title('Normalised MSE','FontSize',15)
xlabel('Sample size N','FontSize',15)
ylabel('Magnitude','FontSize',15);

figure(4)
plot([1:250],acorr(250:end),'LineWidth',1)
hold on 
plot([1:250],s,'LineWidth',1)
title("Original and predicted data comparison ",'FontSize',20)
legend('Original','Model','FontSize',20)
xlabel('Time lag','FontSize',20)
ylabel('Magnitude','FontSize',20)


