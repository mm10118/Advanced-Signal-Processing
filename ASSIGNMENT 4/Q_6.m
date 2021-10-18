%% 4.6. Dealing with computational complexity: Sign algorithms
clear all;

%% AR parameter identificationload E.mat
load E.mat
load A.mat
load S.mat
load T.mat
load X.mat
figure(1)
n = randn(1000,1); % white noise
a = [1 0.9 0.2];
x = filter(1,a,n);
N = length(x);
pred = zeros(N,1);
w = zeros(2,N); 
err = zeros(N,1);
gain = [0.01, 0.035, 0.1];
order = 2;
t = 0;
for i = 1:length(gain)
    [pred, w, err,sign1, reg1, ss1, signw, regw, ssw, signerr, regerr, sserr] = lms_sign(x, gain(i), order);
    subplot(3,4,i+t)
    plot(w(1,:),'LineWidth',1)
    hold on
    plot(w(2,:),'LineWidth',1)
    title(['Standard LMS, \mu=',num2str(gain(i))],'FontSize',12)
    xlabel('Steps','FontSize',12);
    ylabel('Coefficients','FontSize',12)
    xlim([0,1000])
     if(i==3)
        legend('a_1','a_2','FontSize',12)
    end

    % sign - error
    subplot(3,4,i+1+t)
    plot(signw(1,:),'LineWidth',1)
    hold on
    plot(signw(2,:),'LineWidth',1)
    title(['Sign-error, \mu=',num2str(gain(i))],'FontSize',12)
    xlabel('Steps','FontSize',12);
    ylabel('Coefficients','FontSize',12)
    xlim([0,1000])

    % signed regressor
    subplot(3,4,i+2+t)
    plot(regw(1,:),'LineWidth',1)
    hold on
    plot(regw(2,:),'LineWidth',1)
    title(['Signed regressor, \mu=',num2str(gain(i))],'FontSize',12)
    xlabel('Steps','FontSize',12);
    ylabel('Coefficients','FontSize',12)
    xlim([0,1000])
   


    subplot(3,4,i+3+t)
    plot(ssw(1,:),'LineWidth',1)
    hold on
    plot(ssw(2,:),'LineWidth',1)
    title(['Sign-sign, \mu=',num2str(gain(i))],'FontSize',12)
    xlabel('Steps','FontSize',12);
    ylabel('Coefficients','FontSize',12)
    xlim([0,1000])
    t = t +3;
end


%% For part 4.5
letters = [A, E, S, T, X];
order = 4;
gain = 1;
[pred, w, err, sign1, reg1, ss1, signw, regw, ssw, signerr, regerr, sserr]= lms_sign( E, gain, order);

figure(2)
% error plots
subplot(2,4,5)
plot(err.^2)
xlim([0,1000]);
xlabel('Steps','FontSize',15)
ylabel('Magnitude','FontSize',15)
title('Error^2 Standard LMS','FontSize',15)


subplot(2,4,6)
plot(signerr.^2)
xlim([0,1000]);
xlabel('Steps','FontSize',15)
ylabel('Magnitude','FontSize',15)
title('Error^2 Signed-Error','FontSize',15)

subplot(2,4,7)
plot(regerr.^2)
xlim([0,1000]);
xlabel('Steps','FontSize',15)
ylabel('Magnitude','FontSize',15)
title('Error^2 Signed-Regressor','FontSize',15)

subplot(2,4,8)
plot(sserr.^2)
xlim([0,1000]);
xlabel('Steps','FontSize',15)
ylabel('Magnitude','FontSize',15)
title('Error^2 Sign-Sign','FontSize',15)

% prediction plots
subplot(2,4,1)
plot([1:1000],pred,'LineWidth',1)
hold on
plot([1:1000],E,'r')
hold off
axis([0 1000 -1 1])
title('Standard LMS','FontSize',15)
xlabel('Steeps','FontSize',15)
ylabel('Magnitude','FontSize',15)
legend('Estimated','Original','FontSize',13)


