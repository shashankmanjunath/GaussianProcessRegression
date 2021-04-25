% This script defines a periodic kernel


function val = periodic_kernel(m1, m2)
    [m, d1] = size(m1);
    [n, d2] = size(m2);

    global sigma_f_p;
    global l_p;
    global p_p;

    absdist = 0;
    for i = 1 : d1
        absdist = absdist + abs(m1(:,i) - m2(:,i)');
    end
    val = sigma_f_p^2*exp(-2 * sin(pi* absdist / p_p).^2 / (l_p^2));
end
