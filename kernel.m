% This script defines a squared exponential kernel


function val = kernel(m1, m2, l)
    [m, d1] = size(m1);
    [n, d2] = size(m2);

    sqdist = sum(m1.^2, 2) + sum(m2.^2, 2)' - 2*m1*m2';
    val = exp(- 1 * sqdist / (2 * l^2));
end
