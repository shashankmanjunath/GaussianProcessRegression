function G = rat_quad_SVM_kernel(U,V)
% as per MATLAB documentation on fitsvm

    global l_p;
    global sigma_f_p;
    global alpha_p;

    sqdist = sum(U.^2, 2) + sum(V.^2, 2)' - 2*U*V';
    G = (sigma_f_p^2)*(1+(sqdist/(2*alpha_p*l_p^2))).^(-alpha_p);
end
