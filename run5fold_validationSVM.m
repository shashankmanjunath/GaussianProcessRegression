% Train SVM on boston housing dataset for 5-fold validation

clear; close all; clc;
addpath("kernels/svm_kernels")
rng('default')
rng(42);

load('./data/boston_housing_train.mat');
load('./data/boston_housing_test.mat');

num_splits = 5;

Xtrain_final = Xtrain;
ytrain_final = ytrain;
Xtest_final = Xtest;
ytest_final = ytest;

D_x = Xtrain;
D_y = ytrain;
N = length(D_x);
test_idx = floor(linspace(1,N,num_splits+1));
shuffle_idx = randperm(N);
D_x = D_x(shuffle_idx, :);
D_y = D_y(shuffle_idx);

num_grid = 6;
rmse_arr = zeros(num_grid, num_grid, num_grid, num_grid);

l = logspace(-6, 1, num_grid);
sigma_f = logspace(-6, 1, num_grid);
alpha = logspace(-4, 3, num_grid);

c = linspace(0, 5, num_grid);
p = logspace(-4, 1, num_grid);

% Setting globals to be passed into functions
global sigma_f_p;
global l_p;
global alpha_p;
global c_p;
global p_p;

for i = 1 : 5
    tic;
    fprintf("Training Fold %d\n", i);
    
    % --- Calculating indices for train and test sets for fold i ---
    train_set_idx = 1:N;
    % Finding test indices
    test_set_idx = test_idx(i):test_idx(i+1); 
    % Removing test indices from train indices
    train_set_idx = train_set_idx .* ~ismember(train_set_idx, test_set_idx);
    train_set_idx = train_set_idx(train_set_idx ~= 0);

    % Splitting fold
    Xtrain = D_x(train_set_idx, :);
    Xtest = D_x(test_set_idx, :);
    ytrain = D_y(train_set_idx);
    ytest = D_y(test_set_idx);
    
    % Normalizing Data
    mean_train = mean(Xtrain, 1);
    std_train = sqrt(var(Xtrain, 1));
    Xtrain_norm = (Xtrain - mean_train) ./ std_train;
    Xtest_norm = (Xtest - mean_train) ./ std_train;

    ymean = mean(ytrain);
    ystd = sqrt(var(ytrain));
    ytrain_norm = (ytrain - ymean) ./ ystd;

    for aval = 1:num_grid
        fprintf("[%d/%d]\n", aval, num_grid);
        for bval = 1:num_grid
            for cval = 1:num_grid
                for dval = 1:num_grid
                    % uncomment which kernel to use
                    % kernel = @(x, y)periodic_kernel(x, y, sigma_f(aval), l(bval), p(cval));
                    % kernel = @(x, y)local_periodic_kernel(x, y, sigma_f(aval), l(bval), p(cval), alpha(dval));
                    % kernel = @(x, y)polynomial_kernel(x, y, c(aval), p(bval));

                    sigma_f_p = sigma_f(aval);
                    l_p = l(bval);
                    % c_p = c(aval);
                    p_p = p(bval);
                    alpha_p = alpha(dval);

                    % mdl = fitrsvm(Xtrain_norm, ytrain_norm,'KernelFunction', 'square_exp_SVM_kernel');
                    % mdl = fitrsvm(Xtrain_norm, ytrain_norm,'KernelFunction', 'rat_quad_SVM_kernel');
                    % mdl = fitrsvm(Xtrain_norm, ytrain_norm,'KernelFunction', 'polynomial_SVM_kernel');
                    % mdl = fitrsvm(Xtrain_norm, ytrain_norm,'KernelFunction', 'periodic_SVM_kernel');
                    mdl = fitrsvm(Xtrain_norm, ytrain_norm, 'KernelFunction', 'local_periodic_SVM_kernel');
                    yfit = predict(mdl, Xtest_norm);

                    % Undoing normalization
                    yfit_unnorm = (yfit * ystd) + ymean;
                    rmse = sqrt(immse(yfit_unnorm, ytest));

                    rmse_arr(aval, bval, cval, dval) = rmse_arr(aval, bval, cval, dval) + rmse;
                end
            end
        end
    end
    toc;
end

% Finding best parameters
min_rmse = min(min(min(min(rmse_arr))));
linear_min_idx = find(rmse_arr == min_rmse);

% If we have more than one minimum, we select one randomly
if size(linear_min_idx, 1) >= 1
    linear_min_idx = randsample(linear_min_idx, 1);
end

[s_idx, l_idx, p_idx, a_idx] = ind2sub(size(rmse_arr), linear_min_idx);

opt_s = sigma_f(s_idx);
opt_l = l(l_idx);
opt_a = alpha(a_idx);
% opt_c = c(c_idx);
opt_p = p(p_idx);

sigma_f_p = opt_s;
l_p = opt_l;
alpha_p = opt_a;
% c_c = opt_c;
p_p = opt_p;

% fprintf("Best Parameters: [sigma_f]: %f, [l]: %f, [alpha]: %f\n", opt_s, opt_l, opt_a);
fprintf("Best Parameters: [sigma_f]: %f, [l]: %f, [p]: %f, [alpha]: %f\n", opt_s, opt_l, opt_p, opt_a);
fprintf("Best Train RMSE: %f\n", min_rmse / num_splits);

% --- Final Training ---
mean_train = mean(Xtrain_final, 1);
std_train = sqrt(var(Xtrain_final, 1));
Xtrain_norm = (Xtrain_final - mean_train) ./ std_train;
Xtest_norm = (Xtest_final - mean_train) ./ std_train;

ymean = mean(ytrain_final);
ystd = sqrt(var(ytrain_final));
ytrain_norm = (ytrain_final - ymean) ./ ystd;

% mdl = fitrsvm(Xtrain_norm, ytrain_norm,'KernelFunction', 'square_exp_SVM_kernel');
% mdl = fitrsvm(Xtrain_norm, ytrain_norm, 'KernelFunction', 'rat_quad_SVM_kernel');
% mdl = fitrsvm(Xtrain_norm, ytrain_norm,'KernelFunction', 'polynomial_SVM_kernel');
% mdl = fitrsvm(Xtrain_norm, ytrain_norm, 'KernelFunction', 'periodic_SVM_kernel');
mdl = fitrsvm(Xtrain_norm, ytrain_norm, 'KernelFunction', 'local_periodic_SVM_kernel');
yfit = predict(mdl, Xtest_norm);

% Undoing normalization
yfit_unnorm = (yfit * ystd) + ymean;
best_rmse = sqrt(immse(yfit_unnorm, ytest_final));

fprintf("Test RMSE: %.3f\n", best_rmse);
