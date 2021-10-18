%% 4.5.1 Speech recognition
clear all;
%%
load E.mat
load A.mat
load S.mat
load T.mat
load X.mat

Fs = 44100; % sampling frequency
N = 1000; % number of samples
letters = [{E},{A},{S},{T},{X}];
nam = ['E','A','S','T','X'];
order = [1 2 5 10 15];
t = 0.01:1:25;
mse = zeros(length(order),length(t));

figure(1)
for i = 1:length(letters)
    subplot(1,5,i)
    plot(letters{:,i});
    title(['Sample: ', num2str(nam(i))],'FontSize',14)
    xlabel('Time n','FontSize', 14)
end

figure(2)
count = 1;
% for i = 1:5 
%         error = zeros(N,1);
%         letter = letters{:,i};
%         for j = 1:length(order) 
%            for k = 1:length(t)
%               [y, error, w] = lms_pred(letter,t(k),order(j));
%               mse(j,k)= mean(error.^2);
%            end
%         end
%        subplot(1,5,i)
%        for z = 1:5
%         hold on
%         plot(t,mse(z,:))
%        end
%        ylim([0 MSE(1,1)])
%        title(['MSE, sample: ', num2str(nam(i))],'FontSize', 14)
% end
for i = 1:5
    letter = letters{:,i};
   
    for j = 1:length(order)
        ord = order(j);
       for k = 1:length(t)
           mu = t(k);
          [let_est, error, weights] = lms1(letter,mu,ord);
          MSE(j,k)= mean(error.^2);
          
       end
    end
    
    subplot(2,5,count);  
    count = count + 1;
    for c = 1:5
        hold on;
        plot(t,MSE(c,:));
        
        %
    end
    xlabel("Step size",'FontSize',12)
    ylabel("MSE",'FontSize',12)
    ylim([0 MSE(1,1)])
    title(["LMS: "+nam(i)],'FontSize',9)
    xlim([0 25])
    
end


for i = 1:5
    letter = letters{:,i};
    
    for j = 1:length(order)
        ord = order(j);
       for k = 1:length(t)
           mu = t(k);
          [let_est_GS, error_GS, weights_GS,] = lms_predGS(letter,mu,ord);
          MSE_gs(j,k)= mean(error_GS.^2);
       end
    end
    
    subplot(2,5,count);  
    count = count + 1;
    for c = 1:5
        hold on;
        plot(t,MSE_gs(c,:));
        
    end
    xlabel("Step size",'FontSize',12)
    ylabel("MSE",'FontSize',12)
    ylim([0 MSE_gs(1,1)])
    title(["GS LMS: "+nam(i)],'FontSize',9)
    xlim([0 25])
   

end
legend('p=1', 'p=2', 'p=5', 'p=10', 'p=15')
%% 4.5.2. Optimal filter length
figure(4)
optimum_mu = [5 5 4 3 3];
for i = 1:5
    letter = letters{:,i};
    for p = 1:20
        [y, error, w] = lms1(letter,optimum_mu(i),p);
        [rc,err] = aryule(y,p);
        
        PCA(p) = -rc(p+1);
        MDL(p) = log(err) + (((p*log(N)))/N);
        AIC(p) = log(err) + 2*p/N;
        AICc(p) = AIC(p) + (2*p*(p+1))/(N-p-1);
    end
    
    subplot(2,5,i)
    stem(PCA,'HandleVisibility','off','LineWidth',1)
    hold on
    yline(0.062,'r--')
    hold on
    yline(-0.062,'r--')
    title(['PAC for ', num2str(nam(i))],'FontSize',14)
    xlabel('Order','FontSize',14)
    legend('Threshold','FontSize',10)
    
    subplot(2,5,i+5)
    plot(MDL,'LineWidth',1)
    hold on
    plot(AIC,'LineWidth',1)
    hold on
    plot(AICc,'LineWidth',1)
    hold off
    title(['MDL, AIC, AICc for ', num2str(nam(i))],'FontSize',14)
    xlabel('Order','FontSize',14)
    
end
legend('MDL','AIC','AICc','FontSize',10)



%% 4.5.3. prediction gain

