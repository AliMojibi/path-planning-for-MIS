function qs = ik_solver(Pe, r_1, r_3, q1_prior, q2_prior, flag_start)
    x1 = Pe(1); x2=Pe(2); x3=Pe(3);
    q2 = acos((x3-r_1)/r_3);
    q1 = atan2(x2/(r_3*sin(q2)), x1/(r_3*sin(q2)));

    % at the start of solving IK we dont have prior values for q_i s
%     if flag_start == 1
%          q2 = acos((x3-r_1)/r_3);
%          q1 = atan2(x2/(r_3*sin(q2)), x1/(r_3*sin(q2)));
%     % when solving IK equations we should choose the proper solution which
%     % is nearest to the prior state solution
%     else
%         q2_pos = acos((x3-r_1)/r_3);
%         q2_neg = acos((x3-r_1)/r_3);
%         
%         q1_pos = atan2(x2/(r_3*sin(q2_pos)), x1/(r_3*sin(q2_pos)));
%         q1_neg = atan2(x2/(r_3*sin(q2_neg)), x1/(r_3*sin(q2_neg)));
%         
%         past_state = [q1_prior, q2_prior];
%     
%         diff_vec_pos = norm([q1_pos; q2_pos] - past_state);
%         diff_vec_neg = norm([q1_neg; q2_neg] - past_state);
%         
%         if diff_vec_pos <= diff_vec_neg 
%             q1 = q1_pos;
%             q2 = q2_pos;
%         else 
%             q1 = q1_neg;
%             q2 = q2_neg;
%         end
%     end
      qs = [q1, q2];
end