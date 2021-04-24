% Trains GP on boston housing dataset

clear; close all; clc;
addpath('kernels/')
rng('default')
rng(42);

load('./data/boston_housing_train.mat');
load('./data/boston_housing_test.mat');

D_x = cat(1,Xtest,Xtrain);
D_y = cat(1,ytest,ytrain);
N = length(D_x);
test_idx = linspace(1,N,6);
% just for reference
% train_idx = [[test_idx(2):N];
%             [1:test_idx(2)-1, test_idx(3):N];
%             [1:test_idx(3)-1, test_idx(4):N];
%             [1:test_idx(4)-1, test_idx(5):N];
%             [1:test_idx(5)-1]];
%
average_RMSE = 0;
for i = 1 : 5
    
    Xtest = D_x(101*(i-1)+1:101*i,:);
    if i == 1
        Xtrain = D_x(test_idx(2):N,:);
    elseif i == 5
        Xtrain = D_x(1:test_idx(5)-1,:);
    else
        Xtrain = D_x([1:test_idx(i)-1,test_idx(i+1):N],:);
    end
    ytest = D_x(101*(i-1)+1:101*i)';
    if i == 1
        ytrain = D_x(test_idx(2):N)';
    elseif i == 5
        ytrain = D_x(1:test_idx(5)-1)';
    else
        ytrain = D_x([1:test_idx(i)-1,test_idx(i+1):N])';
    end
    
    % Normalizing Data
    mean_train = mean(Xtrain, 1);
    std_train = sqrt(var(Xtrain, 1));
    Xtrain_norm = (Xtrain - mean_train) ./ std_train;
    Xtest_norm = (Xtest - mean_train) ./ std_train;

    ymean = mean(ytrain);
    ystd = sqrt(var(ytrain));
    ytrain_norm = (ytrain - ymean) ./ ystd;

    % Predicting
    l = 0.8;
    sigma_f = 1;
    noise = 1e-6;

    datanoise = 0;
    c = 0; 
    p = 2;
    alpha = 1;
    % uncomment which kernel to use
    kernel = @(x, y)rat_quad_kernel(x, y, sigma_f, l, alpha);
    kernel = @(x, y)square_exp_kernel(x, y, sigma_f, l);
    kernel = @(x, y)polynomial_kernel(x, y, c, p);
    
    [mu_pred_norm, var_pred_norm] = fit_gp(Xtrain_norm, ytrain_norm, Xtest_norm, noise, datanoise, kernel);


    % Undoing normalization
    mu_pred = (mu_pred_norm * ystd) + ymean;
    var_pred = (var_pred_norm * ystd) + ymean;

    rmse = sqrt(immse(mu_pred,ytest));
    average_RMSE = average_RMSE + rmse;
end
average_RMSE = average_RMSE / 5;