function [p_basis_N_x, p_basis_N_y] = evaluate_basis_N_interpolation(t_eval, t_points, x_points, y_points)
    % Calculate coefficients for basis N
    [c_x, c_y] = get_basis_N_coefficients(t_points, x_points, y_points);
    
    % Evaluate polynomials at t_eval points
    p_basis_N_x = arrayfun(@(t) evaluate_basis_D(t, c_x), t_eval);
    p_basis_N_y = arrayfun(@(t) evaluate_basis_D(t, c_y), t_eval);
end

function [c_x, c_y] = get_basis_N_coefficients(t, x, y)
    % Transform points to basis N space
    s = (t - 480) / 30;
    
    % Set up Vandermonde matrix
    n = length(t);
    A = zeros(n, n);
    for i = 1:n
        for j = 1:n
            A(i,j) = s(i)^(j-1);
        end
    end
    
    % Solve for coefficients
    c_x = A \ x';
    c_y = A \ y';
end

