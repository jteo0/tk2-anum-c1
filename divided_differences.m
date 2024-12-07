function c = divided_differences(t, f)
    n = length(t);
    F = zeros(n, n);
    F(:,1) = f(:);
    
    for j = 2:n
        for i = 1:(n-j+1)
            F(i,j) = (F(i+1,j-1) - F(i,j-1))/(t(i+j-1) - t(i));
        end
    end
    
    c = F(1,:);
end