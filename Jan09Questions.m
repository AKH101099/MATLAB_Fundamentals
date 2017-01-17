%% local maxima and minima of a vector

xdata = -300:300;
ydata = -7000*xdata.^2 + 0.1*xdata.^4;
plot(xdata,ydata,'Linewidth',2)

[peaks,pidx] = findpeaks(ydata);
% to get minima, just flip data with negative sign:
[valleys,vidx] = findpeaks(-ydata);

hold on
plot(xdata(pidx),ydata(pidx),'ro','MarkerSize',10,'LineWidth',2)
plot(xdata(vidx),ydata(vidx),'kx','MarkerSize',10,'LineWidth',2)
hold off

legend('vacuum structure','meta-stable point','stable points','location','NE')
title('Higgs boson potential')
ylabel('energy')
xlabel('field strength')

%% how to ignore 0 as an error flag

% some data containing zeros:
sensordata = randi([0, 10],1,1000);

% locate non-zeros
idx = sensordata > 0;

cleandata = sensordata(idx);

% can turn zeros into NaNs if need be
nandata = standardizeMissing(sensordata,0);

nidx = isnan(nandata);

%% get residuals from polyfit
% some (fake) data:
Age = sort(90*rand(1,1000));
BP = 10*randn(1,1000) + 0.01*Age.^2 - 0.1*Age + 40;

plot(Age,BP,'.r')
xlabel('Age')
ylabel('Blood Pressure')
title('Heart Health')

c = polyfit(Age,BP,2);

%residuals
% want a point on the fit for every point in data
BPfit = polyval(c,Age); %fit for residuals

hold on
plot(Age,BPfit,'color',[0.7 0 0.7],'LineWidth',2)
hold off

resids = BPfit - BP;

figure
histogram(resids)
xlabel('residuals')

%% residuals w/ fitlm function
% In the Statistics and Machine Learning Toolbox
model = fitlm(Age,BP,'quadratic');
figure
plot(model)
figure
plotResiduals(model)

%% how to fit a user-defined function to data
% two common ways:
% distribution fitting (maximum likelihood estimation)
% regression (least squares fitting)

% requires knowledge of function handles
% an example of a function handle is
s = @sin
% look in the workspace, and see sin is now in the workspace
% can use this to operate on numbers
s(6)

% can make more complex function handles with inputs and outputs
f = @(x,y) x + y.^2;
f(1,2)
% all begin with @ symbol and then a definition

%% custom distribution fitting:

% some (fake) data
R = [random('normal',2,1.5,1000,1); random('normal',8,2.1,700,1)] + 700; %2 sets of data, from 2 different distributions, joined

figure
histogram(R,'Normalization','pdf') %normalized
xlabel('wavelength')
ylabel('counts (scaled)')

% try fitting a bimodal distribution (defined by user)
% make a function handle of 2 normal distributions (you are modeling probability density)
pdf_normmixture = @(g,p,mu1,mu2,sigma1,sigma2) p*pdf('normal',g,mu1,sigma1) + (1-p)*pdf('normal',g,mu2,sigma2);
% normpdf is for normal distributions, there are other pdfs

% initial guess
pStart = .5;
muStart = quantile(R,[.25 .75])
sigmaStart = sqrt(var(R) - .25*diff(muStart).^2)
start = [pStart muStart sigmaStart sigmaStart];

% use maximum likelhood estimate to estimate parameter values:
options = statset('MaxIter',300); %increase iterations, 200 is default
paramEsts = mle(R, 'pdf',pdf_normmixture,'start',start,'options',options)
% paramEsts now contains the parameter estimates

% input those params into function handle to get x-y values for plotting
x = linspace(min(R),max(R),1000);
y = pdf_normmixture(x,paramEsts(1),paramEsts(2),paramEsts(3),paramEsts(4),paramEsts(5));
hold on
plot(x,y,'k--','linewidth',2)
hold off

legend('relative count','mle fit')

%% custom function for regression fitting: 
% some (fake) data:
P = paramEsts(1)
Mu1 = paramEsts(2)
Mu2 = paramEsts(3)
Sig1 = paramEsts(4)
Sig2 = paramEsts(5)

hydrogen = @(x) P*pdf('normal',x,Mu1,Sig1) + (1-P)*pdf('normal',x,Mu2,Sig2);

wavelength = (715-695)*rand(1000,1) + 695;
amplitude = abs(hydrogen(wavelength) + 0.01*randn(1000,1));
% okay, done making fake data

figure
plot(wavelength,amplitude,'.')
xlabel('wavelength')
ylabel('amplitude')

% to fit something like this with regression, you may need a non-linear (non-polynomic) function
% here we specify the function to fit using a function handle, with 2 inputs for: betas (b), and the predictor data (x)
modelfun = @(b,x) b(1)*pdf('normal',x,b(3),b(5)^2 + 0.001) + b(2)*pdf('normal',x,b(4),b(6)^2 + 0.001) + b(7);
% the fit is done numerically, so we have to supply an initial guess as well:
guess = [0.5; 0.5; 700; 700; 2; 2; 0];

model = fitnlm(wavelength,amplitude,modelfun,guess);

w = 695:0.1:715;
a = predict(model,w');

hold on
plot(w,a,'r-','LineWidth',2)
hold off

legend('photon data','ls fit')

%% how to have inputdlg box respond to "enter" key
% It cannot be done with inputdlg as is
% Here is a link to MATLAB answers on how to implement this:
% http://www.mathworks.com/matlabcentral/answers/96640-how-can-i-modify-the-inputdlg-function-to-make-the-enter-key-synonymous-with-the-ok-button-in

%% unit analysis
% if you want to for example add 5 miles to 5 kilometers to get 8.1 miles
% you need to create your own class (remember tables, cells, etc are
% classes)
% We talk about this in depth in our Object Oriented Programming course.

% You can also find a toolbox on the file exchange:
% https://www.mathworks.com/matlabcentral/fileexchange/29621-units-conversion-toolbox

%% when will there be simulink and stateflow trainings

% https://www.mathworks.com/services/training/courses.html?s_tid=tgw_ofrg_trg_bod#simulink
% https://www.mathworks.com/services/training/courses.html?s_tid=tgw_ofrg_trg_bod#stateflow
