function [coeff_x, coeff_y] = get_newton_coefficients(t, x, y)
    % Calculate divided differences for x and y coordinates
    coeff_x = divided_differences(t, x);
    coeff_y = divided_differences(t, y);
    
    % Display coefficients
    fprintf('\nCoefficients for x(t):\n');
    for i = 1:length(coeff_x)
        fprintf('c%d = %.6f\n', i-1, coeff_x(i));
    end
    
    fprintf('\nCoefficients for y(t):\n');
    for i = 1:length(coeff_y)
        fprintf('c%d = %.6f\n', i-1, coeff_y(i));
    end
end

% Example usage:
% t = [0, 60, 120, 180, 240, 300, 360, 420, 480, 540];
% x = [0, 2.736013986, 2.698863636, 2.576923077, 2.7, 2.56097561, 2.535714286, 2.586206897, 2.592592593, 2.55];
% y = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45];

% [cx, cy] = get_newton_coefficients(t, x, y);