clear all; close all; clc

global r1 r3 r5 r7 P_p P_t P_s

% rotation transformation about z axis
rot_z = @(psi) [cos(psi) -sin(psi) 0;...
           sin(psi) cos(psi) 0; ...
           0 0 1 ];
% rotation transformation about y axis
rot_y = @(psi) [cos(psi) 0 sin(psi);...
                0 1 0; ...
                -sin(psi) 0 cos(psi)];

% robot's parameters
P_O = [0, 0, 0];
r1 = (31.5-12)*10^-2; r3 = 45 * 10^-2; r5 = 50 * 10^-2; r7 = 18 * 10^-2;
P_p = [17, 40, 50] * 10^-2; 
P_s = [0, 0, r1];

threshold=1e-11;

N = 500;
y_t = linspace(0.75, 0.83,N);
Q = zeros(length(y_t), 7);
Q_ch = zeros(length(y_t), 3);
ew = zeros(length(y_t), 7);
S = zeros(1, length(y_t));
errs = 0;
index_errs = zeros(1, N);
fvals = zeros(1, N);
% q1 = 0; q2=0;
q = zeros(1, 7);
x = zeros(1, 7);
figure;
for i= 1:length(y_t)
    P_t = [0.25,y_t(i), 0.30];
    fun = @eq_set;
    if i == 1
        x0 = zeros(1, 7);
        flag_start = 1;
    else
        x0 = x;
        flag_start = 0;
    end
     options = optimoptions('fsolve','FunctionTolerance', threshold,'MaxFunctionEvaluations',100000,...
         'SpecifyObjectiveGradient',true,'Algorithm','levenberg-marquardt', 'MaxIterations', 100000);
%      options = optimoptions('fsolve', 'FunctionTolerance', threshold, 'MaxFunctionEvaluations',10000,...
%         'Algorithm','Trust-region-dogleg', 'MaxIterations', 10000);
    
    [x,fval,exitflag] = fsolve(fun, x0, options);
    fvals(i) = norm(fval);
    if exitflag ~= 1
        fprintf('sth went wrong at [%f, %f, %f]', P_t(1), P_t(2), P_t(3))
        errs = errs+1;
        index_errs(i) = norm(fval);
    end
    P_E = [x(1), x(2), x(3)];
    P_W = [x(4), x(5), x(6)];
    ew(i, :) = x;
    % solving inverse kinematics
    
    
    % q1 & q2
    joint_angles = ik_solver(P_E, r1, r3,q(1), q(2), flag_start);
    q(1) = joint_angles(1); q(2) = joint_angles(2);
    
    
    % transfomation below state results form frame#1 in frame#0 
    % so we use its transpose state results form frame#0 in frame#1
    % frame #1 is the frame that is attached to the link (r3) but doest
    % undergo the rotation about q3
    
    R01 = rot_z(q(1))*rot_y(q(2));
    
    % we need to solve the same IK problem to q3 & q4
    P_Ws = P_W-P_s;
    P_Ws = transpose(R01)*P_Ws.'; % P_Ws in frame#1
    joint_angles = ik_solver(P_Ws, r3, r5, q(3), q(4), flag_start);
    q(3) = joint_angles(1); q(4) = joint_angles(2);
    
    % transfomation below state results form frame#2 in frame#0 
    % so we use its transpose state results form frame#0 in frame#2
    % frame #2 is the frame that is attached to the link (r5) but doest
    % undergo the rotation about q5
    R12 = rot_z(q(3))*rot_y(q(4));
    R02 = R01*R12;
    
    % we need to solve the same IK problem to find q5 & q6
    P_tE = P_t-P_E;
    P_tE = transpose(R02)*P_tE.';% P_Ws in frame#2
    joint_angles = ik_solver(P_tE, r5, r7, q(5), q(6), flag_start);
    q(5) = joint_angles(1); q(6) = joint_angles(2);
    
    Q(i, :) = q;
    Q_ch(i, :) = check_qs(P_s, P_E, P_W, P_t);
    
    S(1, i) = norm([25,y_t(i), 30]-[25,y_t(1), 30]);
end

