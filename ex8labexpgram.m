clc; 
clear; 
T=4; 
t=linspace(0,T,5000); 
% Arbitary signals/pulses 
s1=3*rectpuls(t-1,1); %A rectangular pulse shifted by 1/2,scaled by 2, and with a width of 1.
s2=-2*rectpuls(t-3/2,2); 
s3=4*rectpuls(t-2,3); 

% Basis functions & projections using Gram-Schmidt orthogonalization 
b1=s1/sqrt(trapz(t,s1.*s1)); %The first basis function b1 is created by normalizing s1, trapz(t, s1.*s1)calculates the energy of the signal 
p2=trapz(t,s2.*b1);% Projection of s2 onto b1 
g2=s2-p2.*b1; % Removing component in the direction of b1

b2=g2/sqrt(trapz(t,g2.*g2)); % Normalizing to get b2
p3=trapz(t,s3.*b1); % Projection of s3 onto b1
p4=trapz(t,s3.*b2); % Projection of s3 onto b2
g3=s3-p3.*b1-p4.*b2; % Removing components in the direction of b1 and b2
b3=g3/sqrt(trapz(t,g3.*g3)); % Normalizing to get b3
% Plot 
figure 
subplot(2,1,1) 
plot(t,s1,t,s2,t,s3) 
ylabel('Amplitude') 
title("Given set of Non-orthogonal signals") 
legend("s1","s2","s3") 
grid on 
subplot(2,1,2) 
plot(t,b1,t,b2,t,b3) 
xlabel("time(s)") 
ylabel('Amplitude') 
title("Set of Orthonormal Basis Function") 
legend("b1","b2","b3") 
grid on 
figure 
plot3(trapz(t,s1.*b1),trapz(t,s1.*b2),trapz(t,s1.*b3),"x",MarkerSize=10) 
hold on 
plot3(trapz(t,s2.*b1),trapz(t,s2.*b2),trapz(t,s2.*b3),"x",MarkerSize=10) 
plot3(trapz(t,s3.*b1),trapz(t,s3.*b2),trapz(t,s3.*b3),"x",MarkerSize=10) 
xlabel("b1") 
ylabel("b2") 
zlabel("b3") 
title("Signal Space Representation") 
legend("s1","s2","s3") 
grid on 