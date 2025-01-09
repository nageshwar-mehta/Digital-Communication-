%BPSK 
% Parameters
data_bits = [1 0 1 1 0 1 0 0];  % Binary data to be transmitted
bit_rate = 1e3;                 % Bit rate in bits per second
carrier_freq = 5e3;             % Carrier frequency in Hz
sampling_freq = 1e5;            % Sampling frequency (must be much higher than carrier frequency)
samples_per_bit = sampling_freq / bit_rate;  % Number of samples per bit

% Generate time vector for the signal duration
t = 0:1/sampling_freq:(length(data_bits)/bit_rate) - 1/sampling_freq;

% Generate the carrier signal
carrier = cos(2 * pi * carrier_freq * t);

% BPSK modulation
bpsk_signal = zeros(1, length(t));  % Initialize BPSK signal
for i = 1:length(data_bits)
    if data_bits(i) == 1
        bpsk_signal((i-1)*samples_per_bit+1:i*samples_per_bit) = carrier((i-1)*samples_per_bit+1:i*samples_per_bit);
    else
        bpsk_signal((i-1)*samples_per_bit+1:i*samples_per_bit) = -carrier((i-1)*samples_per_bit+1:i*samples_per_bit);
    end
end

% Plot the results
figure;
subplot(3, 1, 1);
stairs([data_bits data_bits(end)], 'LineWidth', 2);  % Plot data bits
title('Binary Data');
ylabel('Amplitude');
axis([1 length(bpsk_signal)/samples_per_bit -0.5 1.5]);
grid on;

subplot(3, 1, 2);
plot(t, carrier);
title('Carrier Signal');
ylabel('Amplitude');
xlabel('Time (s)');
grid on;

subplot(3, 1, 3);
plot(t, bpsk_signal);
title('BPSK Modulated Signal');
ylabel('Amplitude');
xlabel('Time (s)');
grid on;
