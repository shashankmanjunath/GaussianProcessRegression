% This script defines a periodic kernel


function val = periodic_kernel(m1, m2, sigma_f, l, p, alpha)
    [m, d1] = size(m1);
    [n, d2] = size(m2);

    absdist = zeros(m,n);
    for i = 1 : m
        for j = 1 : n
            absdist(i,j) = norm(m1(i,:)-m2(j,:),1);
        end
    end
    val = sigma_f^2*exp(-2 * sin(pi* absdist / p).^2 / (l^2));
end
