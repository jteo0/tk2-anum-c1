function [R, elapsed_time] = RombergAutoSubdivisions(f, a, b, tol, m)
    % Input:
    % f: function handle for the integrand
    % a: lower limit of integration
    % b: upper limit of integration
    % tol: error tolerance
    % m: refinement levels (Romberg table rows)
    % Output:
    % R: Romberg table of computed results
    % elapsed_time: computation time in seconds

    % Start measuring time
    tic;

    % Initialize the Romberg table
    R = zeros(m, m);

    % Compute the first row of the table (Trapezoidal Rule)
    R(1, 1) = RepeatedTrapezoid(f, a, b, 1); % Start with n = 1

    % Fill the Romberg table iteratively
    for k = 2:m
        % Calculate the number of subdivisions (n) automatically
        n = 2^(k-1); % Subdivisions double with each refinement level

        % Compute the new trapezoidal estimate
        R(k, 1) = RepeatedTrapezoid(f, a, b, n);

        % Richardson extrapolation
        for j = 2:k
            R(k, j) = (4^(j-1) * R(k, j-1) - R(k-1, j-1)) / (4^(j-1) - 1);
        end

        % Check for convergence
        if abs(R(k, k) - R(k-1, k-1)) < tol
            elapsed_time = toc;
            R = R(1:k, 1:k); % Trim the table
            return;
        end
    end

    % If convergence is not reached
    elapsed_time = toc;
    warning('Romberg integration did not converge within the specified refinement levels');
end

function T = RepeatedTrapezoid(f, a, b, n)
    % Repeated Trapezoidal Rule
    % Input:
    % f: function handle for the integrand
    % a: lower limit of integration
    % b: upper limit of integration
    % n: number of subdivisions
    % Output:
    % T: Trapezoidal approximation of the integral

    x = linspace(a, b, n + 1); % Subdivision points
    h = (b - a) / n; % Step size
    T = (h / 2) * (f(a) + f(b) + 2 * sum(f(x(2:end-1)))); % Trapezoidal sum
end

