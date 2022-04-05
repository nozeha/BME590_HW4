% leg3R.m
% Noor Hakam
% nzhakam@ncsu.edu
% 29 March 2022
%
% Homework 4, Question 1

%% Start
clear
clc
close all
tic

%% Load Data
data = readmatrix('data.xls');
time = data(:,1);
x = data(:,2);
y = data(:,3);
phi = data(:,4);

%% Declarations
Lu = 46; % upper leg length (cm)
Ll = 38; % lower leg length (cm)

th1(1) = 0.01; % initial angle theta1 (rad)
th2(1) = -0.01; % initial angle theta2 (rad)
th3(1) = 0.01; % initial angle theta3 (rad)

th1d(1) = 0; % initial angle theta1 (rad/s)
th2d(1) = 0; % initial angle theta2 (rad/s)
th3d(1) = 0; % initial angle theta3 (rad/s)

J = zeros(3, 3); % initializing jacobian matrix
invJ = zeros(3, 3); % initializing inverse-jacobian matrix

%% Calculations
interval = time(2) - time(1);

xDot = deriv3pt(x, interval);
yDot = deriv3pt(y, interval);
phiDot = deriv3pt(phi, interval);

for k = 2:length(data)
    nu = [xDot(k); yDot(k); phiDot(k)];

    % calculate jacobian
    J(1, 1) = -1*Lu*sin(th1(k-1)) - Ll*sin(th1(k-1)+th2(k-1));
    J(1, 2) = -1*Ll*sin(th1(k-1) + th2(k-1));
    J(2, 1) = Ll*cos(th1(k-1)+th2(k-1)) + Lu*cos(th1(k-1));
    J(2, 2) = Ll*cos(th1(k-1) + th2(k-1)); 
    J(3, 1) = 1;
    J(3, 2) = 1;
    J(3, 3) = 1;

    thetaDot = inv(J) * nu;

    th1d(k) = thetaDot(1);
    th2d(k) = thetaDot(2);
    th3d(k) = thetaDot(3);

    th1(k) = 0.5*interval*(th1d(k)+th1d(k-1)) + th1(k-1);
    th2(k) = 0.5*interval*(th2d(k)+th2d(k-1))+ th2(k-1);
    th3(k) = 0.5*interval*(th3d(k)+th3d(k-1))+ th3(k-1);
end

%% Output

T = [time th1' th2' th3']; 

writematrix(T, 'theta.txt');
%xlswrite('theta', T);

toc