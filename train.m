% Script to fit Gaussian process to dataset

clear; close all; clc;
rng(2021);

x = normrnd(0, 5, 5, 1);
y = sin(x);
l = 0.8;
noise = 1e-6;

n = 200;
x_s = linspace(-10, 10, n)';
K_ss = square_exp_kernel(x_s, x_s, l);
L_ss = chol(K_ss + noise*eye(n));
f_prior = L_ss * normrnd(0, 1, n, 15);

% plot(x_s, f_prior);

K = square_exp_kernel(x, x, l);
K_s = square_exp_kernel(x, x_s, l);
L = chol(K + noise * eye(size(x, 1)));
alpha = linsolve(L', linsolve(L, y));
mu = K_s' * alpha;

v = linsolve(L, K_s);
v_mat = K_ss - v' * v;

f_post = mu + v_mat * normrnd(0, 1, n, 10);

hold on;

for i = 1:10
    plot(x_s, f_post(:, i));
end
scatter(x, y, 100, "r", "filled");
hold off;
