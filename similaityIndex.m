
% Calculates  composite score (similarity index) for each individul 
% based on the ICC score table. 

clear; clc;    
ParametersAllTable = readtable('dataMat.csv');
ParametersMatrix_raw = table2array(ParametersAllTable(:,[5:8,11:24,29:36,41:42,47:48])); %consider only the relevant columns

ParametersMatrix = nan(size(ParametersMatrix_raw));
for j = 1:size(ParametersMatrix_raw,2)
    findInx = find(~isnan(ParametersMatrix_raw(:,j)));
    ParametersMatrix(findInx,j) = zscore(ParametersMatrix_raw(findInx,j));
end
A = ParametersMatrix'; % Only significant correlation, taking out phase and cnv
B = [];
flag = 0;
for i = 1:2:size(A,2)*2
    flag = flag+1;
    B(:,i) = A(1:2:size(A,1)-1,flag);
    B(:,i+1)= A(2:2:size(A,1),flag);
end



flag = 0;
for i = 1:2:size(B,2)-1
    flag = flag+1;
    [r(flag), LB(flag), UB(flag), F(flag), df1(flag), df2(flag), p(flag)] = ICC(B(:,i:i+1), 'A-1', .05);
%add test for dependent samples
end

flag = 0;
variance = [];
for i = 1:2:size(B,2)-1
    flag = flag+1;
    variance(:,flag) = nanvar([B(:,i),B(:,i+1)],0,2);
%add test for dependent samples
end
meanVar = 1-mean(variance,1);
meanVar(11) = []; %subject to reject

%% Upload the clinical mat (meanVar is already there - update if it is changed here). 
C = readtable('clinicalCorrelation.csv');
clinicalMatrix = table2array(C);
clinicalMatrix(:,end) = meanVar;
IQ = clinicalMatrix(:,1);
RBSR = clinicalMatrix(:,2);
VAR = clinicalMatrix(:,3);



%% Multiple linear regression
x1 = RBSR;
x2 = IQ;
y = VAR;
X = [ones(size(x1)) x1 x2 x1.*x2];
b = regress(y,X)  
figure; 
scatter3(x1,x2,y,80,'filled','MarkerFaceAlpha',0.5)
xlabel('RBSR scores')
ylabel('IQ')
zlabel('Test-restest similarity idx')
view(50,10)
hold on
x1fit = min(x1):4:max(x1);
x2fit = min(x2):4:max(x2);
[X1FIT,X2FIT] = meshgrid(x1fit,x2fit);
YFIT = b(1) + b(2)*X1FIT + b(3)*X2FIT + b(4)*X1FIT.*X2FIT;
mesh(X1FIT,X2FIT,YFIT)

hold off

%% plot IQ-SI

[RHO,PVAL]= corr(meanVar',IQ,'rows','pairwise')
coefficients = polyfit(meanVar,IQ', 1);
fittedY = polyval(coefficients,[-0.5:2]);
figure;
scatter(meanVar,IQ);
hold on; 
plot([-0.5:2], fittedY, 'k');

str = {'P (Pearson) =',num2str(PVAL),'Rho = ',num2str(RHO)};
text(1.3,120,str);

%% plot RBSR-SI
[RHO,PVAL]= corr(meanVar',RBSR,'rows','pairwise')
coefficients = polyfit(meanVar,RBSR', 1);
fittedY = polyval(coefficients,[-0.5:2]);
figure;
scatter(meanVar,RBSR);
hold on; 
plot([-0.5:2], fittedY, 'k');

str = {'P (Pearson) =',num2str(PVAL),'Rho = ',num2str(RHO)};
text(1.3,90,str);


