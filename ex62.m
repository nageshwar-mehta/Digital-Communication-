t = -2:0.01:2;
pulse_width = 4;
amplitude = 1;

pulse_signal = amplitude * rectpuls(t, pulse_width);

SNR = 20; 
noisy_pulse_signal = awgn(pulse_signal, SNR, 'measured');

figure;
subplot(3,1,1);
plot(t, pulse_signal);
xlabel('Time');
ylabel('Amplitude');
title('Original Rectangular Pulse Signal');
grid on;

subplot(3,1,2);
plot(t, noisy_pulse_signal);
xlabel('Time');
ylabel('Amplitude');
title('Rectangular Pulse Signal with AWGN');
grid on;

t1 = -4:0.01:4;
ht = noisy_pulse_signal;
yt = conv(transpose(ht), ht);

subplot(3,3,3);
plot(t1,yt);
xlabel('Time');
ylabel('Amplitude');
title('Convolution of Noisy Pulse Signal');
grid on;

E0 = trapz(t, input_signal.^2);
NO  noise_power
Pe = sqrt((2 * E0) / NO);
disp(['Probability of Error P_e:', num2str(Pe)]);