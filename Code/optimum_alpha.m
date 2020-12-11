function fit_alpha=optimum_alpha(step,interval,iterations)
%% Read the data
data = csvread('breast_death.csv',2,2);
data2 = csvread('breast_tot.csv',2,2);
DK_death=data(46,4:45);
DK_tot=data2(46,1:42);
Y = DK_death';
X = [ones(size(DK_tot)); DK_tot]';
theta_opt= inv(X'*X)*X'*Y;
%% Run the iteration
for i=1:step:interval
alpha =[i*10^-6;i*10^-8];
theta=[0;0];
for step=1:iterations
    % batch gradient
    g = (-Y+X*theta)'*X;
    theta = theta - alpha .* g';
end
  err=abs((theta(2)-theta_opt(2))/theta_opt(2));
  if err>=0.005 && err<=0.01
      fit_alpha=alpha;
  end
end
end
