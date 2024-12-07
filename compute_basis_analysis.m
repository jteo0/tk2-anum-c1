function [A_basis_A, A_basis_B, A_basis_C, A_basis_D, c_x, c_y] = compute_basis_analysis(x, y, t)
    n = length(t);

    % Initialize
    A_basis_A = zeros(n, n);
    A_basis_B = zeros(n, n);
    A_basis_C = zeros(n, n);
    A_basis_D = zeros(n, n);

    % Construct matrix
    for i = 1:n
        for j = 1:n
            % Basis A: Φ_i(t) = t^(j-1)
            A_basis_A(i, j) = t(i)^(j-1);

            % Basis B: Φ_i(t) = (t - 60)^(j-1)
            A_basis_B(i, j) = (t(i) - 60)^(j-1);

            % Basis C: Φ_i(t) = (t - 480)^(j-1)
            A_basis_C(i, j) = (t(i) - 480)^(j-1);

            % Basis D: Φ_i(t) = ((t - 480) / 30)^(j-1)
            A_basis_D(i, j) = ((t(i) - 480) / 30)^(j-1);
        end
    end

    % Solve for coefficients
    c_A_y = A_basis_A \ y';
    c_B_y = A_basis_B \ y';
    c_C_y = A_basis_C \ y';
    c_D_y = A_basis_D \ y';

    c_A_x = A_basis_A \ x';
    c_B_x = A_basis_B \ x';
    c_C_x = A_basis_C \ x';
    c_D_x = A_basis_D \ x';

    c_y = [c_A_y c_B_y c_C_y c_D_y];
    c_x = [c_A_x c_B_x c_C_x c_D_x];

    % Condition numbers
    cond_A_1 = cond(A_basis_A, 1);
    cond_B_1 = cond(A_basis_B, 1);
    cond_C_1 = cond(A_basis_C, 1);
    cond_D_1 = cond(A_basis_D, 1);

    % Display results
    fprintf('Condition Number 1 for Basis A: %.15e\n', cond_A_1);
    fprintf('Condition Number 1 for Basis B: %.15e\n', cond_B_1);
    fprintf('Condition Number 1 for Basis C: %.15e\n', cond_C_1);
    fprintf('Condition Number 1 for Basis D: %.15e\n', cond_D_1);

    % Condition numbers
    cond_A_2 = cond(A_basis_A, 2);
    cond_B_2 = cond(A_basis_B, 2);
    cond_C_2 = cond(A_basis_C, 2);
    cond_D_2 = cond(A_basis_D, 2);

    % Display results
    fprintf('Condition Number 2 for Basis A: %.15e\n', cond_A_2);
    fprintf('Condition Number 2 for Basis B: %.15e\n', cond_B_2);
    fprintf('Condition Number 2 for Basis C: %.15e\n', cond_C_2);
    fprintf('Condition Number 2 for Basis D: %.15e\n', cond_D_2);

    % Condition numbers
    cond_A_inf = cond(A_basis_A, inf);
    cond_B_inf = cond(A_basis_B, inf);
    cond_C_inf = cond(A_basis_C, inf);
    cond_D_inf = cond(A_basis_D, inf);

    % Display results
    fprintf('Condition Number inf for Basis A: %.15e\n', cond_A_inf);
    fprintf('Condition Number inf for Basis B: %.15e\n', cond_B_inf);
    fprintf('Condition Number inf for Basis C: %.15e\n', cond_C_inf);
    fprintf('Condition Number inf for Basis D: %.15e\n', cond_D_inf);

    % Display coefficients for all bases
    fprintf('\nCoefficients for Basis A for x:\n');
    disp(c_A_x);
    fprintf('\nCoefficients for Basis A for y:\n');
    disp(c_A_y);

    fprintf('\nCoefficients for Basis B for x:\n');
    disp(c_B_x);
    fprintf('\nCoefficients for Basis B for y:\n');
    disp(c_B_y);

    fprintf('\nCoefficients for Basis C for x:\n');
    disp(c_C_x);
    fprintf('\nCoefficients for Basis C for y:\n');
    disp(c_C_y);

    fprintf('\nCoefficients for Basis D for x:\n');
    disp(c_D_x);
    fprintf('\nCoefficients for Basis D for y:\n');
    disp(c_D_y);
end

