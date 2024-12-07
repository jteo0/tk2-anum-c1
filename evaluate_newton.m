function y = evaluate_newton(t, t_points, c)
    n = length(c);
    y = c(1);
    term = 1;

    for i = 2:n
        term = term * (t - t_points(i-1));
        y = y + c(i) * term;
    end
end