subplot(2,4,2)
plot([1:1000],sign1,'LineWidth',1)
hold on
plot([1:1000],T,'r')
hold off
axis([0 1000 -1 1])
title('Signed-Error','FontSize',15)
xlabel('Steps','FontSize',15)
ylabel('Magnitude','FontSize',15)



subplot(2,4,3)
plot([1:1000],reg1,'LineWidth',1)
hold on
plot([1:1000],E,'r')
hold off
axis([0 1000 -1 1])
title('Signed-Regressor','FontSize',15)
xlabel('Steps','FontSize',15)
ylabel('Magnitude','FontSize',15)



subplot(2,4,4)
plot([1:1000],ss1,'LineWidth',1)
hold on
plot([1:1000],E,'r')
hold off
axis([0 1000 -1 1])
title('Sign-Sign','FontSize',15)
xlabel('Steps','FontSize',15)
ylabel('Magnitude','FontSize',15)


% weight plots
figure(3)
subplot(1,4,1)
for i = 1:order
    plot(w(i,:))
    hold on
end
title('Standard LMS','FontSize',12)
xlabel('Steps','FontSize',12);
ylabel('Coefficients','FontSize',12)
xlim([0,1000])
legend('w1','w2','w3','w4','FontSize',11)

subplot(1,4,2)
for i = 1:order
    plot(signw(i,:))
    hold on
end
title('Sign-Error','FontSize',12)
xlabel('Steps','FontSize',12);
ylabel('Coefficients','FontSize',12)
xlim([0,1000])


subplot(1,4,3)
for i = 1:order
    plot(regw(i,:))
    hold on
end
title('Sign-Regressor','FontSize',12)
xlabel('Steps','FontSize',12);
ylabel('Coefficients','FontSize',12)
xlim([0,1000])

subplot(1,4,4)
for i = 1:order
    plot(ssw(i,:))
    hold on
end
title('Sign-Sign','FontSize',12)
xlabel('Steps','FontSize',12);
ylabel('Coefficients','FontSize',12)
xlim([0,1000])


%%
function [pred, w, err, sign1, reg1, ss1, signw, regw, ssw, signerr, regerr, sserr]= lms_sign(x, gain, order)
    N = length(x);
    w = zeros(order,N);
    pred = zeros(N,1);
    err = zeros(N,1);

    for i = order+1:N 
        pred(i) = (w(:,i)')*x(i-1:-1:i-order);
        err(i) = x(i)-pred(i);
        w(:,(i+1)) = w(:,i) + gain*err(i)*x(i-1:-1:i-order);
    end

    sign1 = zeros(N,1);
    signw = zeros(order,N); 
    signerr = zeros(N,1);
   
    % sign error
    for i = order+1:N
        
        sign1(i) = (signw(:,i)')*x(i-1:-1:i-order);
        signerr(i) = x(i)- sign1(i);
        signw(:,(i+1)) = signw(:,i) + gain*sign(signerr(i))*x(i-1:-1:i-order);
    end
    
    % sign regressor
    reg1 = zeros(N,1);
    regw = zeros(order,N); 
    regerr = zeros(N,1);
    
    for i = order+1:N
  
        reg1(i) = (regw(:,i)')*x(i-1:-1:i-order);
        regerr(i) = x(i)- reg1(i);
        regw(:,(i+1)) = regw(:,i) + gain*regerr(i)*sign(x(i-1:-1:i-order));
    end
    
    % sign sign
    ss1 = zeros(N,1);
    ssw = zeros(order,N); 
    sserr = zeros(N,1);
   
    for i = order+1:N
        
        ss1(i) = (ssw(:,i)')*x(i-1:-1:i-order);
        sserr(i) = x(i)- ss1(i);
        ssw(:,(i+1)) = ssw(:,i) + gain*sign(sserr(i))*sign(x(i-1:-1:i-order));
    end

end