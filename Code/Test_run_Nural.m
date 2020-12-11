clear
clc
close all

%% Read the data
data = csvread('breast_death.csv',2,2);
data2 = csvread('breast_tot.csv',2,2);
DK_death=data(46,4:45);
DK_tot=data2(46,1:42);

%% Instantiate thetas and assign X,y
alpha = optimum_alpha(10,10000,10000);
theta=[0;0];
Y = DK_death';
X = [ones(size(DK_tot)); DK_tot]';
xs = linspace(40,100);

%% Normal Equation for Linear Regression
theta_opt= inv(X'*X)*X'*Y;

%% Pre-initialise the scatter plots and the best fit
figure(1)
plot(DK_tot,DK_death,'x')
hold on
grid on
title('Breast Cancer Cases in Denmark (1953-1995)');
xlabel('Annual Cases per 1000');
ylabel('Annual Deaths per 1000');
axis([40 100 0 45]);
plot(xs, theta_opt(1) +theta_opt(2)*xs,'-r')

%% Find the optimal alpha

%% Run the optimisation loop to see how the slope changes
for stop=[0 2 4 6 8 10 30 1000 120000]
  for step=1:stop
    % batch gradient
    g = (-Y+X*theta)'*X;
    theta = theta - alpha .* g';
  end
  hold on
  figure(1)
  plot(xs, theta(1) + theta(2)*xs, '-');
  
  pause(0.4);
end

saveas(figure(1),'Slope_convergence.eps','epsc')