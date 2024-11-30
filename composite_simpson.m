function [I, elapsed_time] = compositeSimpson(f, a, b, n, y)
    % Input:
    % f: function handle of the integrand
    % a: lower limit of integration
    % b: upper limit of integration
    % n: number of subintervals (must be even)
    % y: target label (0 or 1) for sigmoid-based function
    % Output:
    % I: approximate integral value
    % elapsed_time: time taken for computation in seconds

    % Check if n is even
    if mod(n, 2) == 1
        error('n must be an even integer');
    end

    % Start measuring time
    tic;

    % Step size
    h = (b - a) / n;

    % Generate x-values
    x = a:h:b;

    if y == 1
        % Sigmoid transformation for y = 1
        f = @(x) -log(1 ./ (1 + exp(-x))); % Example modification for y = 1
    elseif y == 0
        % Sigmoid transformation for y=0
        f = @(x) -log(1 - (1 ./ (1 + exp(-x)))); % Example modification for y = 0
    else
        error('Target label y must be 0 or 1');
    end

    % Compute y-values
    y_vals = f(x); % Evaluate the function at all points

    % Apply Composite Simpson's Rule
    I = (h / 3) * (y_vals(1) + 4 * sum(y_vals(2:2:end-1)) + 2 * sum(y_vals(3:2:end-2)) + y_vals(end));

    % Stop measuring time
    elapsed_time = toc;
end

