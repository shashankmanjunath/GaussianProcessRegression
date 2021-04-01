% Script to fit Gaussian process to dataset

clear; close all;
rng(42);

% n = 100;
% x = linspace(0, 10, n)';
%
% mu = zeros(n, 1);
% k = kernel(x, x, 0.44);
%
% norm1 = mvnrnd(mu, k);
% norm2 = mvnrnd(mu, k);
% norm3 = mvnrnd(mu, k);

% plot(x, norm1);
% hold on;
% plot(x, norm2);
% plot(x, norm3);
% hold off;

x = normrnd(0, 10, 5, 1);
y = sin(x);
% scatter(x, y);

n = 200;
x_s = linspace(0, 10, n)';
K_ss = kernel(x_s, x_s, 0.8);
L_ss = chol(K_ss + 1e-6*eye(n));
f_prior = L_ss * normrnd(0, 1, n, 15);

% plot(x_s, f_prior);

K = kernel(x, x, 0.9);
K_s = kernel(x, x_s, 0.9);
L = chol(K + 1e-6 * eye(size(x, 1)));
alpha = L' \ (L \ y);
mu = K_s' * alpha;

v = linsolve(L, K_s);
% v = inv(L)*K_s;
v_mat = K_ss - v' * v;

% Some numerical error - had to add more noise to correct and make B positive definite
f_post = mu + v_mat * normrnd(0, 1, n, 10);

hold on;

for i = 1:10
    plot(x_s, f_post(:, i));
end
