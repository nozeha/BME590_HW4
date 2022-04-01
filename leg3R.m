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

th1 = [0.01; 0]; % initial angle theta1 (degrees)
th2 = [-0.01; 0]; % initial angle theta2 (degrees)
th3 = [0.01; 0]; % initial angle theta3 (degrees)

th1d = [0; 0]; % initial angle theta1 (degrees)
th2d = [0; 0]; % initial angle theta2 (degrees)
th3d = [0; 0]; % initial angle theta3 (degrees)

J = zeros(3, 3); % initializing jacobian matrix
invJ = zeros(3, 3); % initializing inverse-jacobian matrix

%% Calculations
interval = time(2) - time(1);

xDot = deriv3pt(x, interval);
yDot = deriv3pt(y, interval);
phiDot = deriv3pt(phi, interval);

for k = 2:length(data)
    nu = [xDot(k-1); yDot(k-1); phiDot(k-1)];

    % calculate jacobian
    J(1, 1) = -1*Lu*sin(th1(k-1)) - Ll*sin(th1(k-1)+th2(k-1));
    J(1, 2) = -1*Ll*sin(th1(k-1) + th2(k-1));
    J(2, 1) = Ll*cos(th1(k-1)+th2(k-1)) + Lu*cos(th1(k-1));
    J(2, 2) = Ll*cos(th1(k-1) + th2(k-1)); 
    J(3, 1) = 1;
    J(3, 2) = 1;
    J(3, 3) = 1;

%     invJ(1, 1) = J(1, 1);
%     invJ(1, 2) = J(2, 1);
%     invJ(1, 3) = J(3, 1);
%     invJ(2, 1) = J(1, 2);
%     invJ(2, 2) = J(2, 2);
%     invJ(2, 3) = J(3, 2);
%     invJ(3, 1) = J(1, 3);
%     invJ(3, 2) = J(2, 3);
%     invJ(3, 3) = J(3, 3);

    thetaDot = inv(J) * nu;

    th1d(k) = thetaDot(1);
    th2d(k) = thetaDot(2);
    th3d(k) = thetaDot(3);

    th1(k) = trapz(th1d(k-1:k)) + th1(k-1);
    th2(k) = trapz(th2d(k-1:k)) + th2(k-1);
    th3(k) = trapz(th3d(k-1:k)) + th3(k-1);
end

%% Output

T = [time th1 th2 th3]; 

writematrix(T, 'theta.txt');
% xlswrite('theta', T);

toc