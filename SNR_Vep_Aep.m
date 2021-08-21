%% Calculates Signal-Noise-Ratio of VEP and AEP, on the full average structure

FS = 256;
 timept1 = 0.16; % low window milliseconds AEP
 timept2 = 0.24; % high window milliseconds AEP

% define the windows (in samples) for signal and noise
samplept1 = round(timept1*FS+0.2*FS); %conversion to sample in seconds
samplept2 = round(timept2*FS+0.2*FS);
sampleNoise1 = 1;                               
sampleNoise2 = round(0.1*FS);

for i = 1:length(average)
    for j = 1:size(average{1},1)
       maxpeak(i,j)= max(average{i}(j,samplept1:samplept2),[],2);
        noise(i,j) = mean(average{i}(j,sampleNoise1:sampleNoise2));
    end
end 

SNR = maxpeak.^2./noise.^2;

SNR_decaud = mag2db(SNR);
statsSNRaud = [nanmean(SNR_decaud,2),nanstd(SNR_decaud,[],2)]


%% reduce number of trials from the big grandData structure
load grandData_VEP_Coll_TRT
blData = baselineGrandData(grandData,[25:51]);

%%
clear SNR_decaud statsSNRaud
tic
for k = 1:10
    
    CHAN = {'O1','Oz','O2'}; % for entrainment: 'C1','Cz','C2' for visual sequence: 'AF3','Fp1','AFz','Fpz','A7','PO3','POz','PO4',
    C = [find(strcmp(blData{1}.data.label,CHAN{1})),find(strcmp(blData{1}.data.label,CHAN{2})),find(strcmp(grandData{1}.data.label,CHAN{3}))];%...
    refChan = 37;
    R = 0.125;
    clear data_reduced data_red
    flag=0;
    for i = [1:2:length(blData)]
    
        flag = flag+1;
        L = length(blData{i}.trialinfo);
        N = randperm(L,ceil(L*R));
        data = blData{i}.data.trial(N);
        for j = 1:length(data)
            %data_ref = ft_preproc_rereference(data{j}, refChan);
            data_red(j,:) = mean(data{j}(C,:));
        end
        data_reduced(flag,:) = nanmean(data_red);
    end
    
    
    FS = 256;
    
    timept1 = 0.08; % low window milliseconds  VEP
    timept2 = 0.16; % high window milliseconds VEP
    samplept1 = round(timept1*FS+0.2*FS); %conversion to sample in seconds
    samplept2 = round(timept2*FS+0.2*FS);
    sampleNoise1 = 1;
    sampleNoise2 = round(0.1*FS);
    for j = 1:size(data_reduced,1)
        maxpeak(j)= max(data_reduced(j,samplept1:samplept2),[],2);
        %maxP1TRTISV(:,i) = std(average{i}(:,samplept1:samplept2),[],2)
        noise(j) = mean(data_reduced(j,sampleNoise1:sampleNoise2));
    end
    
    SNR = maxpeak.^2./noise.^2;
    
    SNR_decaud(k,:) = mag2db(SNR);
    statsSNRaud(k,:) = [nanmean(SNR_decaud(k,:),2),nanstd(SNR_decaud(k,:),[],2)];
    
end
toc
statsMeanR1_indiv = nanmean(SNR_decaud,1)
mean(statsMeanR1_indiv)
