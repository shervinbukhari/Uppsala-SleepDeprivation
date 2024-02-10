%% Preamble
addpath('D:\fieldtrip-master') %Add FT path
ft_defaults
addpath('\\user.uu.se\bmci\INV-Users\shebu516\Documents\WAKE_PSG_RAW_EDFs'); %Add EEG filepath
dirData = '\\user.uu.se\bmci\INV-Users\shebu516\Documents\WAKE_PSG_RAW_EDFs';
cd('D:\MATLAB')
%% fundamental parameters
numGrp  = 1;
numSub  = 47; %46 but 2 recordings for 162
%
fsample = 256;
%% subjects list
inSub       = cell(numSub,numGrp);
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
inSub{18,1}    = 'MS101';
inSub{19,1}    = 'MS124';
inSub{20,1}    = 'MS126';
inSub{21,1}    = 'MS127';
inSub{22,1}    = 'MS129';
inSub{01,1}    = 'MS130';
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
out = [];
obSub= [16 17 21 22 23 25 26 27 30 31 32 36 37 39 40 41 42 43 44 46];
ctrl = [3 4 6 11 14 15 20 24 28 29 33 38 1 2 5 7 8 9 10 12 13 18 19 34 35 45];
FeSub = [3 6 11 14 15 20 22 24 25 28 29 33 36 37 38 39 40 42 44 46];
MaSub = [1 2 4 5 7 8 9 10 12 13 16 17 18 19 21 23 26 27 30 31 32 34 35 41 43 45];
%%
for iGrp = 1 : numGrp
    for iSub = 1 : numSub
        fprintf('.... analyse sub %d, grp %d\n', iSub, iGrp);
        %Extract Eyes Closed Trials
cfg            = [];
cfg.dataset    = fullfile(dirData,[inSub{iSub,iGrp} '.edf']);
cfg.trialfun   = 'ft_trialfun_edf_eyesclosed';
cfg = ft_definetrial(cfg);

% Preprocessing Files
cfg.continuous = 'yes';
cfg.reref       = 'yes';
cfg.channel    = {'O*','C*', 'F*' ,'E*' ,'M1','M2', '-EOGr:M1' '-EOGl:M2' '-Fp2:M1' '-Fp1:M2' '-F4:M1' '-F3:M2' '-C4:M1' '-C3:M2' '-O2:M1' '-O1:M2' '-EMG1' '-EMG2' '-EMG3' 'C3' 'C4' 'O1' 'O2' 'M1' 'M2' 'Fp1' 'F3' 'F4' 'EOGl' 'EOGr' '-EKG II' 'Fp2' 'Fpz' 'F7' 'F8' 'Fz' 'Cz' 'Oz' '-EMG4' '-EMG5' '-EMG6'};
cfg.refchannel = {'M1', 'M2'};
data_ec{iSub} = ft_preprocessing(cfg);
    end 
fprintf('All eyes closed data extracted');
end
%% Filtering and Downsampling to 100 Hz
dataEC_fltr=cell(1,44);
dataEC_fltr_rs=cell(1,44);
% dataEO_fltr=cell(1,37);
% dataEO_fltr_rs=cell(1,37);

for iSub= 1:numSub
cfg =[];
cfg.hpfilter            = 'yes';
cfg.hpfreq              = 0.5;
cfg.hpfiltord           = 3;
cfg.hpinstabilityfix    = 'reduce';
cfg.lpfilter            = 'yes';
cfg.lpfreq              = 30;
cfg.lpfiltord           = 3;
cfg.lpinstabilityfix    = 'reduce';
cfg.bsfilter            = 'yes';
cfg.bsfreq              = [48 52; 98 102];
dataEC_fltr{iSub} = ft_preprocessing(cfg, data_ec{iSub});

cfg =[];
cfg.resamplefs      = 100;
cfg.detrend         = 'yes';
cfg.demean          = 'yes';
dataEC_fltr_rs{iSub} = ft_resampledata(cfg, dataEC_fltr{iSub});
end

save('data_ec','data_ec');
save('dataEC_fltr_rs','dataEC_fltr_rs');


for iSub=1:numSub
cfg =[];
cfg.hpfilter            = 'yes';
cfg.hpfreq              = 0.5;
cfg.hpfiltord           = 3;
cfg.hpinstabilityfix    = 'reduce';
cfg.lpfilter            = 'yes';
cfg.lpfreq              = 30;
cfg.lpfiltord           = 3;
cfg.lpinstabilityfix    = 'reduce';
cfg.bsfilter            = 'yes';
cfg.bsfreq              = [48 52; 98 102];
dataEO_fltr{iSub} = ft_preprocessing(cfg, data_eo{iSub});
cfg =[];
cfg.resamplefs      = 100; %This is the same as fsample
cfg.detrend         = 'yes';
cfg.demean          = 'yes';
dataEO_fltr_rs{iSub} = ft_resampledata(cfg, dataEO_fltr{iSub});
end

%% Bad Chans !EYES CLOSED!
badch.dataEC_fltr_rs{1,1}.trial{1,1}={'Oz', 'Fpz' ,'Fp2', 'Fp1'};
badch.dataEC_fltr_rs{1,1}.trial{1,2}={'Oz', 'Fpz'};
badch.dataEC_fltr_rs{1,1}.trial{1,3}={'Fp2', 'Fp1', 'F4'};
badch.dataEC_fltr_rs{1,1}.trial{1,4}={'Fp2', 'Fp1', 'F4'};
badch.dataEC_fltr_rs{1,1}.trial{1,5}={'Fp2', 'F4' 'Fpz' 'Oz'};


badch.dataEC_fltr_rs{1,2}.trial{1,1}={'Oz', 'Fpz'};
badch.dataEC_fltr_rs{1,2}.trial{1,2}= {'Fpz', 'Oz', 'Fp1' 'Fp2'};
badch.dataEC_fltr_rs{1,2}.trial{1,3}= {'Fpz' 'Fp1', 'Oz' 'Fp2' 'F4'}; 
badch.dataEC_fltr_rs{1,2}.trial{1,4}= {'Fpz' 'Fp1', 'Oz' 'Fp2' 'F4'}; 
badch.dataEC_fltr_rs{1,2}.trial{1,5}= {'Fpz' 'Fp1', 'Oz' 'Fp2' 'F4'};


badch.dataEC_fltr_rs{1,3}.trial{1,1}= {'Oz', 'Fpz', 'Cz'};
badch.dataEC_fltr_rs{1,3}.trial{1,2}= {'Oz', 'Fpz', 'Fp2' 'Fp1' 'Cz'};
badch.dataEC_fltr_rs{1,3}.trial{1,3}={'Fp2', 'Fp1', 'Cz', 'Oz', 'Fpz'};
badch.dataEC_fltr_rs{1,3}.trial{1,4}={'Cz' 'Fpz' 'Oz'};
badch.dataEC_fltr_rs{1,3}.trial{1,5}={'Cz' 'Fpz' 'Oz'}; %Sleeping

badch.dataEC_fltr_rs{1,4}.trial{1,1}= {'Fpz', 'Oz',};
badch.dataEC_fltr_rs{1,4}.trial{1,2}= {'Fpz', 'Oz',};
badch.dataEC_fltr_rs{1,4}.trial{1,3}= {'Fpz', 'Oz',}; 
badch.dataEC_fltr_rs{1,4}.trial{1,4}= {'Fpz', 'Oz',};
badch.dataEC_fltr_rs{1,4}.trial{1,5}= {'Fpz' 'Oz'};

badch.dataEC_fltr_rs{1,5}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,5}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,5}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,5}.trial{1,4}= {'Fpz', 'Oz','F3'};
badch.dataEC_fltr_rs{1,5}.trial{1,5}= {'Fpz', 'Oz','F3','C3'};

badch.dataEC_fltr_rs{1,6}.trial{1,1}= {'Fpz', 'Oz', 'Fp1'};
badch.dataEC_fltr_rs{1,6}.trial{1,2}= {'Fpz', 'Oz', 'Fp1'};
badch.dataEC_fltr_rs{1,6}.trial{1,3}= {'Fpz', 'Oz', 'Fp1', 'O1'}; 
badch.dataEC_fltr_rs{1,6}.trial{1,4}= {'Fpz', 'Oz', 'Fp1', 'O1'};
badch.dataEC_fltr_rs{1,6}.trial{1,5}= {'Fpz', 'Oz', 'Fp1', 'O1'};

