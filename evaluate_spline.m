function value = evaluate_spline(x_query, x, a, b, c, d)
    for i = 1:length(x) - 1
        if x_query >= x(i) && x_query <= x(i + 1)
            dx = x_query - x(i);
            value = a(i) + b(i) * dx + c(i) * dx^2 + d(i) * dx^3;
            return;
        end
    end
end

