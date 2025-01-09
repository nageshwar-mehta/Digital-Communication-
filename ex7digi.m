close all;
clear all;
clc;

t = -1:0.01:1; % Time vector
d = 0.1; % Pulse width

xt = rectpuls(t+0.3,d); % Rectangular pulse signal
%Plot of Pulse signal
subplot(2,1,1);
plot(t, xt);
xlabel('time (sec)');
ylabel('Magnitude');
title('Amplitude');
grid on;
% Perform FFT
subplot(2,1,2);
yf = fft(xt); 
yf_abs = 0.01*abs(fftshift(yf)); % Shift and get the magnitude of the FFT
f = linspace(-0.5, 0.5, length(t)); % Frequency vector (adjust for sampling rate)
display(length(f));
% Plot magnitude of FFT
plot(f, yf_abs);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude Spectrum of Rectangular Pulse');
grid on;