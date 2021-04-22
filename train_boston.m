% Trains GP on boston housing dataset

clear; close all; clc;
rng('default')
rng(42);

load('boston_housing_train.mat');
load('boston_housing_test.mat');

l = 0.8;
sigma_f = 1;
noise = 0;

<<<<<<< Updated upstream
datanoise = 0;
p = 1;
alpha = 1;
kernel = @(x, y)rat_quad_kernel(x, y, sigma_f, l, p, alpha);
[mu_pred, var_pred] = fit_gp(Xtrain, ytrain, Xtest, noise, datanoise, kernel);
=======
p = 2;
c = 0;
alpha = 1;

kernel = @(x, y)square_exp_kernel(x, y, sigma_f, l);
kernel = @(x, y)polynomial_kernel(x, y, c, p);
% kernel = @(x, y)rat_quad_kernel(x, y, sigma_f, l, alpha);
% kernel = @(x, y)inverse_rat_quad_kernel(x, y, sigma_f, l, alpha);
[mu_pred_norm, var_pred_norm] = fit_gp(Xtrain_norm, ytrain_norm, Xtest_norm, noise, datanoise, kernel);

% Undoing normalization
mu_pred = (mu_pred_norm * ystd) + ymean;
var_pred = (var_pred_norm * ystd) + ymean;
>>>>>>> Stashed changes

rmse = sqrt(mean((mu_pred - ytest).^2));
fprintf("RMSE: %.3f\n", rmse);
