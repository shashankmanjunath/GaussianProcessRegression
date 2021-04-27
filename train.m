clear; close all; clc;
rng('default')
rng(2021);

num_train = 6;
X_train = normrnd(0, 5, num_train, 1);
y = sin(X_train);
l = 1.5;
sigma_f = 1.0;
noise = 1e-6;
num_preds = 2;

num_test = 100;
X_test = linspace(-10, 10, num_test)';
ytest = sin(X_test)

kernel = @(x, y)square_exp_kernel(x, y, l, sigma_f);

[mu_pred, var_pred] = fit_gp(X_train, y, X_test, noise, noise, kernel);

f_post = mvnrnd(mu_pred, var_pred, num_preds);

hold on;

plot(X_test, mu_pred, 'DisplayName', 'Predicted Mean')
plot(X_test, f_post, 'DisplayName', 'Prediction');

uncertainty = 2 * sqrt(diag(var_pred));
curve1 = mu_pred - uncertainty;
curve2 = mu_pred + uncertainty;
scatter(X_train, y, 100, 'r', 'filled', 'DisplayName', 'Training Points');
plot(X_test, curve1, 'r--', 'DisplayName', 'Upper 95% CI Interval');
plot(X_test, curve2, 'r--', 'DisplayName', 'Lower 95% CI Interval');
plot(X_test, sin(X_test), 'k--', 'DisplayName', 'True Data')

title("Example Gaussian Process on Synthetic Sine Data", "FontSize", 15)
xlabel("Domain", "FontSize", 10)
ylabel("Range", "FontSize", 10)

h = gcf;
set(h,'PaperOrientation','landscape');
lgd = legend('Location', 'northeastoutside');

hold off;
