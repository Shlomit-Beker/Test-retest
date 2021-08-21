% Calculates sex diffferences between excluded and included samples. 

n1 = 4; N1 = 33; % After exclusion
n2 = 11; N2 = 61; % Before exclusion
x1 = [repmat('a',N1,1); repmat('b',N2,1)];
x2 = [repmat(1,n1,1); repmat(2,N1-n1,1); repmat(1,n2,1); repmat(2,N2-n2,1)];
[tbl,chi2stat,pval] = crosstab(x1,x2)

%  Results:
%       tbl =
%                 51        8142
%                 74        8127
%       chi2stat =
%              4.2419
%       pval =
%            0.039437