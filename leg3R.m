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
Lu = 30; % upper leg length (cm)
Ll = 30; % lower leg length (cm)

th1 = [0.0001]; % initial angle theta1 (degrees)

th2 = [0.0001]; % initial angle theta2 (degrees)
th3 = [0.0001]; % initial angle theta3 (degrees)

%% Calculations
interval = time(2) - time(1);

xDot = deriv3pt(x, interval);
yDot = deriv3pt(y, interval);
phiDot = deriv3pt(phi, interval);

for k = 1:length(data)
    nu = [xDot(k); yDot(k); phiDot(k)];

    T01 = LinkTransformation(0, 0, th1(k), 0);
    T12 = LinkTransformation(0, Lu, th2(k), 0);
    T23 = LinkTransformation(0, Ll, th3(k), 0);

    % calculate jacobian
    J = zeros(3, 6);

    thetaDot = pinv(J) * nu;

    theta = trapz(thetaDot);
    th1(k+1) = theta(1);
    th2(k+1) = theta(2);
    th3(k+1) = theta(3);
end

toc