badch.dataEC_fltr_rs{1,7}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,7}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,7}.trial{1,3}= {'Fpz', 'Oz', 'Cz'}; 
badch.dataEC_fltr_rs{1,7}.trial{1,4}= {'Fpz', 'Oz', 'Cz'};
badch.dataEC_fltr_rs{1,7}.trial{1,5}= {'Fpz', 'Oz', 'Cz'};

badch.dataEC_fltr_rs{1,8}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,8}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,8}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,8}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,8}.trial{1,5}= {'Fpz', 'Oz'};

badch.dataEC_fltr_rs{1,9}.trial{1,1}= {'Fpz', 'Oz', 'Fz', 'Fp1'};
badch.dataEC_fltr_rs{1,9}.trial{1,2}= {'Fpz', 'Oz', 'Fz', 'Fp1'};
badch.dataEC_fltr_rs{1,9}.trial{1,3}= {'Fpz', 'Oz', 'Fz' 'Fp1'}; 
badch.dataEC_fltr_rs{1,9}.trial{1,4}= {'Fpz', 'Oz', 'Fz', 'Fp1'};
badch.dataEC_fltr_rs{1,9}.trial{1,5}= {'Fpz', 'Oz', 'Fz', 'Fp1', 'Fp2'};

badch.dataEC_fltr_rs{1,10}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,10}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,10}.trial{1,3}= {'Fpz', 'Oz', 'Fp1'}; 
badch.dataEC_fltr_rs{1,10}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,10}.trial{1,5}= {'Fpz', 'Oz'};

badch.dataEC_fltr_rs{1,11}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,11}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,11}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,11}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,11}.trial{1,5}= {'Fpz', 'Oz'};

badch.dataEC_fltr_rs{1,12}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,12}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,12}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,12}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,12}.trial{1,5}= {'Fpz', 'Oz'};

badch.dataEC_fltr_rs{1,13}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,13}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,13}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,13}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,13}.trial{1,5}= {'Fpz', 'Oz'};

badch.dataEC_fltr_rs{1,14}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,14}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,14}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,14}.trial{1,4}= {'Fpz', 'Oz','F3','Fp1'};
badch.dataEC_fltr_rs{1,14}.trial{1,5}= {'Fpz', 'Oz'}; 

badch.dataEC_fltr_rs{1,15}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,15}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,15}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,15}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,15}.trial{1,5}= {'Fpz', 'Oz'};

badch.dataEC_fltr_rs{1,16}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,16}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,16}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,16}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,16}.trial{1,5}= {'Fpz', 'Oz'};

badch.dataEC_fltr_rs{1,17}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,17}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,17}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,17}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,17}.trial{1,5}= {'Fpz', 'Oz'}; 

badch.dataEC_fltr_rs{1,18}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,18}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,18}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,18}.trial{1,4}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,18}.trial{1,5}= {'Fpz', 'Oz'};

badch.dataEC_fltr_rs{1,19}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,19}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,19}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,19}.trial{1,4}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,19}.trial{1,5}= {'Fpz', 'Oz'}; 

badch.dataEC_fltr_rs{1,20}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,20}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,20}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,20}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,20}.trial{1,5}= {'Fpz', 'Oz'};

badch.dataEC_fltr_rs{1,21}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,21}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,21}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,21}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,21}.trial{1,5}= {'Fpz', 'Oz', 'Cz'};

badch.dataEC_fltr_rs{1,22}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,22}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,22}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,22}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,22}.trial{1,5}= {'Fpz', 'Oz'};

badch.dataEC_fltr_rs{1,01}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,01}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,01}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,01}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,01}.trial{1,5}= {'Fpz', 'Oz'};

badch.dataEC_fltr_rs{1,24}.trial{1,1}= {'Fpz', 'Oz'}; % VERY NOISY
badch.dataEC_fltr_rs{1,24}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,24}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,24}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,24}.trial{1,5}= {'Fpz', 'Oz'};

badch.dataEC_fltr_rs{1,25}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,25}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,25}.trial{1,3}= {'Fpz', 'Oz'}; %VERY NOISY 3-5
badch.dataEC_fltr_rs{1,25}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,25}.trial{1,5}= {'Fpz', 'Oz'};

badch.dataEC_fltr_rs{1,26}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,26}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,26}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,26}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,26}.trial{1,5}= {'Fpz', 'Oz'};

badch.dataEC_fltr_rs{1,27}.trial{1,1}= {'Fpz', 'Oz', 'O2'};
badch.dataEC_fltr_rs{1,27}.trial{1,2}= {'Fpz', 'Oz', 'O1', 'O2','C4'};
badch.dataEC_fltr_rs{1,27}.trial{1,3}= {'Fpz', 'Oz', 'O1', 'O2'}; 
badch.dataEC_fltr_rs{1,27}.trial{1,4}= {'Fpz', 'Oz', 'O1', 'O2'};
badch.dataEC_fltr_rs{1,27}.trial{1,5}= {'Fpz', 'Oz', 'O1', 'O2'};

badch.dataEC_fltr_rs{1,28}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,28}.trial{1,2}= {'Fpz', 'Oz', 'C4', 'O2'};
badch.dataEC_fltr_rs{1,28}.trial{1,3}= {'Fpz', 'Oz'}; % 3-5 VERY NOISY
badch.dataEC_fltr_rs{1,28}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,28}.trial{1,5}= {'Fpz', 'Oz'};

badch.dataEC_fltr_rs{1,29}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,29}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,29}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,29}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,29}.trial{1,5}= {'Fpz', 'Oz'};

badch.dataEC_fltr_rs{1,30}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,30}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,30}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,30}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,30}.trial{1,5}= {'Fpz', 'Oz'};

badch.dataEC_fltr_rs{1,31}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,31}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,31}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,31}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,31}.trial{1,5}= {'Fpz', 'Oz'};

badch.dataEC_fltr_rs{1,32}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,32}.trial{1,2}= {'Fpz', 'Oz', 'O1'};
badch.dataEC_fltr_rs{1,32}.trial{1,3}= {'Fpz', 'Oz', 'O1', 'Cz'}; 
badch.dataEC_fltr_rs{1,32}.trial{1,4}= {'Fpz', 'Oz', 'O1', 'Cz'};
badch.dataEC_fltr_rs{1,32}.trial{1,5}= {'Fpz', 'Oz', 'O1', 'Cz'};

badch.dataEC_fltr_rs{1,33}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,33}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,33}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,33}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,33}.trial{1,5}= {'Fpz', 'Oz'};

badch.dataEC_fltr_rs{1,34}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,34}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,34}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,34}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,34}.trial{1,5}= {'Fpz', 'Oz'};

badch.dataEC_fltr_rs{1,35}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,35}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,35}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,35}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,35}.trial{1,5}= {'Fpz', 'Oz'};

badch.dataEC_fltr_rs{1,36}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,36}.trial{1,2}= {'Fpz', 'Oz', 'O1', 'O2'};
badch.dataEC_fltr_rs{1,36}.trial{1,3}= {'Fpz', 'Oz', 'O1', 'O2'}; 
badch.dataEC_fltr_rs{1,36}.trial{1,4}= {'Fpz', 'Oz'}; % VERY NOISY 4-5
badch.dataEC_fltr_rs{1,36}.trial{1,5}= {'Fpz', 'Oz'};

badch.dataEC_fltr_rs{1,37}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,37}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,37}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,37}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,37}.trial{1,5}= {'Fpz', 'Oz', 'O1'};

badch.dataEC_fltr_rs{1,38}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,38}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,38}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,38}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,38}.trial{1,5}= {'Fpz', 'Oz'};

badch.dataEC_fltr_rs{1,39}.trial{1,1}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,39}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,39}.trial{1,3}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,39}.trial{1,4}= {'Fpz', 'Oz'}; 
badch.dataEC_fltr_rs{1,39}.trial{1,5}= {'Fpz', 'Oz'}; 


