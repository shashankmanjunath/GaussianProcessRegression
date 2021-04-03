clear; close all; clc;
rng('default')
rng(42);

num_train = 5;
X_train = normrnd(0, 2.5, num_train, 1);
y = sin(X_train);
l = 1.5;
sigma_f = 1.0;
noise = 1e-6;
num_preds = 3;

num_test = 100;
X_test = linspace(-5, 5, num_test)';

kernel = @(x, y)square_exp_kernel(x, y, l, sigma_f);

[mu_pred, var_pred] = fit_gp(X_train, y, X_test, noise, kernel);

f_post = mu_pred + var_pred * normrnd(0, 1, num_test, num_preds);


hold on;

plot(X_test, f_post, 'DisplayName', 'Prediction');

uncertainty = 2 * sqrt(diag(var_pred));
curve1 = mu_pred - uncertainty;
curve2 = mu_pred + uncertainty;
scatter(X_train, y, 100, 'r', 'filled', 'DisplayName', 'Training Points');
plot(X_test, curve1, 'r--', 'DisplayName', 'Upper 95% CI Interval');
plot(X_test, curve2, 'r--', 'DisplayName', 'Lower 95% CI Interval');
plot(X_test, sin(X_test), 'k--', 'DisplayName', 'True Data')

hold off;
lgd = legend('Location', 'eastoutside');

