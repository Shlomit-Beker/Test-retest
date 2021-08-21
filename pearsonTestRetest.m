% Pearson correlations on all test-retest pairs

ParametersAllTable = readtable('dataMat_forCorrMatrix.csv');
ParametersMatrix = table2array(ParametersAllTable);

flag = 0;
figure;
p=size(ParametersMatrix);
for i = 1:2:size(ParametersMatrix,2)-1
    flag = flag+1;
    [RHO1(flag),PVAL1(flag)] = corr(ParametersMatrix(:,i),ParametersMatrix(:,i+1),'rows','pairwise');
     
    coefficients = polyfit(ParametersMatrix(isnan(ParametersMatrix(:,i))==0,i),ParametersMatrix(isnan(ParametersMatrix(:,i+1))==0,i+1), 1);
    M = max([ParametersMatrix(:,i);ParametersMatrix(:,i+1)]);
    N = min([ParametersMatrix(:,i);ParametersMatrix(:,i+1)]);

    fittedY = polyval(coefficients,[N:M*1.5]); %the 1.5 is to make the linear line longer

    subplot(7,8,i)
    scatter(ParametersMatrix(:,i),ParametersMatrix(:,i+1),4)
    hold on;
    plot([N:M*1.5], fittedY, 'k');
    pause
end

% correct for multiple comparisons with bonferroni:
alpha = 0.05;
numSig = find(PVAL1<0.05);
newPVal = alpha/length(numSig);
newSigInd = find(PVAL1<newPVal);
newSigVal = PVAL1(newSigInd)
