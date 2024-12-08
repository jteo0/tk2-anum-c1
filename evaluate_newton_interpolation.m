function [p_newton_x, p_newton_y] = evaluate_newton_interpolation(t_eval, t_points, x_points, y_points)
    % Calculate coefficients using divided differences
    c_x = divided_differences(t_points, x_points);
    c_y = divided_differences(t_points, y_points);
    
    % Evaluate polynomials at t_eval points
    p_newton_x = zeros(size(t_eval));
    p_newton_y = zeros(size(t_eval));
    
    for i = 1:length(t_eval)
        p_newton_x(i) = evaluate_newton(t_eval(i), t_points, c_x);
        p_newton_y(i) = evaluate_newton(t_eval(i), t_points, c_y);
    end
end

