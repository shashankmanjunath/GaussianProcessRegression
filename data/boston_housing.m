% Loads boston housing data and writes consistent train and test splits
% Taken from https://www.cs.ubc.ca/~murphyk/Teaching/Stat406-Spring08/homework/hw3.pdf

clear; close all; clc;

seed = 2; 
rand('state',seed); 
randn('state', seed);

data = load('housing.data');
x = data(:, 1:13);
y = data(:,14);

[n,d] = size(x);

perm = randperm(n); % remove any possible ordering fx
x = x(perm,:); 
y = y(perm);

Ntrain = 400;
Xtrain = x(1:Ntrain,:); 
ytrain = y(1:Ntrain);
Xtest = x(Ntrain+1:end,:); 
ytest = y(Ntrain+1:end);

save('boston_housing_train.mat', 'Xtrain', 'ytrain');
save('boston_housing_test.mat', 'Xtest', 'ytest');
