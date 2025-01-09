clc;
clear;
a = input('Enter the sequence length: ');
f1= input('Enter the frequency of low frequency carrier: ');
f2= input('Enter the frequency of high frequency carrier: ');
n=randi([0 1],1,a);    % Generates a random binary sequence of length 'a'.

for i = 1:length(n)
    if n(i)==1
        d(i)=1;     %This loop copies the binary sequence n into a new array d.
    else
        d(i)=0;
    end
end
%Generate the Binary Waveform
i=1;
t=0:0.01:length(n); %Creates a time vector for the entire binary sequence with a step size of 0.01 seconds.
for j=1:length(t)
    if t(j)<=i
        y(j)=d(i);
    else
        y(j)=d(i);
        i=i+1;                    %The loop generates a binary waveform (y) over time.
    end
end

%Plot the Binary Signal
subplot(5,1,1);
plot(t,y);
xlabel('Time');
ylabel('Amplitude');
title('Base band signal');            %The binary sequence is displayed as a rectangular waveform over time.
axis([0 length(n) -2 2]);

%Generate and Plot Low-Frequency Carrier
c1 = cos(2*pi*f1*t);
subplot(5,1,2);
plot(t,c1);
xlabel('Time');
ylabel('Amplitude');
title('Low Frequency Carrier');
axis([0 length(n) -2 2]);

%Generate and Plot High-Frequency Carrier
c2 = cos(2*pi*f2*t);
subplot(5,1,3);
plot(t,c2);
xlabel('Time');
ylabel('Amplitude');
title('High Frequency Carrier');
axis([0 length(n) -2 2]);
%Modulate the BFSK Signal
for j = 1:length(t)
    if y(j) == 0
        z(j)=c1(j);
    else
        z(j)=c2(j);
    end
end
subplot(5,1,4);
plot(t,z);
xlabel('Time');
ylabel('Amplitude');
title('BFSK Signal');
axis([0 length(n) -2 2]);


%Demodulate the BFSK Signal
for j=1:length(t)
    if z(j)==c1(j) && y(j)==0
        x(j)=0;
    else
        x(j)=1;
    end
end

subplot(5,1,5); 
plot(t,x);
xlabel('Time');
ylabel('Amplitude');
title('De-modulated Signal');
axis([0 length(n) -2 2]);