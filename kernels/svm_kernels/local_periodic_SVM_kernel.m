% This script defines a locally periodic kernel
% addpath("../")

function val = local_periodic_kernel(m1, m2, sigma_f, l, p, alpha)
    global sigma_f_p;
    global l_p;
    global p_p;
    global alpha_p;
    
    
    val = periodic_kernel(m1,m2,p_p,l_p,sigma_f_p) .* square_exp_kernel(m1, m2, l_p, sigma_f_p);
    
end