% resample the variables
E_resampled = resample( E, 16000,44100);
A_resampled = resample( A, 16000,44100);
S_resampled = resample( S, 16000,44100);
T_resampled = resample( T, 16000,44100);
X_resampled = resample( X, 16000,44100);

letters_resampled = [{E_resampled},{A_resampled},{S_resampled},{T_resampled},{X_resampled}];
newFs = 16000;
figure(5)
for j = 1:5
    
    letter = letters{:,j};
    letter_resampled = letters_resampled{:,j};
    
    for i = 1:20
        [y, error, w] = lms1(letter, optimum_mu(j), i);
        
        [y_resampled, error_resampled, w_resampled] = lms1(letter_resampled, optimum_mu(j), i);
        pred_gain(j,i) = 10*log10(var(letter)/var(error));
        pred_gain_resampled(j,i) = 10*log10(var(letter_resampled)/var(error_resampled));
    end
    
    figure(7);
    subplot(1,2,1);
    semilogy(1:20, pred_gain(j,:), 'LineWidth',1);
    hold on
    ylabel('dB','FontSize',15);
    xlabel('Order','FontSize',15)
    title('Predicion gain: 44.1kHz','FontSize',15)
    legend('E','A','S','T','X','FontSize',9)
    
    subplot(1,2,2);
    semilogy(1:20, pred_gain_resampled(j,:), 'LineWidth',1);
    hold on 
    ylabel('dB','FontSize',15);
    xlabel('Order','FontSize',15)
    title('Prediction gain: 16kHz','FontSize',15)
    
end


%% FFT plots
figure(6)
freq = Fs*(0:(N/2))/N;
Nnew = 363;
newfreq = newFs*(0:(Nnew/2))/Nnew;
for i = 1:5
    letter_resampled = letters_resampled{:,i};
    letter = letters{:,i};
    
    fftLetter = fft(letter);
    fftLetter  = abs(fftLetter ./N);
    fftLetter  = fftLetter (1:N./2+1);
    fftLetter (2:end-1) = 2*fftLetter (2:end-1);
    
    
    fftLetter_resampled = fft(letter_resampled);
    fftLetter_resampled  = abs(fftLetter_resampled ./Nnew);
    fftLetter_resampled = fftLetter_resampled (1:Nnew./2+1);
    fftLetter_resampled (2:end-1) = 2*fftLetter_resampled (2:end-1);
    
    subplot(1,2,1)
    plot(freq./1000,fftLetter)
    hold on
    title('FFT of all letters','FontSize',15)
    xlabel('Frequency (kHz)','FontSize',15)
    legend('E','A','S','T','X','FontSize',9)
    zoom on
    
    subplot(1,2,2)
    plot(newfreq./1000,fftLetter_resampled)
    hold on
    
end

figure(8)
for i = 1:length(letters)
    
    subplot(1,5,i)
    plot(letters_resampled{:,i});
    title(['Sample: ', num2str(nam(i))],'FontSize',14)
    xlabel('Time n','FontSize', 14)
end 


%%
function [y, error, w] = lms1(letter,t,order)
    N = length(letter);
    error = zeros(N,1);
    y = zeros(N,1);
    w = zeros(order,N);
    for i = order+1:N
       y(i) = w(:,i)'*letter(i-1:-1:i-order);
       error(i) = letter(i) - y(i);
       w(:,i+1) = w(:,i) + t*error(i)*letter(i-1:-1:i-order);
    end
end

function [y, error, w] = lms_gearShifting(letter,t,order)
   
    N = length(letter);
    error = zeros(N,1);
    y = zeros(N,1);
    w = zeros(order,N);
    t1 = zeros(N+1,1); 
    t1(order) = 3*t;
    
        for i=order+1:N                                    
            y(i) = w(:,i)'*letter(i-1:-1:i-order);   
            error(i) = letter(i) - y(i);                 

            if (error(i)- error(i-1)>0.001)
                t1(i) = 1.01*t1(i-1);
            end
            if (error(i) - error(i-1)<-0.001)
                t1(i) = 0.99*t1(i-1);
            
            else
                t1(i) = t1(i-1);
            end
            w(:,i+1) = w(:,i)+t1(i)*error(i)*letter(i-1:-1:i-order); 

        end
end

