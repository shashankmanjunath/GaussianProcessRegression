% This script defines a periodic kernel


function val = periodic_kernel(m1, m2, sigma_f, l, p)
    [m, d1] = size(m1);
    [n, d2] = size(m2);

    absdist = 0;
    for i = 1 : d1
        absdist = absdist + abs(m1(:,i) - m2(:,i)');
    end
    val = sigma_f^2*exp(-2 * sin(pi* absdist / p).^2 / (l^2));
end
