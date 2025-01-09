close all;
clear all;
clc;

% Generate the rectangular pulse signal
t = -1:0.01:1; 
len = length(t);
d = 1;
xt = rectpuls(t,d); % Pulse signal
ht = fliplr(xt);    % Matched filter (time-reversed pulse)

% Plot the pulse signal
subplot(2,2,1)
plot(t, xt);
xlabel('Time');
ylabel('Amplitude');
title('Pulse Signal');
grid on;

% Convolve the pulse signal with the matched filter
yt = conv(xt,ht);
t_conv = -2:0.01:2; % Adjust time vector after convolution

subplot(2,2,2);
plot(t_conv, yt);
xlabel('Time');
ylabel('Amplitude');
title('Matched Response');
grid on;

% Add AWGN to the pulse signal
xtnt = awgn(xt,10,'measured');

% Plot the noisy signal
subplot(2,2,3);
plot(t, xtnt);
xlabel('Time');
ylabel('Amplitude');
title('Noisy Signal');
grid on;

% Convolve the noisy signal with the matched filter
yt2 = conv(xtnt,ht);
t2 = -2:0.01:2;

subplot(2,2,4);
plot(t2, yt2);
xlabel('Time');
ylabel('Amplitude');
title('Matched Response (Noisy Signal)');
grid on;

% Calculate the probability of error (P_e)
noise_power = 0.5;
Eo = trapz(t, xt.^2); % Energy of the original signal
NO = 1;

x = sqrt((2 * Eo) / NO);
y = qfunc(x);
disp(['Probability of Error P_e: ', num2str(y)]);

% Probability of Error vs SNR
SNR_dB = -10:1:10; 
SNR = 10.^(SNR_dB/10); 
Pe = zeros(size(SNR)); 

for i = 1:length(SNR)
    Pe(i) = qfunc(sqrt(SNR(i) * Eo / NO)); % Use Eo instead of E
end

figure; 
semilogy(SNR_dB, Pe, 'o-'); 
grid on;
xlabel('SNR (dB)');
ylabel('Probability of Error (P_e)');
title('Probability of Error vs SNR');
axis tight; % Adjust axis limits to fit data