S = S/(norm([25,y_t(1), 30]-[25,y_t(length(y_t)), 30]));
% figure(1);
% plot(S, fvals, '--','LineWidth',2)
% hold on 
% % Find the maximum and minimum values
% [maxValue, maxIndex] = max(fvals);
% [minValue, minIndex] = min(fvals);
% % Plot markers at the maximum and minimum points
% plot(S(maxIndex), maxValue, 'ro', 'MarkerSize', 8)
% plot(S(minIndex), minValue, 'go', 'MarkerSize', 8)
% % Add text annotations next to the markers
% text(S(maxIndex), maxValue, sprintf('Max: %.4e', maxValue), 'VerticalAlignment', 'bottom')
% text(S(minIndex), minValue, sprintf('Min: %.4e', minValue), 'VerticalAlignment', 'top')
% 
% xlabel('% S', 'FontSize', 14)
% ylabel('fval', 'FontSize', 14)


y_labels = ["q1 (deg)"; 'q2 (deg)'; 'q3 (deg)'; 'q4 (deg)'; 'q5 (deg)'; 'q6 (deg)'];


figure(2);
for i=1:6
    subplot(3, 2, i)
    plot(S, rad2deg(Q(:, i)), 'b', 'LineWidth',2)
    if mod(i, 2) == 0
        hold on
        plot(S, rad2deg(Q_ch(:, i/2)), 'b', 'LineWidth',2)
        hold off
    end

    xlabel('s %', 'FontSize', 14)
    ylabel(y_labels(i), 'FontSize', 14)
    grid on

end

figure(3);
y_labels = ["x_e"; 'y_e'; 'z_e'; 'x_w'; 'y_w'; 'z_w'];

for i=1:6
    subplot(3, 2, i)
    plot(S, ew(:,i), '--', 'LineWidth',2)
    xlabel('s')
    ylabel(y_labels(i))
    grid on
end

f= figure(4);
for i=1:length(Q)
    points = [P_O; P_s; ew(i, 1:3); ew(i, 4:6); [0.25,y_t(i), 0.30]; P_p];
    % plotPointsAndLines(robot_joints)
    p1 = points(1, :);p2 = points(2, :);p3 = points(3, :);p4 = points(4, :);p5 = points(5, :); 
    p6 = points(6, :); % rcm
    % Plot the points
    plot3(p1(1), p1(2), p1(3), 'ro', 'MarkerSize', 10, 'LineWidth', 2);  % Plot p1 as a red circle
    hold on
    plot3(p2(1), p2(2), p2(3), 'go', 'MarkerSize', 10, 'LineWidth', 2);  % Plot p2 as a green circle
    plot3(p3(1), p3(2), p3(3), 'bo', 'MarkerSize', 10, 'LineWidth', 2);  % Plot p3 as a blue circle
    plot3(p4(1), p4(2), p4(3), 'co', 'MarkerSize', 10, 'LineWidth', 2);
    plot3(p5(1), p5(2), p5(3), 'mo', 'MarkerSize', 10, 'LineWidth', 2);
    plot3(p6(1), p6(2), p6(3), 'x', 'MarkerSize', 10, 'LineWidth', 2);
    % Connect the points with lines
    line([p1(1), p2(1)], [p1(2), p2(2)], [p1(3), p2(3)], 'Color', 'k', 'MarkerSize', 10, 'LineWidth', 2);  % Line from p1 to p2
    line([p2(1), p3(1)], [p2(2), p3(2)], [p2(3), p3(3)], 'Color', 'k', 'MarkerSize', 10, 'LineWidth', 2);  % Line from p2 to p3
    line([p3(1), p4(1)], [p3(2), p4(2)], [p3(3), p4(3)], 'Color', 'k', 'MarkerSize', 10, 'LineWidth', 2);  % Line from p3 to p4
    line([p4(1), p5(1)], [p4(2), p5(2)], [p4(3), p5(3)], 'Color', 'k', 'MarkerSize', 10, 'LineWidth', 2);  % Line from p4 to p5
    
    % Set the axes labels
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    %hold off
    % Adjust the view perspective
    view(3);
    axis equal

    % pause(0.01)
    % clf(f)
    
end

