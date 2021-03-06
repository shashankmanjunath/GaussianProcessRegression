% Train SVM on boston housing dataset

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

ymean_train = mean(ytrain);
ystd_train = sqrt(var(ytrain));
ytrain_norm = (ytrain - ymean_train) / ystd_train;

% Train an SVM model; uncomment which kernel to use
mdl=fitrsvm(Xtrain_norm,ytrain_norm,'KernelFunction','rat_quad_SVM_kernel');
% mdl=fitrsvm(Xtrain_norm,ytrain_norm); % linear kernel 
mdl=fitrsvm(Xtrain_norm,ytrain_norm,'KernelFunction','gaussian'); % gaussian/RBF kernel 
mdl=fitrsvm(Xtrain_norm,ytrain_norm,'KernelFunction','polynomial','PolynomialOrder',2); % linear kernel 
yfit=predict(mdl,Xtest_norm);

% Undoing normalization
yfit_unnorm = (yfit * ystd_train) + ymean_train;

immse(yfit_unnorm,ytest)^(1/2)
