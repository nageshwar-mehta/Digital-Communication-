% Parameters
Rb = 1e3; % Bit rate in bits per second
Fs = 10 * Rb; % Sampling frequency
T = 1 / Rb; % Symbol period
N = 100; % Number of symbols

% Generate Random Data
data = randi([0 1], N, 1) * 2 - 1; % Generate -1 and 1 for binary PAM

% Pulse Shaping with Raised Cosine Filter
beta = 0.25; % Roll-off factor for the raised cosine filter
span = 6; % Filter span in symbol durations
sps = Fs / Rb; % Samples per symbol

% Create raised cosine filter
rc_filter = rcosdesign(beta, span, sps);

% Transmit signal by convolving with raised cosine filter
tx_signal = upfirdn(data, rc_filter, sps);

% Introduce channel (simple delay)
delay = 5; % Delay in samples to simulate ISI
isi_signal = [zeros(delay, 1); tx_signal(1:end - delay)];

% Matched filter (using same raised cosine filter at the receiver)
rx_signal = conv(isi_signal, rc_filter, 'same');

% Downsampling to get symbol-spaced samples
rx_downsampled = downsample(rx_signal, sps);

% Plotting
figure;
subplot(3,1,1);
plot(tx_signal);
title('Transmitted Signal with Raised Cosine Pulse Shaping');
xlabel('Time');
ylabel('Amplitude');

subplot(3,1,2);
plot(isi_signal);
title('ISI Affected Signal');
xlabel('Time');
ylabel('Amplitude');

subplot(3,1,3);
stem(rx_downsampled(1:N));
title('Received Signal After Matched Filtering');
xlabel('Symbol Index');
ylabel('Amplitude');

% Eye diagram for visualization of ISI effect
eyediagram(rx_signal, 2*sps, sps);
title('Eye Diagram with ISI');

