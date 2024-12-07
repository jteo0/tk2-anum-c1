function [p_spline_x, p_spline_y] = evaluate_cubic_spline(t_eval, t, x, y)
    % Compute spline coefficients
    [spline_coeffs_x, ~] = compute_cubic_spline(t, x);
    [spline_coeffs_y, ~] = compute_cubic_spline(t, y);
    
    % Evaluate splines
    p_spline_x = evaluate_spline(t_eval, t, spline_coeffs_x);
    p_spline_y = evaluate_spline(t_eval, t, spline_coeffs_y);
end

function [spline_coeffs, moments] = compute_cubic_spline(x, y)
    n = length(x);
    h = diff(x);
    
    % Set up tridiagonal system
    A = zeros(n);
    b = zeros(n,1);
    
    % Interior points
    for i = 2:n-1
        A(i,i-1) = h(i-1);
        A(i,i) = 2*(h(i-1) + h(i));
        A(i,i+1) = h(i);
        b(i) = 6*((y(i+1) - y(i))/h(i) - (y(i) - y(i-1))/h(i-1));
    end
    
    % Natural spline conditions
    A(1,1) = 1;
    A(n,n) = 1;
    
    % Solve for moments
    moments = A\b;
    
    % Compute spline coefficients
    spline_coeffs = zeros(n-1, 4);
    for i = 1:n-1
        spline_coeffs(i,1) = y(i);
        spline_coeffs(i,2) = (y(i+1) - y(i))/h(i) - h(i)*(2*moments(i) + moments(i+1))/6;
        spline_coeffs(i,3) = moments(i)/2;
        spline_coeffs(i,4) = (moments(i+1) - moments(i))/(6*h(i));
    end
end

function [y_eval] = evaluate_spline(x_eval, x, spline_coeffs)
    y_eval = zeros(size(x_eval));
    n = length(x) - 1;
    
    for i = 1:length(x_eval)
        % Find appropriate spline segment
        idx = find(x_eval(i) >= x(1:end-1) & x_eval(i) < x(2:end), 1);
        if isempty(idx)
            if x_eval(i) == x(end)
                idx = n;
            else
                continue;
            end
        end
        
        % Evaluate cubic polynomial
        dx = x_eval(i) - x(idx);
        y_eval(i) = spline_coeffs(idx,1) + ...
                    spline_coeffs(idx,2)*dx + ...
                    spline_coeffs(idx,3)*dx^2 + ...
                    spline_coeffs(idx,4)*dx^3;
    end
end
