close all;
clear all;
clc;

beta = 0.025;  % Roll-off factor
span = 4;      % Filter span in symbols
sps = 10;      % Increase Samples per symbol for smoother graph

xt = rcosdesign(beta, span, sps, 'normal'); % Raised cosine filter signal

% Time vector should match the length of the signal 'xt'
t = linspace(-span, span, length(xt));  % Adjust time vector length

% Perform FFT
yf = fft(xt); 
yf_abs = abs(fftshift(yf)); % Shift and get the magnitude of the FFT
f = linspace(-0.5, 0.5, length(xt)); % Frequency vector

% Plot of Raised Cosine Pulse
subplot(2,1,1);
plot(t, xt);
xlabel('time (sec)');
ylabel('Magnitude');
title('Raised Cosine Pulse Signal');
grid on;

% Plot magnitude of FFT
subplot(2,1,2);
plot(f, yf_abs);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude Spectrum of Raised Cosine Pulse');
grid on;
