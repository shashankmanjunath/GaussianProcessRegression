% Trains linear regressor on boston housing dataset

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

ymean = mean(ytrain);
ystd = sqrt(var(ytrain));
ytrain_norm = (ytrain - ymean) / ystd;

% Adding bias
Xtrain_norm = [ones(size(Xtrain_norm, 1), 1), Xtrain_norm];
Xtest_norm = [ones(size(Xtest_norm, 1), 1), Xtest_norm];

% Fitting
w = Xtrain_norm \ ytrain_norm;

% Predictiong
ypred_norm = Xtest_norm * w;
ypred = (ypred_norm * ystd) + ymean;
best_rmse = sqrt(immse(ypred, ytest));

fprintf("Linear Regression Test RMSE: %f\n", best_rmse);
