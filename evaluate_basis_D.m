% Fungsi evaluasi dengan metode Horner
function p = evaluate_basis_D(t, c)
    s = (t - 480) / 30;
    n = length(c);
    hasil = c(n);
    for i = n-1:-1:1
        hasil = c(i) + s * hasil;
    end
    p = hasil;
end
