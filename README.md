# EC503 Final Project

Jeffrey Alido and Shashank Manjunath  
jalido@bu.edu, manjuns@bu.edu  

Implementation of Gaussian Processes for Regression in MATLAB  

To Do:
* 5-fold validation
* Add Linear regression to comparison

Notes:

GP:
  Square Exp Kernel: 
    Best Parameters: [sigma_f]: 0.010000, [l]: 10.000000
    Best RMSE: 3.586
  Rational Quadratic Kernel:
    Best Parameters: [sigma_f]: 0.010000, [l]: 10.000000, [alpha]: 1.000000
    Best Train RMSE: 3.676444
    Test RMSE: 3.560
  Periodic Kernel:
    Best Parameters: [sigma_f]: 0.010000, [l]: 0.000100, [p]: 0.001000
    Best Train RMSE: 9.358216
    Test RMSE: 8.944
  Local Periodic Kernel:
    Best Parameters: [sigma_f]: 10.000000, [l]: 10.000000, [p]: 0.000100, [alpha]: 0.010000
    Best Train RMSE: 5.541675
    Test RMSE: 5.065
  Polynomial Kernel:
    Best Parameters: [c]: 1.000000, [p]: 2.000000
    Best Train RMSE: 5.214246
    Test RMSE: 4.213

SVM:
  Square Exp Kernel:
    Best Parameters: [sigma_f]: 0.001000, [l]: 0.000001
    Best Train RMSE: 3.941912
    Test RMSE: 9.014
  Rational Quadratic Kernel:
    Best Parameters: [sigma_f]: 0.100000, [l]: 0.000010, [alpha]: 0.000100
    Best Train RMSE: 3.905346
    Test RMSE: 9.013
  Periodic Kernel:
    Best Parameters: [sigma_f]: 0.398107, [l]: 0.000025, [p]: 0.000100
    Best Train RMSE: 9.389988
    Test RMSE: 9.017
  Local Periodic Kernel:
    Best Parameters: [sigma_f]: 0.398107, [l]: 10.000000, [p]: 0.001000, [alpha]: 0.000100
    Best Train RMSE: 8.518371
    Test RMSE: 9.014
  Polynomial Kernel:
    Best Parameters: [c]: 0.000000, [p]: 0.001292
    Best Train RMSE: 164.002678
    Test RMSE: 80.389

Ridge Regression:

