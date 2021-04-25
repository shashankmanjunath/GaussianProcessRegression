% Trains Regression SVM on boston housing dataset

clear; close all;
addpath("kernels/svm_kernels")
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

% Predicting
mdl = fitrsvm(Xtrain_norm, ytrain_norm, 'KernelFunction', 'linear_SVM_kernel');
yfit = predict(mdl, Xtest_norm);

% Undoing normalization
yfit_unnorm = (yfit * ystd) + ymean;
best_rmse = sqrt(immse(yfit_unnorm, ytest));

fprintf("Test RMSE: %.3f\n", best_rmse);

