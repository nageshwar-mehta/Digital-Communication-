clc;
clear all;
close all;

% Parameters
N = 1e4;           % Reduced number of bits (10,000)
SNR_dB = 0:4:20;   % Coarser SNR range in dB
BER = zeros(size(SNR_dB)); % Initialize BER array

% Transmitter: Generate random bits
data_bits = randi([0 1], 1, N); % Generate random bits

% BFSK Modulation Parameters
fc1 = 100;  % Frequency for bit 1 (Hz)
fc0 = 200;  % Frequency for bit 0 (Hz)
Tb = 1;     % Bit duration (s)
fs = 1e3;   % Reduced sampling frequency (1 kHz)
t = 0:1/fs:Tb-(1/fs); % Time vector for one bit
carrier1 = sqrt(2/Tb) * cos(2*pi*fc1*t); % Carrier for bit 1
carrier0 = sqrt(2/Tb) * cos(2*pi*fc0*t); % Carrier for bit 0

% Loop over each SNR value
for i = 1:length(SNR_dB)
    % Convert SNR from dB to linear scale
    SNR = 10^(SNR_dB(i) / 10);
    
    % Calculate noise variance (N0/2 per dimension)
    noise_variance = 1 / (2 * SNR);
    
    % BFSK Modulation: Generate the modulated signal
    modulated_signal = [];
    for bit = data_bits
        if bit == 1
            modulated_signal = [modulated_signal, carrier1]; % carrier for bit 1
        else
            modulated_signal = [modulated_signal, carrier0]; %  carrier for bit 0
        end
    end
    
    % AWGN channel: Add Gaussian noise
    noise = sqrt(noise_variance) * randn(size(modulated_signal));
    received_signal = modulated_signal + noise; % Received signal with noise
    
    % Receiver: Coherent Demodulation
    demodulated_bits = [];
    for k = 1:N
        % Extract one bit's received signal
        received_bit_signal = received_signal((k-1)*length(t)+1 : k*length(t));
        
        % Correlate with both carriers
        correlation1 = sum(received_bit_signal .* carrier1); % Correlation with bit 1 carrier
        correlation0 = sum(received_bit_signal .* carrier0); % Correlation with bit 0 carrier
        
        % Decision rule: Choose the maximum correlation
        if correlation1 > correlation0
            demodulated_bits = [demodulated_bits, 1];
        else
            demodulated_bits = [demodulated_bits, 0];
        end
    end
    
    % Calculate the number of bit errors
    num_errors = sum(data_bits ~= demodulated_bits);
    
    % Calculate BER for this SNR value
    BER(i) = num_errors / N;
end

% Theoretical BER for BFSK
theory_BER = 0.5 * erfc(sqrt(10.^(SNR_dB/10)/2));

% Plot BER vs SNR
figure;
semilogy(SNR_dB, BER, 'b-o', 'LineWidth', 1.5); % Simulated BER
hold on;
semilogy(SNR_dB, theory_BER, 'r-', 'LineWidth', 1.5); % Theoretical BER
grid on;
xlabel('SNR (dB)');
ylabel('Bit Error Rate (BER)');
title('BFSK BER Performance in AWGN Channel');
legend('Simulation', 'Theory');
