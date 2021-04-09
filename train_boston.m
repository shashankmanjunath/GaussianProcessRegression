% Trains GP on boston housing dataset

clear; close all; clc;
rng('default')
rng(42);

load('boston_housing_train.mat');
load('boston_housing_test.mat');

l = 0.8;
sigma_f = 1;
noise = 0;
datanoise = 0;
p = 1;
alpha = 1;
kernel = @(x, y)rat_quad_kernel(x, y, sigma_f, l, p, alpha);
[mu_pred, var_pred] = fit_gp(Xtrain, ytrain, Xtest, noise, datanoise, kernel);

rmse = sqrt(mean((mu_pred - ytest).^2));
fprintf("RMSE: %.3f\n", rmse);