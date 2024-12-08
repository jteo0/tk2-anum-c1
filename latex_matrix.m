function latex_matrix(M)
  % Function to generate a LaTeX representation of a matrix
  % Input:
  %   M - A matrix to be formatted in LaTeX style
  %
  % Output:
  %   Prints the LaTeX-formatted matrix to the console

  % Start the LaTeX bmatrix environment
  printf("\\begin{bmatrix}\n");

  % Loop through each row of the matrix
  for i = 1:size(M,1)
      % Print the first element of the row
      printf(" %g", M(i,1));

      % Print the remaining elements of the row separated by '&'
      printf(" & %g", M(i,2:end));

      % Add a newline and double backslash if it’s not the last row
      if i < size(M,1)
          printf(" \\\\\n");
      endif
  endfor

  % Close the LaTeX bmatrix environment
  printf("\n\\end{bmatrix}\n");
end

