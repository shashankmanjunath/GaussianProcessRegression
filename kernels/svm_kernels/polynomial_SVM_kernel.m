% This script defines a polynomial kernel


function val = polynomial_kernel(m1, m2)
   
    global c_p;
    global p_p;

    val = (m1*m2'+c_p).^p_p;
    
end
