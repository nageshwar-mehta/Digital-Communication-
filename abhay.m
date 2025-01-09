clear all
close all
clc


x=[1,2,5,7];
y=[1;2;5;7];
%% creating new subsection
syms x %% x is one symbol%%


%% creation of matrix
z=[1,3;5,6];
z1=[3;4];
z2=z*z1;
% ; for not displaying the line
inv(z)

m=[1,2,3,4;11,21,33,44;11,23,24,34;1,0,0,0];
inv(m)
