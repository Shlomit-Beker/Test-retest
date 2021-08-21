%% Load Excel file and calculates ICC for all components

matrix_means = xlsread('Sub_Means.xlsx')
matrix_means(34:35,:) = [];
matrix_means(:,[2,4]) = dprime_trt_cue;
dprime_trt_cue = matrix_means(:,[2,4]);
dprime_trt_nocue = matrix_means(:,[3,5]);
RT_trt_cue = matrix_means(:,[6,8]);
RT_trt_nocue = matrix_means(:,[7,9]);
STD_trt_cue = matrix_means(:,[10,12]);
STD_trt_nocue = matrix_means(:,[11,13]);
Vis_trt_MaxP1 = matrix_means(:,[14,15]);
Vis_trt_MinN1 = matrix_means(:,[16,17]);
Vis_trt_MaxP2 = matrix_means(:,[18,19]);
Vis_trt_MaxP1(25,:) = [];
Vis_trt_MinN1(25,:) = [];
Vis_trt_MaxP2(25,:) = [];
AEP_trt_MaxP1_Cue = matrix_means(:,[20,21]);
AEP_trt_MinN1_Cue = matrix_means(:,[22,23]);
AEP_trt_MaxP2_Cue = matrix_means(:,[24,25]);
AEP_trt_MaxP1_Cue(30,:) = [];
AEP_trt_MinN1_Cue(30,:) = [];
AEP_trt_MaxP2_Cue(30,:) = [];
AEP_trt_MaxP1_NoCue = matrix_means(:,[26,27]);
AEP_trt_MinN1_NoCue = matrix_means(:,[28,29]);
AEP_trt_MaxP2_NoCue = matrix_means(:,[30,31]);
AEP_trt_MaxP1_NoCue(30,:) = [];
AEP_trt_MinN1_NoCue(30,:) = [];
AEP_trt_MaxP2_NoCue(30,:) = [];
CNV_trt = matrix_means(:,[33,34]);
CNV_trt([8,21,22,31],:) = [];
Phase_trt = matrix_means(:,[35,36]);
Phase_trt([8,21],:) = [];
%% ICC

[r, LB, UB, F, df1, df2, p] = ICC(dprime_trt_cue, '1-k', .05);
[r, LB, UB, F, df1, df2, p] = ICC(dprime_trt_nocue, '1-k', .05);
[r, LB, UB, F, df1, df2, p] = ICC(RT_trt_cue, '1-k', .05);
[r, LB, UB, F, df1, df2, p] = ICC(RT_trt_nocue, '1-k', .05);
[r, LB, UB, F, df1, df2, p] = ICC(STD_trt_cue, '1-k', .05);
[r, LB, UB, F, df1, df2, p] = ICC(STD_trt_nocue, '1-k', .05);
[r, LB, UB, F, df1, df2, p] = ICC(Vis_trt_MaxP1, '1-k', .05);
[r, LB, UB, F, df1, df2, p] = ICC(Vis_trt_MinN1, '1-k', .05);
[r, LB, UB, F, df1, df2, p] = ICC(Vis_trt_MaxP2, '1-k', .05);
[r, LB, UB, F, df1, df2, p] = ICC(AEP_trt_MaxP1_Cue, '1-k', .05);
[r, LB, UB, F, df1, df2, p] = ICC(AEP_trt_MinN1_Cue, '1-k', .05);
[r, LB, UB, F, df1, df2, p] = ICC(AEP_trt_MaxP2_Cue, '1-k', .05);
[r, LB, UB, F, df1, df2, p] = ICC(AEP_trt_MaxP1_NoCue, '1-k', .05);
[r, LB, UB, F, df1, df2, p] = ICC(AEP_trt_MinN1_NoCue, '1-k', .05);
[r, LB, UB, F, df1, df2, p] = ICC(AEP_trt_MaxP2_NoCue, '1-k', .05);
[r, LB, UB, F, df1, df2, p] = ICC(CNV_trt, '1-k', .05);
[r, LB, UB, F, df1, df2, p] = ICC(Phase_trt, '1-k', .05);


CNVOcc = [];
CNVOcc = [indSeqTest,indSeqRetest];

[r, LB, UB, F, df1, df2, p] = ICC(CNVOcc, '1-k', .05);

[r, LB, UB, F, df1, df2, p] = ICC(mxesTestRetest, '1-k', .05);
[r, LB, UB, F, df1, df2, p] = ICC(minsTestRetest, '1-k', .05);
[r, LB, UB, F, df1, df2, p] = ICC(maxP2TestRetest, '1-k', .05);

%%
[r, LB, UB, F, df1, df2, p] = ICC(maxP1TRT, '1-k', .05);
[r, LB, UB, F, df1, df2, p] = ICC(minN1TRT, '1-k', .05);
[r, LB, UB, F, df1, df2, p] = ICC(maxP2TRT, '1-k', .05);
[r, LB, UB, F, df1, df2, p] = ICC(maxP1TRTISV, '1-k', .05);
[r, LB, UB, F, df1, df2, p] = ICC(minsN1TRTISV, '1-k', .05);
[r, LB, UB, F, df1, df2, p] = ICC(maxP2TRTISV, '1-k', .05);

