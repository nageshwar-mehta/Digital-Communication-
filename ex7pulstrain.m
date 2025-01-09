close all;
clear all;
clc;

% Generate the rectangular pulse signal
t = -1:0.01:1; % Time vector
d = 0.5;       % Width of the rectangular pulse
fs = 1000;     % Sampling frequency
pulse_width = 0.5; % Width of each pulse in the train

% Create a single rectangular pulse of width 'd'
x = rectpuls(t+0.4, d); 

% Generate time delays for pulse train (e.g., every 1 second)
delays = -2:1:2; % Time locations for each pulse in the train

% Create the pulse train using pulstran
xt = pulstran(t, delays, @rectpuls, d);

% Plot the pulse train
subplot(2,1,1);
plot(t, xt);
xlabel('Time (sec)');
ylabel('Amplitude');
title('Pulse Train Signal');
grid on;

% If you want to perform FFT and plot its magnitude:
subplot(2,1,2);
yf = fft(xt); 
yf_abs = abs(fftshift(yf));
f = linspace(-fs/2, fs/2, length(xt)); % Frequency vector
plot(f, yf_abs);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude Spectrum of Pulse Train');
grid on;
