function [integral, subdivisions, elapsedTime] = adaptive_quadrature(func, a, b, tol)
    % Adaptive Quadrature using the Trapezoidal Rule

    tic; % Start the timer
    [integral, subdivisions] = adaptiveQuadratureRec(func, a, b, tol, 0);
    elapsedTime = toc; % Stop the timer
end

function [integral, subdivisions] = adaptiveQuadratureRec(func, a, b, tol, count)
    % Recursive function for adaptive trapezoidal integration
    mid = (a + b) / 2;

    % Compute trapezoidal rule for [a, b]
    integral1 = (b - a) * (func(a) + func(b)) / 2;

    % Compute trapezoidal rule for [a, mid] and [mid, b]
    integral2 = (mid - a) * (func(a) + func(mid)) / 2 + ...
                (b - mid) * (func(mid) + func(b)) / 2;

    % Estimate error
    if abs(integral2 - integral1) < tol
        % If the error is within tolerance, accept the result
        integral = integral2;
        subdivisions = count + 1; % Count this subdivision
    else
        % Otherwise, refine the intervals recursively
        [leftIntegral, leftCount] = adaptiveQuadratureRec(func, a, mid, tol / 2, count);
        [rightIntegral, rightCount] = adaptiveQuadratureRec(func, mid, b, tol / 2, count);

        % Combine results from both sides
        integral = leftIntegral + rightIntegral;
        subdivisions = leftCount + rightCount;
    end
end
