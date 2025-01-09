% Parameters
Rb = 1e3; % Bit rate in bits per second
Fs = 10 * Rb; % Sampling frequency (10x oversampling for smoother signal)
T = 1 / Rb; % Symbol period
N = 100; % Number of symbols
sps = Fs / Rb; % Samples per symbol

% Generate Random Data for Binary PAM (-1 and 1 values)
data = randi([0 1], N, 1) * 2 - 1;

% Generate Pulse Train by Upsampling Data
pulse_train = upsample(data, sps); % Insert sps - 1 zeros between each data symbol

% Define a Rectangular Pulse Shape
rect_pulse = ones(sps, 1); % Create a single rectangular pulse of 1 symbol width

% Create the Transmitted Signal by Convolution
tx_signal = conv(pulse_train, rect_pulse, 'same');

% Plotting
figure;
subplot(2,1,1);
stem(data, 'filled');
title('Original Data Sequence');
xlabel('Symbol Index');
ylabel('Amplitude');

subplot(2,1,2);
plot(tx_signal);
title('Pulse Train Signal');
xlabel('Time (samples)');
ylabel('Amplitude');

% Eye diagram to visualize ISI effect (optional)
eyediagram(tx_signal, 2*sps, sps);
title('Eye Diagram of Pulse Train Signal');
