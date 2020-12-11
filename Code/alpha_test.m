clear
clc
close all

data = csvread('breast_death.csv',2,2);
data2 = csvread('breast_tot.csv',2,2);
DK_death=data(46,4:45);
DK_tot=data2(46,1:42);

Y = DK_death';
X = [ones(size(DK_tot)); DK_tot]';
xs = linspace(40,100);
theta_opt= inv(X'*X)*X'*Y;

figure(1)
hold on
grid on
title('Learning Rate Effects');
xlabel('Learning Rate (\alpha)');
ylabel('Relative Error in \theta');

for i=1:10:500
alpha =[i*10^-6;i*10^-8];
theta=[0;0];
for step=1:10000
    % batch gradient
    g = (-Y+X*theta)'*X;
    theta = theta - alpha .* g';
end
  err=abs((theta(2)-theta_opt(2))/theta_opt(2));
  if err>=0.005 && err<=0.01
      fit_alpha=alpha;
  end
  hold on
  figure(1)
  plot(alpha(2), err , 'rx');
  pause(0.01)
end
saveas(figure(1),'Alpha_convergence.eps','epsc')