badch.dataEC_fltr_rs{1,40}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,40}.trial{1,2}= {'Fpz', 'Oz','O1'};
badch.dataEC_fltr_rs{1,40}.trial{1,3}= {'Fpz', 'Oz','O1','F4'}; 
badch.dataEC_fltr_rs{1,40}.trial{1,4}= {'Fpz', 'Oz','O1','F4','O2','Cz'}; 
badch.dataEC_fltr_rs{1,40}.trial{1,5}= {'Fpz', 'Oz','O1','F4','O2','Cz'};

badch.dataEC_fltr_rs{1,41}.trial{1,1}= {'Fpz', 'Oz','O1'};
badch.dataEC_fltr_rs{1,41}.trial{1,2}= {'Fpz', 'Oz','O1'};
badch.dataEC_fltr_rs{1,41}.trial{1,3}= {'Fpz', 'Oz','O1','C4'};
badch.dataEC_fltr_rs{1,41}.trial{1,4}= {'Fpz', 'Oz','O1','C4'};
badch.dataEC_fltr_rs{1,41}.trial{1,5}= {'Fpz', 'Oz','O1','C4'};

badch.dataEC_fltr_rs{1,42}.trial{1,1}= {'Fpz', 'Oz','O2'};
badch.dataEC_fltr_rs{1,42}.trial{1,2}= {'Fpz', 'Oz','O2'}; %NOISY - real or artifact?
badch.dataEC_fltr_rs{1,42}.trial{1,3}= {'Fpz', 'Oz','O2'}; %NOISY - real or artifact?
badch.dataEC_fltr_rs{1,42}.trial{1,4}= {'Fpz', 'Oz'}; %NOISY - real or artifact?
badch.dataEC_fltr_rs{1,42}.trial{1,5}= {'Fpz', 'Oz'}; %NOISY - real or artifact?

badch.dataEC_fltr_rs{1,43}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,44}.trial{1,1}= {'Fpz', 'Oz','C3','C4','Fz'};
badch.dataEC_fltr_rs{1,44}.trial{1,2}= {'Fpz', 'Oz','C3','C4','Fz'};
badch.dataEC_fltr_rs{1,44}.trial{1,3}= {'Fpz', 'Oz''C3','C4','Fz'};
badch.dataEC_fltr_rs{1,44}.trial{1,4}= {'Fpz', 'Oz''C3','C4','Fz'};

badch.dataEC_fltr_rs{1,45}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,45}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,45}.trial{1,3}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,45}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,45}.trial{1,5}= {'Fpz', 'Oz'};

badch.dataEC_fltr_rs{1,46}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,46}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,46}.trial{1,3}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,46}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,46}.trial{1,5}= {'Fpz', 'Oz'};

badch.dataEC_fltr_rs{1,47}.trial{1,1}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,47}.trial{1,2}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,47}.trial{1,3}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,47}.trial{1,4}= {'Fpz', 'Oz'};
badch.dataEC_fltr_rs{1,47}.trial{1,5}= {'Fpz', 'Oz', 'Cz'};


%% AVERAGE INTERPOLATION OF BAD CHANNELS
clear repdataEC
for iSub=1:numSub
for itrl=1:numel(badch.dataEC_fltr_rs{iSub}.trial)
cfg = [];
cfg.trials = 'all';
cfg.badchannel =badch.dataEC_fltr_rs{iSub}.trial{itrl};
cfg.neighbours =neighbours;
cfg.layout = lay;
cfg.method ='weighted';
repdataEC{iSub}= ft_channelrepair(cfg, dataEC_fltr_rs{iSub});
end
end
%% divide DATA INTO TIMEBIN PER SUBJECT
ECdata_2300=cell(1,47);
ECdata_0100=cell(1,47);
ECdata_0300=cell(1,47);
ECdata_0500=cell(1,47);
ECdata_0700=cell(1,47);

for iSub=1:42
cfg=[];
cfg.trials = 1;
ECdata_2300{iSub}=ft_selectdata(cfg,repdataEC{iSub});
cfg.trials = 2;
ECdata_2300{iSub}=ft_selectdata(cfg,repdataEC{iSub});
cfg.trials = 3;
ECdata_0300{iSub}=ft_selectdata(cfg,repdataEC{iSub});
cfg.trials = 4;
ECdata_0500{iSub}=ft_selectdata(cfg,repdataEC{iSub});
cfg.trials = 5;
ECdata_0700{iSub}=ft_selectdata(cfg,repdataEC{iSub});
end

cfg=[];
cfg.trials = 1;
ECdata_2300{1,43}=ft_selectdata(cfg,repdataEC{1,43});
ECdata_2300{1,44}=ft_selectdata(cfg,repdataEC{1,44});
cfg.trials = 2;
ECdata_0300{1,44}=ft_selectdata(cfg,repdataEC{1,44});
cfg.trials =3;
ECdata_0500{1,44}=ft_selectdata(cfg,repdataEC{1,44});
cfg.trials =4;
ECdata_0700{1,44}=ft_selectdata(cfg,repdataEC{1,44});

for iSub=45:47
cfg=[];
cfg.trials = 1;
ECdata_2300{iSub}=ft_selectdata(cfg,repdataEC{iSub});
cfg.trials = 2;
ECdata_2300{iSub}=ft_selectdata(cfg,repdataEC{iSub});
cfg.trials = 3;
ECdata_0300{iSub}=ft_selectdata(cfg,repdataEC{iSub});
cfg.trials = 4;
ECdata_0500{iSub}=ft_selectdata(cfg,repdataEC{iSub});
cfg.trials = 5;
ECdata_0700{iSub}=ft_selectdata(cfg,repdataEC{iSub});
end
%% REDEFINE TRIALS TO 3s/windows
ECdata2300_3s=cell(1,47);
ECdata0100_3s=cell(1,47);
ECdata0300_3s=cell(1,47);
ECdata0500_3s=cell(1,47);
ECdata0700_3s=cell(1,47);

for iSub=1:42
cfg=[];
cfg.length=3;
ECdata2300_3s{iSub}=ft_redefinetrial(cfg,ECdata_0100{iSub});
ECdata0100_3s{iSub}=ft_redefinetrial(cfg,ECdata_0100{iSub});
ECdata0300_3s{iSub}=ft_redefinetrial(cfg,ECdata_0300{iSub});
ECdata0500_3s{iSub}=ft_redefinetrial(cfg,ECdata_0500{iSub});
ECdata0700_3s{iSub}=ft_redefinetrial(cfg,ECdata_0700{iSub});
end

cfg=[];
cfg.length=3;
ECdata2300_3s{1,43}=ft_redefinetrial(cfg,ECdata_0100{1,43});
ECdata0100_3s{1,44}=ft_redefinetrial(cfg,ECdata_0100{1,44});
ECdata0300_3s{1,44}=ft_redefinetrial(cfg,ECdata_0300{1,44});
ECdata0500_3s{1,44}=ft_redefinetrial(cfg,ECdata_0500{1,44});
ECdata0700_3s{1,44}=ft_redefinetrial(cfg,ECdata_0700{1,44});

for iSub=45:47
cfg=[];
cfg.length=3;
ECdata2300_3s{41}=ft_redefinetrial(cfg,ECdata_2300{41});
ECdata0100_3s{iSub}=ft_redefinetrial(cfg,ECdata_0100{iSub});
ECdata0300_3s{iSub}=ft_redefinetrial(cfg,ECdata_0300{iSub});
ECdata0500_3s{iSub}=ft_redefinetrial(cfg,ECdata_0500{iSub});
ECdata0700_3s{iSub}=ft_redefinetrial(cfg,ECdata_0700{iSub});
end

%%
    %% DATA BROWSER for TRIAL-REJECTION
    cfg=[];
    cfg.viewmode = 'vertical';
    cfg.ylim = [-25 25];%change for artifact/sleep detection
    cfg.continuous = 'yes';
    cfg.channel = {'O1','O2','C3','C4','Fp1','Fp2', 'F3','Fz','Cz' 'F4','E*'};
    cfg.blocksize = 30;
ECrmv_0700{1,44}=ft_databrowser(cfg, ECdata0700_3s{1,44});

