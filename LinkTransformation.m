function [T] = LinkTransformation(alpha, a, theta, d)

% LinkTransformation.m
% Noor Hakam
% nzhakam@ncsu.edu
% 10 February 2022
%
% Inputs:
%   alpha: the angle between Zi-1 and Zi wrt Xi-1 (rad)
%   a: the distance from Zi-1 to Zi along Xi-1
%   theta: the angle between Xi-1 and Xi wrt Zi (rad)
%   d: the distance from Xi-1 to Xi along Zi
%
% Output:
%   T = the 4x4 transformation matrix

T1 = cos(theta);
T2 = sin(theta) * cos(alpha);
T3 = sin(theta) * sin(alpha);
T4 = 0;

T5 = -1 * sin(theta);
T6 = cos(theta) * cos(alpha);
T7 = cos(theta) * sin(alpha);
T8 = 0;

T9 = 0;
T10 = -1 * sin(alpha);
T11 = cos(alpha);
T12 = 0;

T13 = a;
T14 = -1 * sin(alpha) * d;
T15 = cos(alpha) * d;
T16 = 1;

T = [T1 T5 T9 T13; T2 T6 T10 T14; T3 T7 T11 T15; T4 T8 T12 T16];