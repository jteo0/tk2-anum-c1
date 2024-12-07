function analyze_newton_interpolation()
    % Initial data points
    t_points = [0, 60, 120, 180, 240, 300, 360, 420, 480, 540];
    x_points = [0, 2.736013986, 2.698863636, 2.576923077, 2.7, 2.56097561, 2.535714286, 2.586206897, 2.592592593, 2.55];
    y_points = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45];

    % Calculate divided differences for p9
    c_x = divided_differences(t_points, x_points);
    c_y = divided_differences(t_points, y_points);

    % Add new point at t = 600
    t_new = [t_points, 600];
    x_new = [x_points, 2.336957];
    y_new = [y_points, 50];

    % Calculate divided differences for p10
    c_x_new = extend_divided_differences(t_new, x_new, c_x);
    c_y_new = extend_divided_differences(t_new, y_new, c_y);

    % Evaluate polynomials
    t_eval = linspace(0, 540, 541);
    p9_x = zeros(size(t_eval));
    p9_y = zeros(size(t_eval));
    p10_x = zeros(size(t_eval));
    p10_y = zeros(size(t_eval));

    for i = 1:length(t_eval)
        p9_x(i) = evaluate_newton(t_eval(i), t_points, c_x);
        p9_y(i) = evaluate_newton(t_eval(i), t_points, c_y);
        p10_x(i) = evaluate_newton(t_eval(i), t_new, c_x_new);
        p10_y(i) = evaluate_newton(t_eval(i), t_new, c_y_new);
        % fprintf('\np9_x(i): %.7e, p10_x(i): %.7e, p9_y(i): %.7e, p10_y(i): %.7e',p9_x(i), p10_x(i), p9_y(i), p10_y(i));
    end

    fprintf('\nInterpolation p_9 for x:\n');
    disp(p9_x);
    fprintf('\nInterpolation p_10 for x:\n');
    disp(p10_x);

    fprintf('\nInterpolation p_9 for y:\n');
    disp(p9_y);
    fprintf('\nInterpolation p_10 for y:\n');
    disp(p10_y);

    % Plot results
    figure;
    subplot(2,1,1);
    plot(t_eval, p9_x, 'b-', 'LineWidth', 1.5);
    hold on;
    plot(t_eval, p10_x, 'r--', 'LineWidth', 1.5);
    plot(t_points, x_points, 'ko');
    title('Newton Interpolation for x-coordinate');
    xlabel('t'); ylabel('x');
    legend('p_9(t)', 'p_{10}(t)', 'Data Points');
    grid on;

    subplot(2,1,2);
    plot(t_eval, p9_y, 'b-', 'LineWidth', 1.5);
    hold on;
    plot(t_eval, p10_y, 'r--', 'LineWidth', 1.5);
    plot(t_points, y_points, 'ko');
    title('Newton Interpolation for y-coordinate');
    xlabel('t'); ylabel('y');
    legend('p_9(t)', 'p_{10}(t)', 'Data Points');
    grid on;
end

function c_new = extend_divided_differences(t_new, f_new, c_old)
    n = length(t_new);
    c_new = [c_old, 0];
    product = 1;

    % Calculate last coefficient
    diff = f_new(end);
    for i = 1:n-1
        term = c_old(i);
        for j = 1:i-1
            term = term * (t_new(n) - t_new(j));
        end
        diff = diff - term;
        product = product * (t_new(n) - t_new(i));
    end

    c_new(n) = diff / product;
end

% function c_new = extend_divided_differences(t_new, f_new, c_old)
%     n = length(t_new);
%     c_new = [c_old, 0];
    
%     % Display extension header
%     fprintf('\nExtending Divided Differences Table for new point t = %.2f:\n', t_new(end));
%     fprintf('%-10s ', 't');
%     for j = 1:n
%         if j == 1
%             fprintf('%-15s ', 'f(t)');
%         else
%             fprintf('%-15s ', sprintf('f[%d]', j-1));
%         end
%     end
%     fprintf('\n');
    
%     % Display separator
%     fprintf('%s\n', repmat('-', 1, 10 + 15*n));
    
%     % Calculate and display new differences
%     F_new = f_new(end);
%     fprintf('%-10.2f %-15.6e ', t_new(end), F_new);
    
%     diff = F_new;
%     product = 1;
    
%     % Calculate each term and display
%     for i = 1:n-1
%         term = c_old(i);
%         local_product = 1;
        
%         % Calculate product terms
%         for j = 1:i-1
%             local_product = local_product * (t_new(n) - t_new(j));
%             term = term * (t_new(n) - t_new(j));
%         end
        
%         diff = diff - term;
%         product = product * (t_new(n) - t_new(i));
        
%         % Display intermediate result
%         next_diff = diff / product;
%         fprintf('%-15.6e ', next_diff);
%     end
%     fprintf('\n\n');
    
%     % Set final coefficient
%     c_new(n) = diff / product;
    
%     % Display final coefficients
%     fprintf('Final coefficients:\n');
%     for i = 1:n
%         fprintf('c%d = %-15.6e\n', i-1, c_new(i));
%     end
%     fprintf('\n');
% end