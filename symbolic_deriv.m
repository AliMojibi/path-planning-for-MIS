clc
clear all
close all

syms x1 x2 x3 x4 x5 x6 x7
syms Pt1 Pt2 Pt3

r1 = (31.5-12)*10^-2; r3 = 45 * 10^-2; r5 = 50 * 10^-2; r7 = 18 * 10^-2;
P_p = [17, 40, 50] * 10^-2; 
P_t = [Pt1 Pt2 Pt3];
P_s = [0, 0, r1];

P_E = [x1, x2, x3];
P_W = [x4, x5, x6];

syms x7


% Equations
F(1) = norm(P_E - P_s).^2 - r3^2;
F(2) = norm(P_W - P_t).^2 - r7^2;
F(3) = norm(P_E - P_W).^2 - r5^2;

F(4) = P_p(1) - P_E(1) - x7 * (P_W(1) - P_E(1));
F(5) = P_p(2) - P_E(2) - x7 * (P_W(2) - P_E(2));
F(6) = P_p(3) - P_E(3) - x7 * (P_W(3) - P_E(3));

F(7) = norm(P_E - P_p) + norm(P_p - P_W) - r5;

J = jacobian(F, [x1, x2, x3, x4, x5, x6, x7]);

jacob = matlabFunction(J)
