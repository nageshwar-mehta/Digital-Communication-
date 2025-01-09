fs = 1000;           
T = 1;                
f = 2;               
t = 0:1/fs:T-1/fs;     


input_signal = square(2*pi*f*t);
noise_power=0.2;

noise =sqrt(noise_power)*randn(size(t));

input_noisesignal=input_signal+noise;

matched_filter = fliplr(input_noisesignal); 

output_signal = conv(input_signal, matched_filter, 'same');

figure;
subplot(3,1,1);
plot(t, input_signal);
title('Input Signal (Square Wave)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,2);
plot(t, matched_filter);
title('Matched Filter');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,3);
plot(t, output_signal(1:length(t)));
title('Output Signal (Matched Filtered)');
xlabel('Time (s)');
ylabel('Amplitude');
Eo =trapz(t, input_signal.^2);
NO= noise_power;
x= sqrt((2 * Eo) /NO);
y = qfunc( x ) ;
disp(['Probability of Error P_e:', num2str(y)]);