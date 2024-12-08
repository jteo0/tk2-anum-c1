function y_val = evaluate_basis(t_query, coeff, t)
    % Evaluate a polynomial based on the basis matrix coefficients
    n = length(coeff); % Degree of the polynomial
    y_val = 0;
    for i = 1:n
        y_val = y_val + coeff(i) * t_query^(i-1); % Polynomial evaluation
    end
end
