clear; close all;

num_hyper_samp = 3;
l = linspace(0.25, 0.75, num_hyper_samp);
sigma_f = linspace(0.75, 1.25, num_hyper_samp); 

samp = 100;
x_1 = linspace(-5, 5, samp);
x_2 = 0;
val = zeros(samp, 1);

% RBF
% figure;
%
% idx = 1;
% for lval = 1:num_hyper_samp
%     for sval = 1:num_hyper_samp
%         kernel = @(x, y)square_exp_kernel(x, y, sigma_f(sval), l(lval));
%
%         for i = 1:samp
%             val(i) = kernel(x_1(i), x_2);
%         end
%
%         subplot(num_hyper_samp, num_hyper_samp, idx);
%         plot(x_1, val);
%         ylim([0, 2])
%         titlestr = sprintf("Sigma = %.2f, l = %.2f", sigma_f(sval), l(lval));
%         title(titlestr);
%         idx = idx+1;
%     end
% end

% RQK
% num_hyper_samp = 5;
% sigma_f = 1.0;
% l = 1;
%
% alpha = logspace(0, num_hyper_samp-1, num_hyper_samp);
%
% figure;
%
% idx = 1;
%
% for aval = 1:num_hyper_samp
%     kernel = @(x, y)rat_quad_kernel(x, y, sigma_f, l, alpha(aval));
%
%     for i = 1:samp
%         val(i) = kernel(x_1(i), x_2);
%     end
%
%     subplot(1, num_hyper_samp, idx);
%     plot(x_1, val);
%     ylim([0, 2])
%     titlestr = sprintf("\\alpha = %.2f", alpha(aval));
%     title(titlestr);
%     idx = idx+1;
% end

% Periodic Kernel
num_hyper_samp = 5;
sigma_f = 1.0;
l = 1;

p = linspace(1, num_hyper_samp, num_hyper_samp);

figure;

idx = 1;

for pval = 1:num_hyper_samp
    kernel = @(x, y)periodic_kernel(x, y, sigma_f, l, p(pval));

    for i = 1:samp
        val(i) = kernel(x_1(i), x_2);
    end

    subplot(1, num_hyper_samp, idx);
    plot(x_1, val);
    ylim([0, 2])
    titlestr = sprintf("p = %.2f", p(pval));
    title(titlestr);
    idx = idx+1;
end
