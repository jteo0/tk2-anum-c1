function [p9_vals, p10_vals] = plot_interpolation_comparison(x, y, c_N_x, c_N_y, t_range)
    % Define the new point at frame 600
    new_point = [2.336957, 50];
    x_extended = [x, new_point(1)];
    y_extended = [y, new_point(2)];
    t_new = 600;
    t_extended = [t_range, t_new];

    % Extend coefficients to p10
    [c_N_x_10, c_N_y_10] = compute_basis_N(x_extended, y_extended, t_extended);

    % Evaluate both polynomials over the range
    p9_x = zeros(size(t_range));
    p9_y = zeros(size(t_range));
    p10_x = zeros(size(t_range));
    p10_y = zeros(size(t_range));

    for i = 1:length(t_range)
      % Evaluate p9
      p9_x(i) = evaluate_pN(t_range(i), c_N_x);
      p9_y(i) = evaluate_pN(t_range(i), c_N_y);

      % Evaluate p10
      p10_x(i) = evaluate_pN(t_range(i), c_N_x_10);
      p10_y(i) =  evaluate_pN(t_range(i), c_N_y_10);
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
    plot(t_range, p9_x, 'b-', t_range, p10_x, 'r--');
    title('X Coordinate Interpolation');
    legend('p9(t)', 'p10(t)');
    xlabel('Frame');
    ylabel('X Position');

    subplot(2,1,2);
    plot(t_range, p9_y, 'b-', t_range, p10_y, 'r--');
    title('Y Coordinate Interpolation');
    legend('p9(t)', 'p10(t)');
    xlabel('Frame');
    ylabel('Y Position');

    p9_vals = [p9_x; p9_y];
    p10_vals = [p10_x; p10_y];
end

 % Function to evaluate pN using Horner's method
function val = evaluate_pN(t_val, coeff)
    s = (t_val - 480) / 30;
    n = length(coeff);
    result = coeff(n);
    for i = n-1:-1:1
        result = coeff(i) + s * result;
    end
    val = result;
end

function [c_N_x, c_N_y] = compute_basis_N(x_values, y_values, t_values)
    n = length(t_values);
    A_basis_N = zeros(n, n);

    for i = 1:n
        s = (t_values(i) - 480) / 30;
        for j = 1:n
            A_basis_N(i, j) = s^(j-1);
        end
    end

    c_N_x = A_basis_N \ x_values';
    c_N_y = A_basis_N \ y_values';
end

% % Usage
% x = [0, 2.736013986, 2.698863636, 2.576923077, 2.7, 2.56097561, 2.535714286, 2.586206897, 2.592592593, 2.55];
% y = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45];
% t_range = 0:60:540;

% % Coefficients for Basis D for x
% c_N_x = [2.5926e+00, 1.6123e-01, 1.2574e-01, -2.8417e-03, -2.7016e-02, -9.4590e-03, -1.4685e-03, -1.1790e-04, -4.7686e-06, -7.6807e-08];

% % Coefficients for Basis D for y
% c_N_y = [4.0000e+01, 2.5000e+00, -3.8652e-15, 2.0355e-15, 1.1827e-15, 2.4839e-16, 2.7623e-17, 1.7306e-18, 5.7824e-20, 8.0311e-22];

% [p9_vals, p10_vals] = plot_interpolation_comparison(x, y, c_N_x, c_N_y, t_range);