%% REJECT TRIALS THAT WERE VISUALLY DETERMINED
for iSub=1:42
cfg=[];
cfg.artfctdef.reject='complete';
cfg.artfctdef.visual.artifact = ECrmv_2300{iSub}.artfctdef.visual.artifact;
EC23_clean{iSub}= ft_rejectartifact(cfg, ECdata2300_3s{iSub});
end
cfg=[];   
cfg.artfctdef.visual.artifact = ECrmv_2300{1,43}.artfctdef.visual.artifact;
EC23_clean{1,43}=ft_rejectartifact(cfg, ECdata2300_3s{1,43});
for iSub=42:43
    cfg=[];
cfg.artfctdef.reject='complete';
cfg.artfctdef.visual.artifact = ECrmv_2300{iSub}.artfctdef.visual.artifact;
EC23_clean{iSub}= ft_rejectartifact(cfg, ECdata2300_3s{iSub});
end
for iSub=45:47
cfg=[];
cfg.artfctdef.reject='complete';
cfg.artfctdef.visual.artifact = ECrmv_2300{iSub}.artfctdef.visual.artifact;
EC23_clean{iSub}= ft_rejectartifact(cfg, ECdata2300_3s{iSub});
end

for iSub=1:42
cfg.artfctdef.visual.artifact = ECrmv_0100{iSub}.artfctdef.visual.artifact;
EC01_clean{iSub}= ft_rejectartifact(cfg, ECdata0100_3s{iSub});
end
cfg.artfctdef.visual.artifact = ECrmv_0100{1,44}.artfctdef.visual.artifact;
EC01_clean{1,43}=ft_rejectartifact(cfg, ECdata0100_3s{1,44});
for iSub=45:47
cfg.artfctdef.visual.artifact = ECrmv_0100{iSub}.artfctdef.visual.artifact;
EC01_clean{iSub}= ft_rejectartifact(cfg, ECdata0100_3s{iSub});
end
for iSub=1:42
cfg.artfctdef.visual.artifact = ECrmv_0300{iSub}.artfctdef.visual.artifact;
EC03_clean{iSub} = ft_rejectartifact(cfg,ECdata0300_3s{iSub})
end
cfg.artfctdef.visual.artifact = ECrmv_0300{1,44}.artfctdef.visual.artifact;
EC03_clean{1,43}=ft_rejectartifact(cfg, ECdata0300_3s{1,44});
for iSub=45:47
cfg.artfctdef.visual.artifact = ECrmv_0300{iSub}.artfctdef.visual.artifact;
EC03_clean{iSub} = ft_rejectartifact(cfg,ECdata0300_3s{iSub});
end

for iSub=37:42
cfg.artfctdef.visual.artifact = ECrmv_0500{iSub}.artfctdef.visual.artifact;
EC05_clean{iSub} = ft_rejectartifact(cfg,ECdata0500_3s{iSub});
end
cfg.artfctdef.visual.artifact = ECrmv_0500{1,44}.artfctdef.visual.artifact;
EC05_clean{1,43}=ft_rejectartifact(cfg, ECdata0500_3s{1,44});
for iSub=45:47
cfg.artfctdef.visual.artifact = ECrmv_0500{iSub}.artfctdef.visual.artifact;
EC05_clean{iSub} = ft_rejectartifact(cfg,ECdata0500_3s{iSub});
end

for iSub=1:42
cfg.artfctdef.visual.artifact = ECrmv_0700{iSub}.artfctdef.visual.artifact;
EC07_clean{iSub} = ft_rejectartifact(cfg,ECdata0700_3s{iSub});
end
cfg.artfctdef.visual.artifact = ECrmv_0700{41}.artfctdef.visual.artifact;
EC07_clean{41} = ft_rejectartifact(cfg,ECdata0700_3s{41});
cfg.artfctdef.visual.artifact = ECrmv_0500{1,44}.artfctdef.visual.artifact;
EC07_clean{1,43}=ft_rejectartifact(cfg, ECdata0700_3s{1,44});
for iSub=45:47
cfg.artfctdef.visual.artifact = ECrmv_0700{iSub}.artfctdef.visual.artifact;
EC07_clean{iSub} = ft_rejectartifact(cfg,ECdata0700_3s{iSub});
end
for iSub=45:47
cfg=[];
cfg.artfctdef.reject='complete';
cfg.artfctdef.visual.artifact = ECrmv_2300{iSub}.artfctdef.visual.artifact;
EC23_clean{iSub}= ft_rejectartifact(cfg, ECdata2300_3s{iSub});
cfg.artfctdef.visual.artifact = ECrmv_0100{iSub}.artfctdef.visual.artifact;
EC01_clean{iSub}= ft_rejectartifact(cfg, ECdata0100_3s{iSub});
cfg.artfctdef.visual.artifact = ECrmv_0300{iSub}.artfctdef.visual.artifact;
EC03_clean{iSub} = ft_rejectartifact(cfg,ECdata0300_3s{iSub});
cfg.artfctdef.visual.artifact = ECrmv_0500{iSub}.artfctdef.visual.artifact;
EC05_clean{iSub} = ft_rejectartifact(cfg,ECdata0500_3s{iSub});
cfg.artfctdef.visual.artifact = ECrmv_0700{iSub}.artfctdef.visual.artifact;
EC07_clean{iSub} = ft_rejectartifact(cfg,ECdata0700_3s{iSub});
end
%% SELECT RELEVANT CHANNELS ONLY
for iSub=1:45
cfg=[];
cfg.channel={'O1','O2','C3','C4','Cz','Fz','F3','F4'};
EC23_clean{iSub}=ft_selectdata(cfg,EC23_clean{iSub});
end
for iSub=1:45
EC01_clean{iSub}=ft_selectdata(cfg,EC01_clean{iSub});
end
for iSub=1:46
EC03_clean{iSub}=ft_selectdata(cfg,EC03_clean{iSub});
end
for iSub=1:43
EC05_clean{iSub}=ft_selectdata(cfg,EC05_clean{iSub});
end
for iSub=1:40
EC07_clean{iSub}=ft_selectdata(cfg,EC07_clean{iSub});
end
%% REJECT VISUAL CHANNELS
for iSub=1:43
cfg = [];
cfg.method = 'trial';
%cfg.trials=~ECrmv_2300{iSub}.artfctdef.visual.artifact;
EC07_cl{iSub} = ft_rejectvisual(cfg, EC07_clean{iSub});
fprintf('.... analyse sub %d', iSub);
end;

for iSub=1:45
cfg = [];
cfg.method = 'channel';
%cfg.trials=~ECrmv_2300{iSub}.artfctdef.visual.artifact;
EC23_cl{iSub} = ft_rejectvisual(cfg, EC23_clean{iSub});
fprintf('.... analyse sub %d', iSub);
end;
%% Fix missing channels
load('C:\Users\shebu516\Documents\wakeEEG\METSLEEP_topo.mat')
for iSub=find(~cellfun(@isempty,EC23_cl)); %Change for each time 
[notmissing, dummy] = match_str(EC23_cl{1,35}.label, EC23_cl{iSub}.label);
newtrial = cell(size(EC23_cl{iSub}.trial));
for k = 1:numel(EC23_cl{iSub}.trial)
newtrial{k} = zeros(numel(EC23_cl{1,35}.label), size(EC23_cl{iSub}.trial{k},2));
newtrial{k}(notmissing,:) = EC23_cl{iSub}.trial{k};
end
goodchans   = false(numel(EC23_cl{1,35}.label),1);
goodchans(notmissing) = true;
badchanindx = find(goodchans==0);
EC23_cl{iSub}.trial = newtrial; clear newtrial;
EC23_cl{iSub}.label = EC23_cl{1,35}.label;
warning('Inserting grad that does not actually belong to this dataset!')
EC23_cl{iSub}.elec  = EC23_cl{1,35}.elec;
cfg =[];
cfg.neighbours =neighbours;
cfg.badchannel    = EC23_cl{iSub}.label(badchanindx);
cfg.layout = lay;
cfg.method ='weighted';
EC23_cl{iSub}=ft_channelrepair(cfg, EC23_cl{iSub});
end

