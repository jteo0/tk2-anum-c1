function compute_basis_analysis(x, y)
    % This function computes the coefficients and condition numbers
    % for different polynomial bases given coordinates (x, y).
    % Inputs:
    %   x - Array of x-coordinates
    %   y - Array of y-coordinates

    % Validate input dimensions
    if length(x) ~= length(y)
        error('x and y must have the same length.');
    end

    % Number of points
    n = length(x);

    % Initialize matrices for each basis
    A_basis_A = zeros(n, n);
    A_basis_B = zeros(n, n);
    A_basis_C = zeros(n, n);
    A_basis_D = zeros(n, n);

    % Construct matrices for each basis
    for i = 1:n
        for j = 1:n
            % Basis A: Φ_i(t) = t^(j-1)
            A_basis_A(i, j) = x(i)^(j-1);

            % Basis B: Φ_i(t) = (t - 60)^(j-1)
            A_basis_B(i, j) = (x(i) - 60)^(j-1);

            % Basis C: Φ_i(t) = (t - 480)^(j-1)
            A_basis_C(i, j) = (x(i) - 480)^(j-1);

            % Basis D: Φ_i(t) = ((t - 480) / 30)^(j-1)
            A_basis_D(i, j) = ((x(i) - 480) / 30)^(j-1);
        end
    end

    % Solve for coefficients for each basis
    c_A = A_basis_A \ y';
    c_B = A_basis_B \ y';
    c_C = A_basis_C \ y';
    c_D = A_basis_D \ y';

    % Calculate condition numbers for each basis
    cond_A = cond(A_basis_A);
    cond_B = cond(A_basis_B);
    cond_C = cond(A_basis_C);
    cond_D = cond(A_basis_D);

    % Display results
    fprintf('Condition Number for Basis A: %.2e\n', cond_A);
    fprintf('Condition Number for Basis B: %.2e\n', cond_B);
    fprintf('Condition Number for Basis C: %.2e\n', cond_C);
    fprintf('Condition Number for Basis D: %.2e\n', cond_D);

    % Display coefficients for all bases
    fprintf('\nCoefficients for Basis A:\n');
    disp(c_A);

    fprintf('\nCoefficients for Basis B:\n');
    disp(c_B);

    fprintf('\nCoefficients for Basis C:\n');
    disp(c_C);

    fprintf('\nCoefficients for Basis D:\n');
    disp(c_D);
end

