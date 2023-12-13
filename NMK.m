function [F, J] = NMK(x)
    global X_i Y_i Z_i CT
    F = (x(1) - X_i).^2 + (x(2) - Y_i).^2 + (x(3) - Z_i).^2 - CT.^2;
    if nargout > 1
        J = [2 * x(1) - 2 .* X_i;  2 * x(2) - 2. * Y_i; 2 * x(3) - 2 .* Z_i].';
    end
end