for iSub=find(~cellfun(@isempty,EC01_cl)); %Change for each time 
[notmissing, dummy] = match_str(EC23_cl{1,35}.label, EC01_cl{iSub}.label);
newtrial = cell(size(EC01_cl{iSub}.trial));
for k = 1:numel(EC01_cl{iSub}.trial)
newtrial{k} = zeros(numel(EC23_cl{1,35}.label), size(EC01_cl{iSub}.trial{k},2));
newtrial{k}(notmissing,:) = EC01_cl{iSub}.trial{k};
end
goodchans   = false(numel(EC23_cl{1,35}.label),1);
goodchans(notmissing) = true;
badchanindx = find(goodchans==0);
EC01_cl{iSub}.trial = newtrial; clear newtrial;
EC01_cl{iSub}.label = EC23_cl{1,35}.label;
warning('Inserting grad that does not actually belong to this dataset!')
EC01_cl{iSub}.elec  = EC23_cl{1,35}.elec;
cfg =[];
cfg.neighbours =neighbours;
cfg.badchannel    = EC01_cl{iSub}.label(badchanindx);
cfg.layout = lay;
cfg.method ='weighted';
EC01_cl{iSub}=ft_channelrepair(cfg, EC01_cl{iSub});
end

for iSub=find(~cellfun(@isempty,EC03_cl)); %Change for each time 
[notmissing, dummy] = match_str(EC23_cl{1,35}.label, EC03_cl{iSub}.label);
newtrial = cell(size(EC03_cl{iSub}.trial));
for k = 1:numel(EC03_cl{iSub}.trial)
newtrial{k} = zeros(numel(EC23_cl{1,35}.label), size(EC03_cl{iSub}.trial{k},2));
newtrial{k}(notmissing,:) = EC03_cl{iSub}.trial{k};
end
goodchans   = false(numel(EC23_cl{1,35}.label),1);
goodchans(notmissing) = true;
badchanindx = find(goodchans==0);
EC03_cl{iSub}.trial = newtrial; clear newtrial;
EC03_cl{iSub}.label = EC23_cl{1,35}.label;
warning('Inserting grad that does not actually belong to this dataset!')
EC03_cl{iSub}.elec  = EC23_cl{1,35}.elec;
cfg =[];
cfg.neighbours =neighbours;
cfg.badchannel    = EC03_cl{iSub}.label(badchanindx);
cfg.layout = lay;
cfg.method ='weighted';
EC03_cl{iSub}=ft_channelrepair(cfg, EC03_cl{iSub});
end

for iSub=find(~cellfun(@isempty,EC05_cl)); %Change for each time 
[notmissing, dummy] = match_str(EC23_cl{1,35}.label, EC05_cl{iSub}.label);
newtrial = cell(size(EC05_cl{iSub}.trial));
for k = 1:numel(EC05_cl{iSub}.trial)
newtrial{k} = zeros(numel(EC23_cl{1,35}.label), size(EC05_cl{iSub}.trial{k},2));
newtrial{k}(notmissing,:) = EC05_cl{iSub}.trial{k};
end
goodchans   = false(numel(EC23_cl{1,35}.label),1);
goodchans(notmissing) = true;
badchanindx = find(goodchans==0);
EC05_cl{iSub}.trial = newtrial; clear newtrial;
EC05_cl{iSub}.label = EC23_cl{1,35}.label;
warning('Inserting grad that does not actually belong to this dataset!')
EC05_cl{iSub}.elec  = EC23_cl{1,35}.elec;
cfg =[];
cfg.neighbours =neighbours;
cfg.badchannel    = EC05_cl{iSub}.label(badchanindx);
cfg.layout = lay;
cfg.method ='weighted';
EC05_cl{iSub}=ft_channelrepair(cfg, EC05_cl{iSub});
end

for iSub=find(~cellfun(@isempty,EC07_cl)); %Change for each time 
[notmissing, dummy] = match_str(EC23_cl{1,35}.label, EC07_cl{iSub}.label);
newtrial = cell(size(EC07_cl{iSub}.trial));
for k = 1:numel(EC07_cl{iSub}.trial)
newtrial{k} = zeros(numel(EC23_cl{1,35}.label), size(EC07_cl{iSub}.trial{k},2));
newtrial{k}(notmissing,:) = EC07_cl{iSub}.trial{k};
end
goodchans   = false(numel(EC23_cl{1,35}.label),1);
goodchans(notmissing) = true;
badchanindx = find(goodchans==0);
EC07_cl{iSub}.trial = newtrial; clear newtrial;
EC07_cl{iSub}.label = EC23_cl{1,35}.label;
warning('Inserting grad that does not actually belong to this dataset!')
EC07_cl{iSub}.elec  = EC23_cl{1,35}.elec;
cfg =[];
cfg.neighbours =neighbours;
cfg.badchannel    = EC07_cl{iSub}.label(badchanindx);
cfg.layout = lay;
cfg.method ='weighted';
EC07_cl{iSub}=ft_channelrepair(cfg, EC07_cl{iSub});
end

%% BROWSE CLEANED DATA ...
cfg=[];
cfg.viewmode = 'vertical';
cfg.continuous = 'yes';
cfg.blocksize = 30;
cfg.ylim = [-25 25];%change for artifact/sleep detection
a=ft_databrowser(cfg, EC05_cl{25});
hold on;
set(gcf,'WindowState','Maximized');
%% REDFINE 3s w/ 33% overlap
cfg=[];
cfg.length=3;
cfg.overlap = 0.33;
for iSub=find(~cellfun(@isempty,EC23_cl)) %exclude empty cells
EC23ovlp{iSub}=ft_redefinetrial(cfg,EC23_cl{iSub});
end
for iSub=find(~cellfun(@isempty,EC01_cl))
EC01ovlp{iSub}=ft_redefinetrial(cfg,EC01_cl{iSub});
end
for iSub=find(~cellfun(@isempty,EC03_cl))
EC03ovlp{iSub}=ft_redefinetrial(cfg,EC03_cl{iSub});
end
for iSub=find(~cellfun(@isempty,EC05_cl))
EC05ovlp{iSub}=ft_redefinetrial(cfg,EC05_cl{iSub});
end
for iSub=find(~cellfun(@isempty,EC07_cl))
EC07ovlp{iSub}=ft_redefinetrial(cfg,EC07_cl{iSub});
end
%% Power Spectral Analysis Hanning 
cfg=[];
cfg.method = 'mtmfft';
cfg.keeptrials = 'yes';                            
cfg.output      = 'pow';
cfg.taper = 'hanning';
cfg.foi = 0.5:(1/5):30;
cfg.tapsmofrq = 0;
cfg.pad     = 'nextpow2';
for iSub=find(~cellfun(@isempty,EC23ovlp)); %exclude empty cells
EC23_PSD{iSub}=ft_freqanalysis(cfg, EC23ovlp{iSub});
EC23_PSD{iSub}.powspctrm=smoothdata(EC23_PSD{iSub}.powspctrm,3,'movmean',3);
end
for iSub=find(~cellfun(@isempty,EC01_cl));
EC01_PSD{iSub}=ft_freqanalysis(cfg, EC01ovlp{iSub});
EC01_PSD{iSub}.powspctrm=smoothdata(EC01_PSD{iSub}.powspctrm,3,'movmean',3);
end
for iSub=find(~cellfun(@isempty,EC03ovlp));
EC03_PSD{iSub}=ft_freqanalysis(cfg, EC03ovlp{iSub});
EC03_PSD{iSub}.powspctrm=smoothdata(EC03_PSD{iSub}.powspctrm,3,'movmean',3);
end
for iSub=find(~cellfun(@isempty,EC05ovlp));
EC05_PSD{iSub}=ft_freqanalysis(cfg, EC05ovlp{iSub});
EC05_PSD{iSub}.powspctrm=smoothdata(EC05_PSD{iSub}.powspctrm,3,'movmean',3);
end
for iSub=find(~cellfun(@isempty,EC07ovlp));
EC07_PSD{iSub}=ft_freqanalysis(cfg, EC07ovlp{iSub});
EC07_PSD{iSub}.powspctrm=smoothdata(EC07_PSD{iSub}.powspctrm,3,'movmean',3);
end
%% AVERAGE PSD OVER ALL PARTICIPANTS
for iSub=find(~cellfun(@isempty,EC23_PSD));
cfg =[];
cfg.variance ='yes'
EC23_PSDavg{iSub}=ft_freqdescriptives(cfg, EC23_PSD{iSub});
end
for iSub=find(~cellfun(@isempty,EC01_PSD));
cfg.variance ='yes'
EC01_PSDavg{iSub}=ft_freqdescriptives(cfg, EC01_PSD{iSub});
end;
for iSub=find(~cellfun(@isempty,EC03_PSD));
cfg.variance ='yes'
EC03_PSDavg{iSub}=ft_freqdescriptives(cfg, EC03_PSD{iSub});
end;
for iSub=find(~cellfun(@isempty,EC05_PSD));
cfg.variance ='yes'
EC05_PSDavg{iSub}=ft_freqdescriptives(cfg, EC05_PSD{iSub});
end;
for iSub=find(~cellfun(@isempty,EC07_PSD));
cfg.variance ='yes'
EC07_PSDavg{iSub}=ft_freqdescriptives(cfg, EC07_PSD{iSub});
end;
%% AVERAGE PSD PER PARTICIPANT
% Calculate Power Spectra Power Participant for each frequency bin
for iSub=find(~cellfun(@isempty,EC23_PSDavg))
cfg=[];
cfg.frequency = [8 12];
tmp{iSub}=ft_selectdata(cfg,EC23_PSDavg{iSub});
EC23_PSDavg{iSub}.powspctrm_la=tmp{iSub}.powspctrm;
cfg.frequency = [10 12];
tmp{iSub}=ft_selectdata(cfg,EC23_PSDavg{iSub});
EC23_PSDavg{iSub}.powspctrm_ha=tmp{iSub}.powspctrm;

cfg.frequency = [12 30];
tmp{iSub}=ft_selectdata(cfg,EC23_PSDavg{iSub});
EC23_PSDavg{iSub}.powspctrm_b=tmp{iSub}.powspctrm;
cfg.frequency = [0.5 4];
tmp{iSub}=ft_selectdata(cfg,EC23_PSDavg{iSub});
EC23_PSDavg{iSub}.powspctrm_d=tmp{iSub}.powspctrm;
cfg.frequency = [4 8];
tmp{iSub}=ft_selectdata(cfg,EC23_PSDavg{iSub});
EC23_PSDavg{iSub}.powspctrm_t=tmp{iSub}.powspctrm;
end
% m-prefix =mean
clear tmp
for iSub=find(~cellfun(@isempty,EC01_PSDavg))
cfg=[];
cfg.frequency = [8 10];
tmp{iSub}=ft_selectdata(cfg,EC01_PSDavg{iSub});
EC01_PSDavg{iSub}.powspctrm_la=tmp{iSub}.powspctrm;

cfg.frequency = [10 12];
tmp{iSub}=ft_selectdata(cfg,EC01_PSDavg{iSub});
EC01_PSDavg{iSub}.powspctrm_ha=tmp{iSub}.powspctrm;

cfg.frequency = [12 30];
tmp{iSub}=ft_selectdata(cfg,EC01_PSDavg{iSub});
EC01_PSDavg{iSub}.powspctrm_b=tmp{iSub}.powspctrm;
cfg.frequency = [0.5 4];
tmp{iSub}=ft_selectdata(cfg,EC01_PSDavg{iSub});
EC01_PSDavg{iSub}.powspctrm_d=tmp{iSub}.powspctrm;
cfg.frequency = [4 8];
tmp{iSub}=ft_selectdata(cfg,EC01_PSDavg{iSub});
EC01_PSDavg{iSub}.powspctrm_t=tmp{iSub}.powspctrm;
end
clear tmp
for iSub=find(~cellfun(@isempty,EC03_PSDavg));
cfg=[];
cfg.frequency = [8 12];
tmp{iSub}=ft_selectdata(cfg,EC03_PSDavg{iSub});
EC03_PSDavg{iSub}.powspctrm_la=tmp{iSub}.powspctrm;
cfg.frequency = [10 12];
tmp{iSub}=ft_selectdata(cfg,EC03_PSDavg{iSub});
EC03_PSDavg{iSub}.powspctrm_ha=tmp{iSub}.powspctrm;
cfg.frequency = [12 30];
tmp{iSub}=ft_selectdata(cfg,EC03_PSDavg{iSub});
EC03_PSDavg{iSub}.powspctrm_b=tmp{iSub}.powspctrm;
cfg.frequency = [0.5 4];
tmp{iSub}=ft_selectdata(cfg,EC03_PSDavg{iSub});
EC03_PSDavg{iSub}.powspctrm_d=tmp{iSub}.powspctrm;
cfg.frequency = [4 8];
tmp{iSub}=ft_selectdata(cfg,EC03_PSDavg{iSub});
EC03_PSDavg{iSub}.powspctrm_t=tmp{iSub}.powspctrm;
end
clear tmp
for iSub=find(~cellfun(@isempty,EC05_PSDavg));
cfg=[];
cfg.frequency = [8 12];
tmp{iSub}=ft_selectdata(cfg,EC05_PSDavg{iSub});
EC05_PSDavg{iSub}.powspctrm_la=tmp{iSub}.powspctrm;
cfg.frequency = [10 12];
tmp{iSub}=ft_selectdata(cfg,EC05_PSDavg{iSub});
EC05_PSDavg{iSub}.powspctrm_ha=tmp{iSub}.powspctrm;
cfg.frequency = [12 30];
tmp{iSub}=ft_selectdata(cfg,EC05_PSDavg{iSub});
EC05_PSDavg{iSub}.powspctrm_b=tmp{iSub}.powspctrm;
cfg.frequency = [0.5 4];
tmp{iSub}=ft_selectdata(cfg,EC05_PSDavg{iSub});
EC05_PSDavg{iSub}.powspctrm_d=tmp{iSub}.powspctrm;
cfg.frequency = [4 8];
tmp{iSub}=ft_selectdata(cfg,EC05_PSDavg{iSub});
EC05_PSDavg{iSub}.powspctrm_t=tmp{iSub}.powspctrm;
end
clear tmp
for iSub=find(~cellfun(@isempty,EC07_PSDavg));
cfg=[];
cfg.frequency = [8 12];
tmp{iSub}=ft_selectdata(cfg,EC07_PSDavg{iSub});
EC07_PSDavg{iSub}.powspctrm_la=tmp{iSub}.powspctrm;
cfg.frequency = [10 12];
tmp{iSub}=ft_selectdata(cfg,EC07_PSDavg{iSub});
EC07_PSDavg{iSub}.powspctrm_ha=tmp{iSub}.powspctrm;

tmp{iSub}=ft_selectdata(cfg,EC07_PSDavg{iSub});
EC07_PSDavg{iSub}.powspctrm_b=tmp{iSub}.powspctrm;
cfg.frequency = [0.5 4];
tmp{iSub}=ft_selectdata(cfg,EC07_PSDavg{iSub});
EC07_PSDavg{iSub}.powspctrm_d=tmp{iSub}.powspctrm;
cfg.frequency = [4 8];
tmp{iSub}=ft_selectdata(cfg,EC07_PSDavg{iSub});
EC07_PSDavg{iSub}.powspctrm_t=tmp{iSub}.powspctrm;
end 
%% Extract mean freq pow per participant
for iSub=find(~cellfun(@isempty,EC23_PSDavg));
mean_lowalpha(1,iSub)=mean(EC23_PSDavg{iSub}.powspctrm_la,[1 2]);
mean_highalpha(1,iSub)=mean(EC23_PSDavg{iSub}.powspctrm_ha, [1 2]);
mean_beta(1,iSub)=mean(EC23_PSDavg{iSub}.powspctrm_b,[1 2]);
mean_delta(1,iSub)=mean(EC23_PSDavg{iSub}.powspctrm_d,[1 2]);
mean_theta(1,iSub)=mean(EC23_PSDavg{iSub}.powspctrm_t,[1 2]);
end

for iSub=find(~cellfun(@isempty,EC01_PSDavg));
mean_lowalpha(2,iSub)=mean(EC01_PSDavg{iSub}.powspctrm_la,[1 2]);
mean_highalpha(2,iSub)=mean(EC01_PSDavg{iSub}.powspctrm_ha, [1 2]);
mean_beta(2,iSub)=mean(EC01_PSDavg{iSub}.powspctrm_b,[1 2]);
mean_delta(2,iSub)=mean(EC01_PSDavg{iSub}.powspctrm_d,[1 2]);
mean_theta(2,iSub)=mean(EC01_PSDavg{iSub}.powspctrm_t,[1 2]);
end

