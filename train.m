clear; close all; clc;
rng(2021);

num_train = 10;
X_train = normrnd(0, 2.5, num_train, 1);
y = sin(X_train);
l = 1;
p = 2; % for periodic kernel
sigma_f = 1;
noisetest = 1e-6;
noisedata = 1e-1;
num_preds = 5;
alpha = 1e-1;
num_test = 1000;
X_test = linspace(-5, 5, num_test)';

kernel = @(x, y)periodic_kernel(x, y, sigma_f, l, p, alpha);
tic
[mu_pred, var_pred] = fit_gp(X_train, y, X_test, noisetest, noisedata, kernel);
toc
f_post = mu_pred + var_pred * normrnd(0, 1, num_test, num_preds);

hold on;

for i = 1:num_preds
    plot(X_test, f_post);
end
scatter(X_train, y, 100, 'r', 'filled');

uncertainty = 1.96 * sqrt(diag(var_pred));
curve1 = mu_pred - uncertainty;
curve2 = mu_pred + uncertainty;
plot(X_test, curve1, 'r--');
plot(X_test, curve2, 'r--');
plot(X_test, sin(X_test), 'k--')
hold off;

