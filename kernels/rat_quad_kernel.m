% This script defines a rational quadratic kernel


function val = rat_quad_kernel(m1, m2, sigma_f, l, p, alpha)
    [m, d1] = size(m1);
    [n, d2] = size(m2);

    sqdist = sum(m1.^2, 2) + sum(m2.^2, 2)' - 2*m1*m2';
    val = sigma_f^2*(1+sqdist/(2*alpha*l^2)).^alpha;
end
