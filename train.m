% Script to fit Gaussian process to dataset

clear; close all; clc;
rng(2021);

num_train = 10;
X_train = normrnd(0, 2.5, num_train, 1);
y_train = sin(X_train);
l = 1.0;
noise = 1e-8;

n = 100;
X_s = linspace(-5, 5, n)';

K = square_exp_kernel(X_train, X_train, l);
K_s = square_exp_kernel(X_train, X_s, l);
K_ss = square_exp_kernel(X_s, X_s, l) + noise * eye(n);
K_inv = pinv(K);

mu_s = K_s' * K_inv * y_train;
cov_s = K_ss - K_s' * K_inv * K_s;

% f_post = mvnrnd(mu_s, cov_s, 10);
num_sample = 5
f_post = mu_s + cov_s * normrnd(0, 1, n, num_sample);
 
hold on;

for i = 1:num_sample
    plot(X_s, f_post(:, i));
end
scatter(X_train, y_train, 100, "r", "filled");

uncertainty = 1.96 * sqrt(diag(cov_s));
curve1 = mu_s - uncertainty;
curve2 = mu_s + uncertainty;
plot(X_s, curve1, 'r--');
plot(X_s, curve2, 'r--');
hold off;
