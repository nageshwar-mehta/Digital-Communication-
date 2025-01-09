close all;
clear all;
clc;


fs = 10e3;
t = -0.1:1/fs:0.1;

w = 20e-3;

x = rectpuls(t,w);
plot(t,x);