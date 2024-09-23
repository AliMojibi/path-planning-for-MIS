function plotPointsAndLines(points)
    % Check if the number of points is 6
    if size(points, 1) ~= 6
        error('Number of points should be 6.');
    end
    
    % Create a figure and axes
    
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
    hold off
    % Adjust the view perspective
    view(3);
    axis equal
    

end
