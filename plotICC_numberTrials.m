% plotting changes in ICC as a function of number of trials used.

names = {'VEP P1'; 'VEP N1'; 'VEP P2'; 'VEP P1 ITV'; 'VEP N1 ITV'; 'VEP P2 ITV'};
percentage = {'All trials';'25% of the trials';'12.5% of the trials'};

% Numbers below are ICC for each subset of trials

all = [0.7946,0.8615,0.7203,0.7944, 0.8560,  0.8148]';
fourth = [ 0.7247, 0.7091,0.4386,0.7637,0.8417 ,0.7299]';
eighth = [0.6544 ,0.5569, 0.4362 ,0.6918 ,0.8322 , 0.6134]';
combined = [all,fourth,eighth];
figure; 
plot(combined');
hold on; 
for i = 1:length(all)
    scatter([1:3],combined(i,:));
end

set(gca,'xtick',[1:3],'xticklabel',percentage)
xlim([0 4]);
ylabel('ICC value');
box off

legend(names)