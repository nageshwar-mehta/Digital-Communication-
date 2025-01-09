clear all;
close all;
clc;
% Define the vectors
v1 = [1; 0; 1];
v2 = [1; 1; 0];
v3 = [0; 1; 1];

% Step 1: Start with the first basis vector
b1 = v1 / norm(v1); % Normalize v1 to get the first orthonormal vector

% Step 2: Remove the component of v2 in the direction of b1
p2 = dot(v2, b1); % Projection of v2 onto b1
g2 = v2 - p2 * b1; % Remove the component of v2 along b1
b2 = g2 / norm(g2); % Normalize to get the second orthonormal vector

% Step 3: Remove the components of v3 in the direction of b1 and b2
p3_b1 = dot(v3, b1); % Projection of v3 onto b1
p3_b2 = dot(v3, b2); % Projection of v3 onto b2
g3 = v3 - p3_b1 * b1 - p3_b2 * b2; % Remove components in the direction of b1 and b2
b3 = g3 / norm(g3); % Normalize to get the third orthonormal vector

% Display the orthonormal basis vectors
fprintf('Orthonormal Basis Vectors:\n');
disp(b1);
disp(b2);
disp(b3);
figure;
plot3(dot(v1,b1),dot(v1,b2),dot(v1,b3),"x",MarkerSize=10);
xlabel("b1") 
ylabel("b2") 
zlabel("b3")