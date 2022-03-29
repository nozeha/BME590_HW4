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
data = xlsread('data.xls');
time = data(:, 1);
x = data(:, 2);
y = data(:, 3);
phi = data(:, 4);

%% Declarations
Lu = 30; % upper leg length (cm)
Ll = 30; % lower leg length (cm)

%% Calculations
