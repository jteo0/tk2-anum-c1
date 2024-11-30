ftion [integral, subdivisions, elapsed_time] = adaptive_quadrature(f, a, b, tol)
    % Input:
    % f: function handle for the integrand
    % a: lower limit of integration
    % b: upper limit of integration
    % tol: error tolerance
    % Output:
    % integral: the integral approximation
    % subdivisions: the amount of subdivisions made
    % elapsed_time: time taken for computation in seconds

    tic; % Start the timer
    [integral, subdivisions] = adaptive_quadrature_rec(f, a, b, tol, 0);
    elapsed_time = toc; % Stop the timer
end

ftion [integral, subdivisions] = adaptive_quadrature_rec(f, a, b, tol, count)
    % Recursive ftion for adaptive trapezoidal integration
    mid = (a + b) / 2;

    % Compute trapezoidal rule for [a, b]
    integral1 = (b - a) * (f(a) + f(b)) / 2;

    % Compute trapezoidal rule for [a, mid] and [mid, b]
    integral2 = (mid - a) * (f(a) + f(mid)) / 2 + ...
                (b - mid) * (f(mid) + f(b)) / 2;

    % Estimate error
    if abs(integral2 - integral1) < tol
        % If the error is within tolerance, accept the result
        integral = integral2;
        subdivisions = count + 1; % Count this subdivision
    else
        % Otherwise, refine the intervals recursively
        [left_integral, left_count] = adaptive_quadrature_rec(f, a, mid, tol / 2, count);
        [right_integral, right_count] = adaptive_quadrature_rec(f, mid, b, tol / 2, count);

        % Combine results from both sides
        integral = left_integral + right_integral;
        subdivisions = left_count + right_count;
    end
endright
