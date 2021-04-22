% generate figure for boston results
% collected these one-by-one
val = [3.513,4.348,4.437,6.35,6.436,4.017];
name = {'GP Rational Quadratic';'SVM Rational Quadratic';
    'GP RBF';'SVM RBF';'GP 2-Polynomial';'SVM 2-Polynomial'};
bar(val)
set(gca, 'XTickLabel', name)  
ylabel('RMSE')
title('Regression performance comparison of GP with SVM')
