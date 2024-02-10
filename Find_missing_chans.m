%% This script is for finding the missing electrodes in wake eeg data

dirData = 'D:\WAKE_PSG_RAW_EDFs';

inSub{1,1}    = 'MS101';
inSub{2,1}    = 'MS102';
inSub{3,1}    = 'MS103';
inSub{4,1}    = 'MS104';
inSub{5,1}    = 'MS105';
inSub{6,1}    = 'MS107';
inSub{7,1}    = 'MS108';
inSub{8,1}    = 'MS109';
inSub{9,1}    = 'MS110';
inSub{10,1}    = 'MS112';
inSub{11,1}    = 'MS113';
inSub{12,1}    = 'MS115';
inSub{13,1}    = 'MS116';
inSub{14,1}    = 'MS117';
inSub{15,1}    = 'MS119';
inSub{16,1}    = 'MS120';
inSub{17,1}    = 'MS121';
inSub{18,1}    = 'MS123';
inSub{19,1}    = 'MS124';
inSub{20,1}    = 'MS126';
inSub{21,1}    = 'MS127';
inSub{22,1}    = 'MS129';
inSub{23,1}    = 'MS130';
inSub{24,1}    = 'MS131';
inSub{25,1}    = 'MS133';
inSub{26,1}    = 'MS135';
inSub{27,1}    = 'MS136';
inSub{28,1}    = 'MS137';
inSub{29,1}    = 'MS138';
inSub{30,1}    = 'MS139';
inSub{31,1}    = 'MS140';
inSub{32,1}    = 'MS141';
inSub{33,1}    = 'MS143';
inSub{34,1}    = 'MS145';
inSub{35,1}    = 'MS148';
inSub{36,1}    = 'MS164';
inSub{37,1}    = 'MS166';
inSub{38,1} = 'MS118';
inSub{39,1} = 'MS122';
inSub{40,1} = 'MS159';
inSub{41,1} = 'MS161';
inSub{42,1} = 'MS167';
inSub{43,1} = 'MS162_1';
inSub{44,1} = 'MS162_2';
inSub{45,1} = 'MS132';
inSub{46,1} ='MS146';
inSub{47,1} = 'MS165';
%%
    for iSub = 1 : size(inSub)
        fprintf('.... analyse sub %d, grp %d\n', iSub);
        %Extract Eyes Closed Trials
cfg            = [];
cfg.dataset    = fullfile(dirData,[inSub{iSub} '.edf']);
cfg.trl =[1 10 1];
% Preprocessing Files
cfg.continuous = 'yes';
cfg.channel    = 'all'
datas{iSub} = ft_preprocessing(cfg);
fprintf('Extracting some data');
    end 

all_chans={'Fz','M1','M2','Cz','Oz','Fpz','C3','C4','F3','F4','Fp1','Fp2','O1','O2'};

for iSub=1:47
Missing_chans{iSub}=setdiff(all_chans,Channels{iSub});
end
A=strings(20,47);
for iSub=find(~cellfun(@isempty,Missing_chans))
for i=1:length(Missing_chans{iSub})
A(i,iSub)=string(Missing_chans{iSub}{i})';
disp(iSub)
end
end

A

