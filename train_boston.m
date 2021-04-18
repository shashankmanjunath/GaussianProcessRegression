% Trains GP on boston housing dataset

clear; close all; clc;
addpath("kernels/")
rng('default')
rng(42);

load('./data/boston_housing_train.mat');
load('./data/boston_housing_test.mat');

% Normalizing Data

mean_train = mean(Xtrain, 1);
std_train = sqrt(var(Xtrain, 1));
Xtrain_norm = (Xtrain - mean_train) ./ std_train;
Xtest_norm = (Xtest - mean_train) ./ std_train;

% Predicting
l = 0.8;
sigma_f = 1;
noise = 0;

datanoise = 0;
p = 1;
alpha = 1;

% kernel = @(x, y)square_exp_kernel(x, y, sigma_f, l);
kernel = @(x, y)rat_quad_kernel(x, y, sigma_f, l, alpha);
% kernel = @(x, y)inverse_rat_quad_kernel(x, y, sigma_f, l, alpha);
[mu_pred, var_pred] = fit_gp(Xtrain_norm, ytrain, Xtest_norm, noise, datanoise, kernel);

rmse = sqrt(mean((mu_pred - ytest).^2));
fprintf("RMSE: %.3f\n", rmse);
