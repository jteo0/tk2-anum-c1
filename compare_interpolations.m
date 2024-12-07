function compare_interpolations()
    % Initial data points
    t_points = [0, 60, 120, 180, 240, 300, 360, 420, 480, 540];
    x_points = [0, 2.736013986, 2.698863636, 2.576923077, 2.7, 2.56097561, 2.535714286, 2.586206897, 2.592592593, 2.55];
    y_points = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45];
    
    % Evaluation points
    t_eval = linspace(0, 540, 541);
    
    % Get basis N interpolation
    [p_basis_N_x, p_basis_N_y] = evaluate_basis_N_interpolation(t_eval, t_points, x_points, y_points);
    
    % Get Newton interpolation
    [p_newton_x, p_newton_y] = evaluate_newton_interpolation(t_eval, t_points, x_points, y_points);
    
    % Get cubic spline interpolation
    [p_spline_x, p_spline_y] = evaluate_cubic_spline(t_eval, t_points, x_points, y_points);
    
    % Plot comparisons
    figure;
    subplot(2,1,1);
    plot(t_eval, p_basis_N_x, 'b-', 'LineWidth', 1.5);
    hold on;
    plot(t_eval, p_newton_x, 'r--', 'LineWidth', 1.5);
    plot(t_eval, p_spline_x, 'g:', 'LineWidth', 1.5);
    plot(t_points, x_points, 'ko');
    title('Comparison of Interpolations for x-coordinate');
    xlabel('t'); ylabel('x');
    legend('Basis N', 'Newton', 'Cubic Spline', 'Data Points');
    grid on;
    
    subplot(2,1,2);
    plot(t_eval, p_basis_N_y, 'b-', 'LineWidth', 1.5);
    hold on;
    plot(t_eval, p_newton_y, 'r--', 'LineWidth', 1.5);
    plot(t_eval, p_spline_y, 'g:', 'LineWidth', 1.5);
    plot(t_points, y_points, 'ko');
    title('Comparison of Interpolations for y-coordinate');
    xlabel('t'); ylabel('y');
    legend('Basis N', 'Newton', 'Cubic Spline', 'Data Points');
    grid on;
end

