function [result, error, R, time] = romberg_integration(f, a, b,  m)
    tic; 
    
    % Initialize Romberg table
    h = (b - a) ./ (2.^(0:m-1));  % vectorized step sizes
    R = zeros(m, m);

    % Initial trapezoidal approximation
    R(1,1) = (b - a) * (f(a) + f(b)) / 2;

    % Fill the table
    for j = 2:m
        % Composite trapezoidal rule for current step size
        subtotal = 0;
        for i = 1:2^(j-2)
            subtotal = subtotal + f(a + (2 * i - 1) * h(j));
        end
        R(j,1) = R(j-1,1) / 2 + h(j) * subtotal;

        % Richardson extrapolation
        for k = 2:j
            R(j,k) = (4^(k-1) * R(j,k-1) - R(j-1,k-1)) / (4^(k-1) - 1);
        end
    end

    % Return results
    result = R(m,m);
    error = abs(R(m,m) - R(m-1,m-1));
    time = toc;
end

