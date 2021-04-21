function G = rat_quad_SVM_kernel(U,V)
% as per MATLAB documentation on fitsvm
l = 0.8;
sigma_f = 1;
alpha = 1;

sqdist = sum(U.^2, 2) + sum(V.^2, 2)' - 2*U*V';
G = (sigma_f^2)*(1+(sqdist/(2*alpha*l^2))).^(-alpha);
end