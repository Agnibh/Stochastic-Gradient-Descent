clear;clc;close all;

%Define constants
M= sqrt(2);                         % M-bound
rho = sqrt(2);                      % Lipchitzness
sigma = 0.3 * eye(4);               % Standard Deviation 
n = [50 100 500 1000];              % No.of training samples
N = 400;                            % No.of test samples
mu_neg = [-1/4 -1/4 -1/4 -1/4];     % Mean of negative label test samples
mu_pos = [1/4 1/4 1/4 1/4];         % Mean of positive label test sample
Itr = 30;                           % Number of iterations                

%Test Data
load('test.mat')                    % Load Test Samples

L_tot = zeros(1,30);                % Initialize risk error 
Err_tot = zeros(1,30);              % Initialize classification error

L_avg = zeros(1,4);                 % Initialize Average Risk
L_min = zeros(1,4);                 % Initialize Minimum Risk
L_exp = zeros(1,4);                 % Initialize Excess Risk
L_std = zeros(1,4);                 % Initialize Std Deviation of Risk

Err_avg = zeros(1,4);               % Initialize Average Classification Error
Err_std = zeros(1,4);               % Initialize Standard Deviation of Classification Error

for m = 1:size(n,2)         % Run for training sample size of 50,100,500,1000
for j=1:Itr                 % Run Itr number of iterations for each sample size
%Train Data
R1_trn = mvnrnd(mu_neg,sigma,n(m)/2);  
X1_trn = R1_trn';                   % Genarated negative label train samples

R2_trn = mvnrnd(mu_pos,sigma,n(m)/2);
X2_trn = R2_trn';                   % Genarated positive label train samples

X_trn1 = [X1_trn X2_trn ;ones(1,n(m))];   % Extended Train samples

Y_trn1 = [-1*ones(1,n(m)/2) ones(1,n(m)/2)]; % Labels

Dt1 = [X_trn1;Y_trn1];                 % Create Data Matrix of samples and labels

cols = size(Dt1,2);                    % Shuffle the matrix
ran = randperm(cols);
Dt = Dt1(:,ran);                       % Matrix after reshuffling

Xb_trn = Dt(1:5,:);                    % First 5 rows is X
X_trn = Xcheck_cube(Xb_trn);           % Make sure X lies within unit sphere/cube
Y_trn = Dt(6,:);                       % Last row is label

%SGD start
w = zeros(5,1);                        % Initialize parameter vector to 0
alpha = M/(rho*sqrt(n(m)));            % Step-size
W = zeros(5,n(m)+1);                   % Store parameter vector in W

for i=1:n(m)                           % Run loop for training samples
    c1 = exp(-Y_trn(i)*dot(w,X_trn(:,i)));  
    c2 = 1/(1+c1)*c1*-Y_trn(i);
    w_del = c2*X_trn(:,i);             % Gradient computed
    wb = w - alpha*w_del;              % Generate new w 
    w = Wcheck_cube(wb);               % Make sure W lies within unit sphere/cube
    W(:,i+1) = w;                      % Store w
end

W_fin = mean(W,2);                     % Take mean

% Compute error from testing samples
l = zeros(1,N);                        % Risk error
err = zeros(1,N);                      % Classification error

%Test
for k=1:N                              % Run for all test samples
   l(k)=log(1+exp(-Y_tst(k)*dot(W_fin,X_tst(:,k)))); % Store logostic loss
   c = sign(dot(W_fin,X_tst(:,k)))-Y_tst(k);         % Store classification error
   if(c ==0)
   err(k) = 0;
   else
   err(k) = 1;  
   end
end

L = mean(l);            % Expected logistic loss 
Err = mean(err);        % Expected classification  

L_tot(j) = L;           % Store for each iteration
Err_tot(j) = Err;

end

L_avg(m) = mean(L_tot);             % Average of risk for each sample size
L_min(m) = min(L_tot);              % Minimum of risk for each sample size
L_exp(m) = L_avg(m) - L_min(m);     % Excess risk for each sample size
L_std(m) = std(L_tot);              % Std Deviation of risk for each sample size

Err_avg(m) = mean(Err_tot);  % Average of Classification Error for each sample size
Err_std(m) = std(Err_tot);   % Std Deviation of Classification Error for each sample size

end

figure(1)
errorbar(n, L_exp, L_std,'k')
hold on
plot(n,L_exp,'k*')
xlim([0 1200]);
xticks(0:100:1200);
xlabel('Number of Iterations')
ylabel('Expected Excess Risk')
title('Expected Excess Risk with Standard Deviation')

figure(2)
errorbar(n, Err_avg, Err_std,'k')
hold on
plot(n,Err_avg,'k*')
xlim([0 1200]);
xticks(0:100:1200);
xlabel('Number of Iterations')
ylabel('Expected Classification Error')
title('Expected Classification Error with Standard Deviation')

