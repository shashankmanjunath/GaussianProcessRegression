% This script defines a squared exponential kernel


function val = square_exp_kernel(m1, m2)
    [m, d1] = size(m1);
    [n, d2] = size(m2);

    global sigma_f_p;
    global l_p;

    sqdist = sum(m1.^2, 2) + sum(m2.^2, 2)' - 2*m1*m2';
    val = sigma_f_p^2*exp(-1 * sqdist / (2 * l_p^2));
end
