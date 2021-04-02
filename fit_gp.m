function [mu_pred, var_pred] = fit_gp(X, y, X_test, noise, kernel)
    n = size(X_test, 1);

    K = kernel(X, X);
    K_s = kernel(X, X_test);
    K_ss = kernel(X_test, X_test) + noise*eye(n);
    K_inv = pinv(K);

    mu_pred = K_s' * K_inv * y;
    var_pred = K_ss - K_s' * K_inv * K_s;
end
