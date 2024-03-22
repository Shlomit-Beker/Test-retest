function MAT = corrmatrix_all(csvTable)

% Calculates correlation matrix from a csv file. 
% input: string of csvTable name. csvTable contains columns with variables, with / without header. 
% output: correlation matrix MAT. code written for the VAMP TRT paper

Table = readtable(csvTable);
matrix = table2array(Table);

[r,p] = corrcoef(matrix,'rows','pairwise');

figure; imagesc(p); %non corrected to multiple comparisons.
caxis([0 0.1]);
title('p values - not corrected')

% Plot
figure;
r =  tril(r);
r(r==0)=1;
imagesc(r)
colormap(bone)
colorbar;
title('correlation matrix')

% Correct for multiple comparisons
[h, crit_p, adj_ci_cvrg, adj_p]= fdr_bh(p,0.05,'dep');
[x,y] = find(h); 
hold on; scatter(x',y','ow','filled')
box off
hold on;

%add p values on top of the matrix
for i = 1:size(r,1)
    for j = 1:size(r,2)
        text(i,j,num2str(p(i,j)),'Color','white','FontSize',8)

        hold on;
    end
end


