function c = divided_differences(t, f)
    n = length(t);
    F = zeros(n, n);
    F(:,1) = f(:);
    
    % Calculate divided differences - lower triangle
    for j = 2:n
        for i = j:n
            F(i,j) = (F(i,j-1) - F(i-1,j-1))/(t(i) - t(i-j+1));
        end
    end
    
    % % Display table header
    % fprintf('\nDivided Differences Table:\n');
    % fprintf('%-10s ', 't');
    % for j = 1:n
    %     if j == 1
    %         fprintf('%-15s ', 'f(t)');
    %     else
    %         fprintf('%-15s ', sprintf('f[%d]', j-1));
    %     end
    % end
    % fprintf('\n');
    
    % % Display separator line
    % fprintf('%s\n', repmat('-', 1, 10 + 15*n));
    
    % % Display table content - lower triangle
    % for i = 1:n
    %     fprintf('%-10.2f ', t(i));
    %     for j = 1:i
    %         fprintf('%-15.6e ', F(i,j));
    %     end
    %     fprintf('\n');
    % end
    % fprintf('\n');
    
    % Extract coefficients from main diagonal
    c = zeros(1,n);
    for i = 1:n
        c(i) = F(i,i);
    end
end