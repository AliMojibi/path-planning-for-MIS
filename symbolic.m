clc
clear all
syms x1 x2 x3 x4 x5 x6 x7
% x7 = 0.02;

r1 = (31.5-12)*10^-2; r3 = 45 * 10^-2; r5 = 50 * 10^-2; r7 = 18 * 10^-2;
P_p = [17, 40, 50] * 10^-2; 
P_t = [25, 75, 30] * 10^-2;
P_s = [0, 0, r1];

P_E = [x1, x2, x3];
P_W = [x4, x5, x6];

% Equations
eq1 = norm(P_E - P_s).^2 - r3^2 ==0;
eq2 = norm(P_W - P_t).^2 - r7^2 ==0;
eq3 = norm(P_E - P_W).^2 - r5^2==0;

eq4 = P_p(1) - P_E(1) - x7 * (P_W(1) - P_E(1))==0;
eq5 = P_p(2) - P_E(2) - x7 * (P_W(2) - P_E(2))==0;
eq6 = P_p(3) - P_E(3) - x7 * (P_W(3) - P_E(3))==0;

eq7 = norm(P_E - P_p) + norm(P_p - P_W) - r5==0;
solution = solve([eq1, eq2, eq3, eq4, eq5, eq6, eq7],'ReturnConditions', true);