for iSub=find(~cellfun(@isempty,EC03_PSDavg));
mean_lowalpha(3,iSub)=mean(EC03_PSDavg{iSub}.powspctrm_la,[1 2]);
mean_highalpha(3,iSub)=mean(EC03_PSDavg{iSub}.powspctrm_ha, [1 2]);
mean_beta(3,iSub)=mean(EC03_PSDavg{iSub}.powspctrm_b,[1 2]);
mean_delta(3,iSub)=mean(EC03_PSDavg{iSub}.powspctrm_d,[1 2]);
mean_theta(3,iSub)=mean(EC03_PSDavg{iSub}.powspctrm_t,[1 2]);
end

for iSub=find(~cellfun(@isempty,EC05_PSDavg));
mean_lowalpha(4,iSub)=mean(EC05_PSDavg{iSub}.powspctrm_la,[1 2]);
mean_highalpha(4,iSub)=mean(EC05_PSDavg{iSub}.powspctrm_ha, [1 2]);
mean_beta(4,iSub)=mean(EC05_PSDavg{iSub}.powspctrm_b,[1 2]);
mean_delta(4,iSub)=mean(EC05_PSDavg{iSub}.powspctrm_d,[1 2]);
mean_theta(4,iSub)=mean(EC05_PSDavg{iSub}.powspctrm_t,[1 2]);
end

for iSub=find(~cellfun(@isempty,EC07_PSDavg));
mean_lowalpha(5,iSub)=mean(EC07_PSDavg{iSub}.powspctrm_la,[1 2]);
mean_highalpha(5,iSub)=mean(EC07_PSDavg{iSub}.powspctrm_ha, [1 2]);
mean_beta(5,iSub)=mean(EC07_PSDavg{iSub}.powspctrm_b,[1 2]);
mean_delta(5,iSub)=mean(EC07_PSDavg{iSub}.powspctrm_d,[1 2]);
mean_theta(5,iSub)=mean(EC07_PSDavg{iSub}.powspctrm_t,[1 2]);
end

mean_lowalpha(mean_highalpha == 0)=NaN;
mean_highalpha(mean_highalpha == 0)=NaN;
mean_beta(mean_beta == 0)=NaN;
mean_delta(mean_delta == 0)=NaN;
mean_theta(mean_theta == 0)=NaN;


