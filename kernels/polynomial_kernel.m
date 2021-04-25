% This script defines a polynomial kernel


function val = polynomial_kernel(m1, m2, c, p)
   
    val = (m1*m2'+c).^p;
    
end
