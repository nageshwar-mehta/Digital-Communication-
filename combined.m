% Parameters
fs = 1000;                % Sampling frequency (Hz)
T = 1;                    % Duration of the signal (seconds)
t = 0:1/fs:T;            % Time vector

% Rectangular pulse parameters
w1 = 0.1;                % Width of the first pulse (seconds)
w2 = 0.1;                % Width of the second pulse (seconds)
delay = 0.15;            % Delay for the second pulse (seconds)

% Generate rectangular pulses
pulse1 = rectpuls(t - (T/2), w1);   % First pulse centered at T/2
pulse2 = -1 * rectpuls(t - (T/2 + delay), w2); % Inverted second pulse
pulse3 = rectpuls(t - 0.8, w1);      % Third pulse from 0.75s to 0.85s

% Combine pulses to observe ISI
combined_pulses = pulse1 + pulse2 + pulse3; % Include third pulse in combination

% Fourier Transform of each pulse
N = length(t);               % Number of points in the signal
f1 = fft(pulse1, N);        % FFT of Pulse 1
f2 = fft(pulse2, N);        % FFT of Pulse 2
f3 = fft(pulse3, N);        % FFT of Pulse 3

% Shift zero frequency component to center
f1_shifted = fftshift(f1);
f2_shifted = fftshift(f2);
f3_shifted = fftshift(f3);

% Combine Fourier Transforms
combined_f_transform = f1_shifted + f2_shifted + f3_shifted;

% Frequency range calculation (only positive frequencies)
f_range = linspace(0, fs, N); 

% Plotting time domain pulses
figure;

% First Pulse
subplot(4, 1, 1);
plot(t, pulse1, 'b', 'LineWidth', 2);
title('Rectangular Pulse 1');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Second Pulse
subplot(4, 1, 2);
plot(t, pulse2, 'r', 'LineWidth', 2);
title('Rectangular Pulse 2 (Delayed and Inverted)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Third Pulse
subplot(4, 1, 3);
plot(t, pulse3, 'g', 'LineWidth', 2);
title('Rectangular Pulse 3 (From 0.75s to 0.85s)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Combined Pulses
subplot(4, 1, 4);
plot(t, combined_pulses, 'k', 'LineWidth', 2);
title('Combined Pulses Showing Intersymbol Interference');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Adjust layout for time domain plots
sgtitle('Intersymbol Interference with Rectangular Pulses'); 

% Create a new figure for frequency domain plots
figure;

% Plot Fourier Transforms without starting from origin
subplot(4, 1, 1);
plot(f_range, abs(f1)/N, 'b', 'LineWidth', 2); % Normalized magnitude
xlim([0 fs/2]); % Limit x-axis to positive frequencies only
title('Fourier Transform of Rectangular Pulse 1');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

subplot(4, 1, 2);
plot(f_range, abs(f2)/N, 'r', 'LineWidth', 2); % Normalized magnitude
xlim([0 fs/2]); % Limit x-axis to positive frequencies only
title('Fourier Transform of Rectangular Pulse 2');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

subplot(4, 1, 3);
plot(f_range, abs(f3)/N, 'g', 'LineWidth', 2); % Normalized magnitude
xlim([0 fs/2]); % Limit x-axis to positive frequencies only
title('Fourier Transform of Rectangular Pulse 3');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

% Combined Fourier Transform Plot without starting from origin
subplot(4, 1, 4);
plot(f_range, abs(combined_f_transform)/N, 'k', 'LineWidth', 2); % Normalized magnitude
xlim([0 fs/2]); % Limit x-axis to positive frequencies only
title('Combined Fourier Transform of All Pulses');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

% Adjust layout for frequency domain plots
sgtitle('Fourier Transforms of Rectangular Pulses');