function [mu_pred, var_pred] = fit_gp(X, y, X_test, noisetest, noisedata, kernel)
    n = size(X_test, 1);
    m = size(X,1);
    K = kernel(X, X) + noisedata*eye(m);
    K_s = kernel(X, X_test);
    K_ss = kernel(X_test, X_test) + noisetest*eye(n);
    K_inv = pinv(K);

    mu_pred = K_s' * K_inv * y;
    var_pred = K_ss - K_s' * K_inv * K_s;
end
