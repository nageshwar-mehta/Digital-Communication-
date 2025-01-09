close all;
clear all;
clc;
t = -1:0.01:1; 
len = length(t);
d = 1;

%xt = rectpuls(t,d); % Pulse signal
yf = fft(xt);
yf_abs = abs(yf);
plot(yf_abs);
