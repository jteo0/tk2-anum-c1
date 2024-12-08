function [a, b, c, d] = cubic_spline(x, y)
    n = length(x) - 1; % Number of intervals
    h = diff(x);       % Step sizes

    A = zeros(n + 1);
    b_vector = zeros(n + 1, 1);

    % Boundary conditions for natural spline
    A(1, 1) = 1; % Natural spline: second derivative = 0 at x0
    A(end, end) = 1; % Natural spline: second derivative = 0 at xn

    for i = 2:n
        A(i, i - 1) = h(i - 1);
        A(i, i) = 2 * (h(i - 1) + h(i));
        A(i, i + 1) = h(i);
        b_vector(i) = 3 * ((y(i + 1) - y(i)) / h(i) - (y(i) - y(i - 1)) / h(i - 1));
    end

    % Solve for c
    c = A \ b_vector;

    % Compute coefficients a, b, d
    a = y(1:end-1);
    b = zeros(n, 1);
    d = zeros(n, 1);
    for i = 1:n
        b(i) = (y(i + 1) - y(i)) / h(i) - h(i) * (2 * c(i) + c(i + 1)) / 3;
        d(i) = (c(i + 1) - c(i)) / (3 * h(i));
    end
    c = c(1:end-1); % Remove last c value (not needed for intervals)
end

