% This script defines a locally periodic kernel


function val = local_periodic_kernel(m1, m2, sigma_f, l, p, alpha)
    % k_SE * k_P
    val = periodic_kernel(m1,m2,p,l,sigma_f) .* square_exp_kernel(m1, m2, l, sigma_f);
    
end
