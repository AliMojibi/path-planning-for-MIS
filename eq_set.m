function [F, J] = eq_set(x)

    global r1 r3 r5 r7 P_p P_t P_s

    P_E = [x(1), x(2), x(3)];
    P_W = [x(4), x(5), x(6)];
    
    % Equations
    F(1) = norm(P_E - P_s).^2 - r3^2;
    F(2) = norm(P_W - P_t).^2 - r7^2;
    F(3) = norm(P_E - P_W).^2 - r5^2;
    
    F(4) = P_p(1) - P_E(1) - x(7) * (P_W(1) - P_E(1));
    F(5) = P_p(2) - P_E(2) - x(7) * (P_W(2) - P_E(2));
    F(6) = P_p(3) - P_E(3) - x(7) * (P_W(3) - P_E(3));

    F(7) = norm(P_E - P_p) + norm(P_p - P_W) - r5;

    J = eqJacob(P_t(1),P_t(2),P_t(3),x(1),x(2),x(3),x(4),x(5),x(6),x(7));


end