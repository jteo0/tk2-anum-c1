function [p9_vals, p10_vals] = plot_interpolation_comparison2(c_N_x, c_N_y, t_range, t_data, x_data, y_data)
    % Titik baru
    t_new = 600;
    x_new = 2.336957;
    y_new = 50;

    % Transformasi s untuk t_data dan t_new
    s_data = (t_data - 480) / 30;
    s_new = (t_new - 480) / 30;

    % Evaluasi p9(t_new)
    p9_x_new = evaluate_pN(t_new, c_N_x);
    p9_y_new = evaluate_pN(t_new, c_N_y);

    % Hitung Delta y
    delta_x = x_new - p9_x_new;
    delta_y = y_new - p9_y_new;

    % Hitung l(t) untuk t_range
    s_range = (t_range - 480) / 30;
    l_t = ones(size(s_range));
    denominator = 1;

    for i = 1:length(s_data)
        l_t = l_t .* (s_range - s_data(i));
        denominator = denominator * (s_new - s_data(i));
    end

    l_t = l_t / denominator;

    % Evaluasi p9(t) pada t_range
    p9_x = evaluate_pN_vector(t_range, c_N_x);
    p9_y = evaluate_pN_vector(t_range, c_N_y);

    % Evaluasi p10(t) pada t_range
    for i = 1:60:541
      fprintf('\nl_t: %.7e\n, i: %d', l_t(i), i);
    endfor
    p10_x = p9_x + delta_x * l_t;
    fprintf('\nl_t:\n');
    disp(l_t)
    for i = 1:60:541
      fprintf('\nl_t: %.7e\n', l_t(i));
    endfor
    p10_y = p9_y + delta_y * l_t;

    selected_frames = 0:60:540; % Nilai frame yang diinginkan
    [~, indices] = ismember(selected_frames, t_range);

    p9_x = p9_x(indices);
    p9_y = p9_y(indices);
    p10_x = p10_x(indices);
    p10_y = p10_y(indices);
    l_t = l_t(indices);

    fprintf('\ndelta x:\n');
    disp(delta_x)
    fprintf('\nl_t:\n');
    disp(l_t)

    fprintf('\nInterpolation p_9 for x:\n');
    disp(p9_x);
    fprintf('\nInterpolation p_10 for x:\n');
    disp(p10_x);

    fprintf('\nInterpolation p_9 for y:\n');
    disp(p9_y);
    fprintf('\nInterpolation p_10 for y:\n');
    disp(p10_y);

    % Plot hasil
    figure;
    subplot(2,1,1);
    plot(t_data, p9_x, 'b-', t_data, p10_x, 'r--');
    title('Interpolasi Koordinat X');
    legend('p_9(t)', 'p_{10}(t)');
    xlabel('Frame');
    ylabel('Posisi X');

    subplot(2,1,2);
    plot(t_data, p9_y, 'b-', t_data, p10_y, 'r--');
    title('Interpolasi Koordinat Y');
    legend('p_9(t)', 'p_{10}(t)');
    xlabel('Frame');
    ylabel('Posisi Y');

    p9_vals = [p9_x; p9_y];
    p10_vals = [p10_x; p10_y];
end

function val = evaluate_pN(t_val, coeff)
    % Evaluasi polinomial pN(t) menggunakan metode Horner
    s = (t_val - 480) / 30;
    n = length(coeff);
    result = coeff(n);
    for i = n-1:-1:1
        result = coeff(i) + s * result;
    end
    val = result;
end

function vals = evaluate_pN_vector(t_vals, coeff)
    % Evaluasi pN(t) untuk vektor t_vals
    vals = zeros(size(t_vals));
    for idx = 1:length(t_vals)
        vals(idx) = evaluate_pN(t_vals(idx), coeff);
    end
end
