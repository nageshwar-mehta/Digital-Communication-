% Clear all variables, close figures, and clear command window
clear all;
clc;
close all;

% Parameters
n = 8; % Number of bits
SNR_db = 0:0.2:100; % SNR range in dB
SNR = 10.^(SNR_db/10);

% % Generate BPSK Data Bits
data_bits = randi([0, 1], 1, n, "int8"); % Random binary data to be transmitted
for i = 1:length(data_bits)
    if data_bits(i) == 0
        data_bits(i) = -1; % Convert 0s to -1 for BPSK modulation
    end
end
display(data_bits);

% Transmission Parameters
bit_rate = 1e3;                  % Bit rate in bits per second
carrier_freq1 = 5e2;  % Carrier frequency in Hz
carrier_freq2 = 5e3;
sampling_freq = 1e5;             % Sampling frequency (must be much higher than carrier frequency)
samples_per_bit = sampling_freq / bit_rate;  % Number of samples per bit

% Generate time vector for the signal duration
t = 0:1/sampling_freq:(length(data_bits) / bit_rate) - 1 / sampling_freq;

% Generate the carrier signal
carrier1 = cos(2 * pi * carrier_freq1 * t); % Carrier waveform at specified frequency
carrier2 = cos(2 * pi * carrier_freq2 * t);

% BPSK Modulation
bpsk_signal = zeros(1, length(t));  % Initialize BPSK modulated signal
for i = 1:length(data_bits)
    if data_bits(i) == 1
        bpsk_signal((i-1)*samples_per_bit+1 : i*samples_per_bit) = carrier1((i-1)*samples_per_bit+1 : i*samples_per_bit);
    else
        bpsk_signal((i-1)*samples_per_bit+1 : i*samples_per_bit) = -carrier2((i-1)*samples_per_bit+1 : i*samples_per_bit);
    end
end

% Add Gaussian Noise to the BPSK Signal
Noisy_signal = awgn(bpsk_signal, 10); 



% Calculate Bit Energy (Eb)
Eb = sum(data_bits.^2) / length(data_bits); % Average bit energy
display(Eb);

% Calculate Noise Power and Probability of Error (Pe)
noise_power = Eb ./ SNR; % Calculate noise power for each SNR value
Pe = qfunc(sqrt(2 * SNR)); % Calculate theoretical Pe using Q-function

% Demodulate Noisy Signal
noisysignal_list = awgn(bpsk_signal,0.0001);
guess_bits = zeros(1, length(data_bits));
for i = 1:length(data_bits)
    if Noisy_signal((i-1)*samples_per_bit+1) > 0
        guess_bits(i) = 1;
    else
        guess_bits(i) = -1;
    end
end
display(guess_bits);

% Calculate Bit Error Rate (BER)
% Count the number of bit errors
bit_errors = sum(data_bits ~= guess_bits);

% Calculate BER
BER = bit_errors / length(data_bits);

% Display BER
disp(['Bit Error Rate (BER): ', num2str(BER)]);

% Plot Probability of Error (Pe) vs. SNR
figure;
semilogy(SNR_db, Pe);
title('Pe vs SNR');
ylabel('Probability of Error (Pe)');
xlabel('SNR (dB)');
grid on;

% Plot the results
figure;
subplot(4, 1, 1);
stairs([data_bits data_bits(end)], 'LineWidth', 2);  % Plot data bits
title('Binary Data');
ylabel('Amplitude');
axis([1 length(bpsk_signal) / samples_per_bit -1.5 1.5]);
grid on;

subplot(4, 1, 2);
plot(t, carrier1);
title('Carrier Signal');
ylabel('Amplitude');
xlabel('Time (s)');
grid on;

subplot(4, 1, 3);
plot(t, bpsk_signal);
title('BPSK Modulated Signal');
ylabel('Amplitude');
xlabel('Time (s)');
grid on;

subplot(4, 1, 4);
plot(t, Noisy_signal);
title('Noisy Signal');
ylabel('Amplitude');
xlabel('Time (s)');
grid on;
