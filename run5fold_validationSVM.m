% Train SVM on boston housing dataset for 5-fold validation

clear; close all; clc;
addpath("kernels/")
rng('default')
rng(42);

load('./data/boston_housing_train.mat');
load('./data/boston_housing_test.mat');
D_x = cat(1,Xtest,Xtrain);
D_y = cat(1,ytest,ytrain);
N = length(D_x);
test_idx = linspace(1,N,6);

average_RMSE = 0;
for i = 1 : 5
    % partition data
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

    ymean_train = mean(ytrain);
    ystd_train = sqrt(var(ytrain));
    ytrain_norm = (ytrain - ymean_train) / ystd_train;

    % Train an SVM model; uncomment which kernel to use
    mdl=fitrsvm(Xtrain_norm,ytrain_norm,'KernelFunction','rat_quad_SVM_kernel');
    % mdl=fitrsvm(Xtrain_norm,ytrain_norm); % linear kernel 
%     mdl=fitrsvm(Xtrain_norm,ytrain_norm,'KernelFunction','gaussian'); % gaussian/RBF kernel 
%     mdl=fitrsvm(Xtrain_norm,ytrain_norm,'KernelFunction','polynomial','PolynomialOrder',2); % polynomial kernel 
    yfit=predict(mdl,Xtest_norm);

    % Undoing normalization
    yfit_unnorm = (yfit * ystd_train) + ymean_train;

    average_RMSE = average_RMSE + immse(yfit_unnorm,ytest)^(1/2);
end
average_RMSE = average_RMSE / 5;