writematrix(mean_lowalpha','mean_lowalpha.xlsx')
writematrix(mean_highalpha','mean_highalpha.xlsx')
writematrix(mean_beta','mean_beta.xlsx')
writematrix(mean_delta','mean_delta.xlsx')
writematrix(mean_theta','mean_theta.xlsx')

%% PLOTTING 
stdev23=std(EC23_PSDgrd.powspctrm,0,[1]);stdev07=std(EC07_PSDgrd.powspctrm, 0,[1]);
sem23=stdev23/sqrt(45);sem07=stdev07/sqrt(40);
y23_above=mean(EC23_PSDgrd.powspctrm,[1])+sem23;y23_below=mean(EC23_PSDgrd.powspctrm,[1])-sem23;
y07_above=mean(EC07_PSDgrd.powspctrm,[1])+sem07;y07_below=mean(EC07_PSDgrd.powspctrm,[1])-sem23;
cfg =[];
cfg.linewidth =2;
ft_singleplotER(cfg,EC23_PSDgrd, EC07_PSDgrd); 
xlabel('Frequency (Hz)');
ylabel('absolute power (µV^2)');
title('Average Power Spectral Density')
legend('23:00','07:00')
hold on;
facealpha =1;
p23 = [y23_above;flip(y23_below)];
p07= [y07_above;flip(y07_below)];
figure; ft_plot_patch(f, p23,'r')
hold on; ft_plot_patch(f, p07,'b')


PSD_dif=EC07_PSDgrd;
PSD_dif.powspctrm=EC07_PSDgrd.powspctrm - EC23_PSDgrd.powspctrm;
cfg=[]
cfg.frequency = [0.5 4]
PSD_difd=ft_selectdata(cfg,PSD_dif)
cfg.frequency = [4 8]
PSD_dift=ft_selectdata(cfg,PSD_dif)
cfg.frequency =[8 12]
PSD_difa=ft_selectdata(cfg,PSD_dif)
cfg.frequency =[12 30]
PSD_difb=ft_selectdata(cfg,PSD_dif)

cfg = [];
cfg.layout = lay;
cfg.colorbar     = 'SouthOutside';
cfg.zlim = [-0.5 0.5];
cfg.marker = 'on';
cfg.markersymbol ='.';
cfg.markersize = 8;
cfg.comment = 'no';
figure;subplot(1,5,1); ft_topoplotER(cfg, PSD_difd); title('Delta (1-4 Hz)');
ft_hastoolbox('brewermap', 1);         % ensure this toolbox is on the path
colormap(flipud(brewermap(64,'RdBu'))) % change the colormap
cfg.zlim = [-0.6 0.6];
subplot(1,5,2); ft_topoplotER(cfg, PSD_dift); title('Theta (4-8 Hz)');
ft_hastoolbox('brewermap', 1);         % ensure this toolbox is on the path
colormap(flipud(brewermap(64,'RdBu'))) % change the colormap
cfg.zlim = [-1.3 1.3];
subplot(1,5,3); ft_topoplotER(cfg, PSD_difa); title('Alpha (8-12 Hz)');
ft_hastoolbox('brewermap', 1);         % ensure this toolbox is on the path
colormap(flipud(brewermap(64,'RdBu'))) % change the colormap
cfg.zlim = [-0.03 0.03];
subplot(1,5,4); ft_topoplotER(cfg, PSD_difb); title('Beta (12-20 Hz)');
ft_hastoolbox('brewermap', 1);         % ensure this toolbox is on the path
colormap(flipud(brewermap(64,'RdBu'))) % change the colormap

xlabel('Frequency (Hz)');
ylabel('normalized power (µV^2)');
title('Scalp distribution of spectral power difference (07:00 - 23:00)')

figure;boxplot(ya(1,:))


%% Plotting
figure;
for iSub=find(~cellfun(@isempty,EC23_PSDavg))
plot(EC23_PSDavg{1}.freq,EC23_PSDavg{iSub}.powspctrm)
hold on
end
figure;
for iSub=find(~cellfun(@isempty,EC01_PSDavg))
plot(EC01_PSDavg{1}.freq,EC01_PSDavg{iSub}.powspctrm)    
hold on
end
figure;
for iSub=find(~cellfun(@isempty,EC03_PSDavg))
plot(EC03_PSDavg{1}.freq,EC03_PSDavg{iSub}.powspctrm)    
hold on
end
figure;
for iSub=find(~cellfun(@isempty,EC05_PSDavg))
plot(EC05_PSDavg{1}.freq,EC05_PSDavg{iSub}.powspctrm)    
hold on
end
figure;
for iSub=find(~cellfun(@isempty,EC07_PSDavg))
plot(EC07_PSDavg{1}.freq,EC07_PSDavg{iSub}.powspctrm)    
hold on
end


%% Plotting Grandaverage PSDs with SEM 
% finally, single subject lines colored by group and error bars (SEM) and stat differences
fh = figure;


mp1 = mean(PSD_SVLD2.powspctrm,[1 2]);
var1 = var(mean(PSD_SVLD2.powspctrm,2));
var1 = squeeze(var1)
n1 = 112;
sem1 = sqrt(var1)./sqrt(n1);
mp1=squeeze(mp1)
mp2 = mean(PSD_notLD2.powspctrm,[1 2]);
mp2=squeeze(mp2)
var2 = var(mean(PSD_notLD2.powspctrm,2));
var2=squeeze(var2)
n1 = 112;
sem2 = sqrt(var2)./sqrt(n1);
figure;
ft_plot_line(psd23_grd.freq,mean(psd23_grd.powspctrm, [1]),'color','b',[0.5 0.5 1],'linewidth',1.5);
hold on
ft_plot_line(psd23_grd.freq,mean(psd01_grd.powspctrm, [1]),'color','r',[1 0.5 0.5],'linewidth',1.5);


x = [psd23_grd.freq flip(psd23_grd.freq)];
facealpha = 0.2;

y23_above = mean(psd23_grd.powspctrm, [1]) + mean(psd23_sem.powspctrmsem,[1]);
y23_below = mean(psd23_grd.powspctrm, [1]) - mean(psd23_sem.powspctrmsem,[1]);
y23_patch = [y23_above flip(y23_below)];
y01_above = mean(psd01_grd.powspctrm, [1]) + mean(psd01_sem.powspctrmsem,[1]);
y01_below = mean(psd01_grd.powspctrm, [1]) - mean(psd01_sem.powspctrmsem,[1]);
y01_patch = [y01_above flip(y01_below)];
y03_above = mean(psd03_grd.powspctrm, [1]) + mean(psd03_sem.powspctrmsem,[1]);
y03_below = mean(psd03_grd.powspctrm, [1]) - mean(psd03_sem.powspctrmsem,[1]);
y03_patch = [y03_above flip(y03_below)];
y05_above = mean(psd05_grd.powspctrm, [1]) + mean(psd05_sem.powspctrmsem,[1]);
y05_below = mean(psd05_grd.powspctrm, [1]) - mean(psd05_sem.powspctrmsem,[1]);
y05_patch = [y05_above flip(y05_below)];
y07_above = mean(psd07_grd.powspctrm, [1]) + mean(psd07_sem.powspctrmsem,[1]);
y07_below = mean(psd07_grd.powspctrm, [1]) - mean(psd07_sem.powspctrmsem,[1]);
y07_patch = [y07_above flip(y07_below)];

ft_plot_patch(x, y23_patch,'facecolor',[0 0.4470 0.7410],'facealpha',facealpha);hold on;
ft_plot_patch(x, y01_patch,'facecolor',[0.8500 0.3250 0.0980],'facealpha',facealpha)
ft_plot_patch(x, y03_patch,'facecolor',[0.9290 0.6940 0.1250],'facealpha',facealpha)
ft_plot_patch(x, y05_patch,'facecolor',[0.4940 0.1840 0.5560],'facealpha',facealpha)
ft_plot_patch(x, y07_patch,'facecolor',[0.4660 0.6740 0.1880],'facealpha',facealpha)

p1=ft_plot_line(psd23_grd.freq, mean(psd23_grd.powspctrm, [1]),'color',[0 0.4470 0.7410],'linewidth',2);
p2=ft_plot_line(psd01_grd.freq, mean(psd01_grd.powspctrm, [1]),'color',[0.8500 0.3250 0.0980],'linewidth',2);
p3=ft_plot_line(psd03_grd.freq, mean(psd03_grd.powspctrm, [1]),'color',[0.9290 0.6940 0.1250],'linewidth',2);
p4=ft_plot_line(psd05_grd.freq, mean(psd05_grd.powspctrm, [1]),'color',[0.4940 0.1840 0.5560],'linewidth',2);
p5=ft_plot_line(psd07_grd.freq, mean(psd07_grd.powspctrm, [1]),'color',[0.4660 0.6740 0.1880],'linewidth',2);
legend([p1 p2 p3 p4 p5],{'23:00','01:00','03:00','05:00','07;00'})
xlim([1 30])
title('Spectral Density')
ylabel('Absolute power (µV^2)')
xlabel('Frequency (Hz)')
%% OSCI POW PLOT
y23_above = mean(osci23_grd.powspctrm, [1]) + mean(osci23_sem.powspctrmsem,[1]);
y23_below = mean(osci23_grd.powspctrm, [1]) - mean(osci23_sem.powspctrmsem,[1]);
y23_patch = [y23_above flip(y23_below)];
y01_above = mean(osci01_grd.powspctrm, [1]) + mean(osci01_sem.powspctrmsem,[1]);
y01_below = mean(osci01_grd.powspctrm, [1]) - mean(osci01_sem.powspctrmsem,[1]);
y01_patch = [y01_above flip(y01_below)];
y03_above = mean(osci03_grd.powspctrm, [1]) + mean(osci03_sem.powspctrmsem,[1]);
y03_below = mean(osci03_grd.powspctrm, [1]) - mean(osci03_sem.powspctrmsem,[1]);
y03_patch = [y03_above flip(y03_below)];
y05_above = mean(osci05_grd.powspctrm, [1]) + mean(osci05_sem.powspctrmsem,[1]);
y05_below = mean(osci05_grd.powspctrm, [1]) - mean(osci05_sem.powspctrmsem,[1]);
y05_patch = [y05_above flip(y05_below)];
y07_above = mean(osci07_grd.powspctrm, [1]) + mean(osci07_sem.powspctrmsem,[1]);
y07_below = mean(osci07_grd.powspctrm, [1]) - mean(osci07_sem.powspctrmsem,[1]);
y07_patch = [y07_above flip(y07_below)];

ft_plot_patch(x, y23_patch,'facecolor',[0 0.4470 0.7410],'facealpha',facealpha);hold on;
ft_plot_patch(x, y01_patch,'facecolor',[0.8500 0.3250 0.0980],'facealpha',facealpha)
ft_plot_patch(x, y03_patch,'facecolor',[0.9290 0.6940 0.1250],'facealpha',facealpha)
ft_plot_patch(x, y05_patch,'facecolor',[0.4940 0.1840 0.5560],'facealpha',facealpha)
ft_plot_patch(x, y07_patch,'facecolor',[0.4660 0.6740 0.1880],'facealpha',facealpha)

p1=ft_plot_line(osci23_grd.freq, mean(osci23_grd.powspctrm, [1]),'color',[0 0.4470 0.7410],'linewidth',2);
p2=ft_plot_line(osci01_grd.freq, mean(osci01_grd.powspctrm, [1]),'color',[0.8500 0.3250 0.0980],'linewidth',2);
p3=ft_plot_line(osci03_grd.freq, mean(osci03_grd.powspctrm, [1]),'color',[0.9290 0.6940 0.1250],'linewidth',2);
p4=ft_plot_line(osci05_grd.freq, mean(osci05_grd.powspctrm, [1]),'color',[0.4940 0.1840 0.5560],'linewidth',2);
p5=ft_plot_line(osci07_grd.freq, mean(osci07_grd.powspctrm, [1]),'color',[0.4660 0.6740 0.1880],'linewidth',2);
legend([p1 p2 p3 p4 p5],{'23:00','01:00','03:00','05:00','07:00'})
xlim([1 30])
title('Oscillatory Spectral Density')
ylabel('Absolute power (µV^2)')
xlabel('Frequency (Hz)')


%% Grandaverage
cfg =[];
cfg.keepindividual ='no';
cfg.parameter='powspctrm';
psd23_grd=ft_freqgrandaverage(cfg, EC23_PSDavg{find(~cellfun(@isempty,EC23_PSDavg))});
psd01_grd=ft_freqgrandaverage(cfg, EC01_PSDavg{find(~cellfun(@isempty,EC01_PSDavg))});
psd03_grd=ft_freqgrandaverage(cfg, EC03_PSDavg{find(~cellfun(@isempty,EC03_PSDavg))});
psd05_grd=ft_freqgrandaverage(cfg, EC05_PSDavg{find(~cellfun(@isempty,EC05_PSDavg))});
psd07_grd=ft_freqgrandaverage(cfg, EC07_PSDavg{find(~cellfun(@isempty,EC07_PSDavg))});

cfg =[];
cfg.keepindividual ='no';
cfg.parameter='powspctrmsem';
psd23_sem=ft_freqgrandaverage(cfg, EC23_PSDavg{find(~cellfun(@isempty,EC23_PSDavg))});
psd01_sem=ft_freqgrandaverage(cfg, EC01_PSDavg{find(~cellfun(@isempty,EC01_PSDavg))});
psd03_sem=ft_freqgrandaverage(cfg, EC03_PSDavg{find(~cellfun(@isempty,EC03_PSDavg))});
psd05_sem=ft_freqgrandaverage(cfg, EC05_PSDavg{find(~cellfun(@isempty,EC05_PSDavg))});
psd07_sem=ft_freqgrandaverage(cfg, EC07_PSDavg{find(~cellfun(@isempty,EC07_PSDavg))});


   hdat = [1:10 10:-1:1];
   vdat = rand(1,10);
   vdat = [vdat vdat(end:-1:1)+1];
   ft_plot_patch(hdat, vdat)
