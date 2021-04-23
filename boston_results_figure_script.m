% generate figure for boston results
% collected these one-by-one
val = [4.433,5.479,6.481,7.459,1.756,0.282];
name = {'GP Rational Quadratic';'SVM Rational Quadratic';
    'GP RBF';'SVM RBF';'GP 2-Polynomial';'SVM 2-Polynomial'};
bar(val)
set(gca, 'XTickLabel', name)  
ylabel('RMSE')
title('Regression performance comparison of GP with SVM')
