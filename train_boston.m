% Trains GP on boston housing dataset

clear; close all; clc;
rng('default')
rng(42);

load('boston_housing_train.mat');
load('boston_housing_test.mat');

l = 0.8;
sigma_f = 1;
noise = 0;

kernel = @(x, y)square_exp_kernel(x, y, l, sigma_f);
[mu_pred, var_pred] = fit_gp(Xtrain, ytrain, Xtest, noise, kernel);

rmse = sqrt(mean((mu_pred - ytest).^2));
fprintf("RMSE: %.3f\n", rmse);
