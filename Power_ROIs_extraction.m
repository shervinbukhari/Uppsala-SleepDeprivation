%% SCRIPT FOR EXTRACTING PSD/ FREQBAND POWER FOR SPECIFIC ELECTRODE SITES%%
%% TOPOPLOTS 
%Grand average over participants
cfg=[];
cfg.foilim         = [12 20];
psd23_grd=ft_freqgrandaverage(cfg, EC23_PSDavg{find(~cellfun(@isempty,EC23_PSDavg))});
psd01_grd=ft_freqgrandaverage(cfg, EC01_PSDavg{find(~cellfun(@isempty,EC01_PSDavg))});
psd03_grd=ft_freqgrandaverage(cfg, EC03_PSDavg{find(~cellfun(@isempty,EC03_PSDavg))});
psd05_grd=ft_freqgrandaverage(cfg, EC05_PSDavg{find(~cellfun(@isempty,EC05_PSDavg))});
psd07_grd=ft_freqgrandaverage(cfg, EC07_PSDavg{find(~cellfun(@isempty,EC07_PSDavg))});
load('D:\fieldtrip-master\template\layout\easycapM25.mat')
% Alpha Power all time points
figure;
cfg=[];
cfg.layout=lay;
cfg.freq= [8 12];
ft_hastoolbox('brewermap', 1);         % ensure this toolbox is on the path
colormap(flipud(brewermap(64,'RdBu'))) % change the colormap
ft_topoplotER(cfg,psd23_grd)
figure;
ft_topoplotER(cfg,psd01_grd)
ft_hastoolbox('brewermap', 1);         % ensure this toolbox is on the path
colormap(flipud(brewermap(64,'RdBu'))) % change the colormap
figure;
ft_topoplotER(cfg,psd03_grd)
ft_hastoolbox('brewermap', 1);         % ensure this toolbox is on the path
colormap(flipud(brewermap(64,'RdBu'))) % change the colormap
figure;
ft_topoplotER(cfg,psd05_grd)
ft_hastoolbox('brewermap', 1);         % ensure this toolbox is on the path
colormap(flipud(brewermap(64,'RdBu'))) % change the colormap
figure;
ft_topoplotER(cfg,psd07_grd)
ft_hastoolbox('brewermap', 1);         % ensure this toolbox is on the path
colormap(flipud(brewermap(64,'RdBu'))) % change the colormap
%Theta Power all Time points

%Delta Power all time points

%% 
%% AVERAGE PSD PER PARTICIPANT
% Calculate Frequency Band Power for specific elecs
%ALPHA
for iSub=find(~cellfun(@isempty,EC23_PSDavg))
cfg=[];
cfg.channel = {'O1','O2'};
cfg.frequency =[8 10];
tmp{iSub}=ft_selectdata(cfg,EC23_PSDavg{iSub});
EC23_PSDavg{iSub}.powspctrm_la=tmp{iSub}.powspctrm;
cfg.frequency = [10 12];
tmp{iSub}=ft_selectdata(cfg,EC23_PSDavg{iSub});
EC23_PSDavg{iSub}.powspctrm_ha=tmp{iSub}.powspctrm;
cfg.frequency=[8 12];
tmp{iSub}=ft_selectdata(cfg,EC23_PSDavg{iSub});
EC23_PSDavg{iSub}.powspctrm_a=tmp{iSub}.powspctrm
end

for iSub=find(~cellfun(@isempty,EC01_PSDavg))
cfg=[];
cfg.channel = {'O1','O2'};
cfg.frequency =[8 10];
tmp{iSub}=ft_selectdata(cfg,EC01_PSDavg{iSub});
EC01_PSDavg{iSub}.powspctrm_la=tmp{iSub}.powspctrm;
cfg.frequency = [10 12];
tmp{iSub}=ft_selectdata(cfg,EC01_PSDavg{iSub});
EC01_PSDavg{iSub}.powspctrm_ha=tmp{iSub}.powspctrm;
cfg.frequency=[8 12];
tmp{iSub}=ft_selectdata(cfg,EC01_PSDavg{iSub});
EC01_PSDavg{iSub}.powspctrm_a=tmp{iSub}.powspctrm
end

for iSub=find(~cellfun(@isempty,EC03_PSDavg))
cfg=[];
cfg.channel = {'O1','O2'};
cfg.frequency =[8 10];
tmp{iSub}=ft_selectdata(cfg,EC03_PSDavg{iSub});
EC03_PSDavg{iSub}.powspctrm_la=tmp{iSub}.powspctrm;
cfg.frequency = [10 12];
tmp{iSub}=ft_selectdata(cfg,EC03_PSDavg{iSub});
EC03_PSDavg{iSub}.powspctrm_ha=tmp{iSub}.powspctrm;
cfg.frequency=[8 12];
tmp{iSub}=ft_selectdata(cfg,EC03_PSDavg{iSub});
EC03_PSDavg{iSub}.powspctrm_a=tmp{iSub}.powspctrm
end
for iSub=find(~cellfun(@isempty,EC05_PSDavg))
cfg=[];
cfg.channel = {'O1','O2'};
cfg.frequency =[8 10];
tmp{iSub}=ft_selectdata(cfg,EC05_PSDavg{iSub});
EC05_PSDavg{iSub}.powspctrm_la=tmp{iSub}.powspctrm;
cfg.frequency = [10 12];
tmp{iSub}=ft_selectdata(cfg,EC05_PSDavg{iSub});
EC05_PSDavg{iSub}.powspctrm_ha=tmp{iSub}.powspctrm;
cfg.frequency=[8 12];
tmp{iSub}=ft_selectdata(cfg,EC05_PSDavg{iSub});
EC05_PSDavg{iSub}.powspctrm_a=tmp{iSub}.powspctrm
end
for iSub=find(~cellfun(@isempty,EC07_PSDavg))
cfg=[];
cfg.channel = {'O1','O2'};
cfg.frequency =[8 10];
tmp{iSub}=ft_selectdata(cfg,EC07_PSDavg{iSub});
EC07_PSDavg{iSub}.powspctrm_la=tmp{iSub}.powspctrm;
cfg.frequency = [10 12];
tmp{iSub}=ft_selectdata(cfg,EC07_PSDavg{iSub});
EC07_PSDavg{iSub}.powspctrm_ha=tmp{iSub}.powspctrm;
cfg.frequency=[8 12];
tmp{iSub}=ft_selectdata(cfg,EC07_PSDavg{iSub});
EC07_PSDavg{iSub}.powspctrm_a=tmp{iSub}.powspctrm
end

% THETA
for iSub=find(~cellfun(@isempty,EC23_PSDavg))
cfg=[];
cfg.channel = {'Fz','Cz'};
cfg.frequency =[4 8];
tmp{iSub}=ft_selectdata(cfg,EC23_PSDavg{iSub});
EC23_PSDavg{iSub}.powspctrm_t=tmp{iSub}.powspctrm;
end

for iSub=find(~cellfun(@isempty,EC01_PSDavg))
cfg=[];
cfg.channel = {'Fz','Cz'};
cfg.frequency =[4 8];
tmp{iSub}=ft_selectdata(cfg,EC01_PSDavg{iSub});
EC01_PSDavg{iSub}.powspctrm_t=tmp{iSub}.powspctrm;
end

for iSub=find(~cellfun(@isempty,EC03_PSDavg))
cfg=[];
cfg.channel = {'Fz','Cz'};
cfg.frequency =[4 8];
tmp{iSub}=ft_selectdata(cfg,EC03_PSDavg{iSub});
EC03_PSDavg{iSub}.powspctrm_t=tmp{iSub}.powspctrm;
end

for iSub=find(~cellfun(@isempty,EC05_PSDavg))
cfg=[];
cfg.channel = {'Fz','Fz'};
cfg.frequency =[4 8];
tmp{iSub}=ft_selectdata(cfg,EC05_PSDavg{iSub});
EC05_PSDavg{iSub}.powspctrm_t=tmp{iSub}.powspctrm;
end

for iSub=find(~cellfun(@isempty,EC07_PSDavg))
cfg=[];
cfg.channel = {'Fz','Cz'};
cfg.frequency =[4 8];
tmp{iSub}=ft_selectdata(cfg,EC07_PSDavg{iSub});
EC07_PSDavg{iSub}.powspctrm_t=tmp{iSub}.powspctrm;
end

%DELTA
for iSub=find(~cellfun(@isempty,EC23_PSDavg))
cfg=[];
cfg.channel = {'F3','F4','Fz'};
cfg.frequency =[0.5 4];
tmp{iSub}=ft_selectdata(cfg,EC23_PSDavg{iSub});
EC23_PSDavg{iSub}.powspctrm_d=tmp{iSub}.powspctrm;
end

for iSub=find(~cellfun(@isempty,EC01_PSDavg))
cfg=[];
cfg.channel = {'F3','F4','Fz'};
cfg.frequency =[0.5 4];
tmp{iSub}=ft_selectdata(cfg,EC01_PSDavg{iSub});
EC01_PSDavg{iSub}.powspctrm_d=tmp{iSub}.powspctrm;
end

for iSub=find(~cellfun(@isempty,EC03_PSDavg))
cfg=[];
cfg.channel = {'F3','F4','Fz'};
cfg.frequency =[0.5 4];
tmp{iSub}=ft_selectdata(cfg,EC03_PSDavg{iSub});
EC03_PSDavg{iSub}.powspctrm_d=tmp{iSub}.powspctrm;
end

for iSub=find(~cellfun(@isempty,EC05_PSDavg))
cfg=[];
cfg.channel = {'F3','F4','Fz'};
cfg.frequency =[0.5 4];
tmp{iSub}=ft_selectdata(cfg,EC05_PSDavg{iSub});
EC05_PSDavg{iSub}.powspctrm_d=tmp{iSub}.powspctrm;
end

for iSub=find(~cellfun(@isempty,EC07_PSDavg))
cfg=[];
cfg.channel = {'F3','F4','Fz'};
cfg.frequency =[0.5 4];
tmp{iSub}=ft_selectdata(cfg,EC07_PSDavg{iSub});
EC07_PSDavg{iSub}.powspctrm_d=tmp{iSub}.powspctrm;
end
%BETA
for iSub=find(~cellfun(@isempty,EC23_PSDavg))
cfg=[];
cfg.channel = {'C3','C4'};
cfg.frequency =[12 30];
tmp{iSub}=ft_selectdata(cfg,EC23_PSDavg{iSub});
EC23_PSDavg{iSub}.powspctrm_b=tmp{iSub}.powspctrm;
end

for iSub=find(~cellfun(@isempty,EC01_PSDavg))
cfg=[];
cfg.channel = {'C3','C4'};
cfg.frequency =[12 30];
tmp{iSub}=ft_selectdata(cfg,EC01_PSDavg{iSub});
EC01_PSDavg{iSub}.powspctrm_b=tmp{iSub}.powspctrm;
end

for iSub=find(~cellfun(@isempty,EC03_PSDavg))
cfg=[];
cfg.channel = {'C3','C4'};
cfg.frequency =[12 30];
tmp{iSub}=ft_selectdata(cfg,EC03_PSDavg{iSub});
EC03_PSDavg{iSub}.powspctrm_b=tmp{iSub}.powspctrm;
end

for iSub=find(~cellfun(@isempty,EC05_PSDavg))
cfg=[];
cfg.channel = {'C3','C4'};
cfg.frequency =[12 30];
tmp{iSub}=ft_selectdata(cfg,EC05_PSDavg{iSub});
EC05_PSDavg{iSub}.powspctrm_b=tmp{iSub}.powspctrm;
end

for iSub=find(~cellfun(@isempty,EC07_PSDavg))
cfg=[];
cfg.channel = {'C3','C4'};
cfg.frequency =[12 30];
tmp{iSub}=ft_selectdata(cfg,EC07_PSDavg{iSub});
EC07_PSDavg{iSub}.powspctrm_b=tmp{iSub}.powspctrm;
end
%% Extract mean freq pow per participant
for iSub=find(~cellfun(@isempty,EC23_PSDavg));
lowalpha_Ox(1,iSub)=mean(EC23_PSDavg{iSub}.powspctrm_la,[1 2]);
highalpha_Ox(1,iSub)=mean(EC23_PSDavg{iSub}.powspctrm_ha, [1 2]);
alpha_Ox(1,iSub)=mean(EC23_PSDavg{iSub}.powspctrm_a, [1 2]);
beta_C3C4(1,iSub)=mean(EC23_PSDavg{iSub}.powspctrm_b,[1 2]);
delta_Fx(1,iSub)=mean(EC23_PSDavg{iSub}.powspctrm_d,[1 2]);
theta_FzCz(1,iSub)=mean(EC23_PSDavg{iSub}.powspctrm_t,[1 2]);
end

for iSub=find(~cellfun(@isempty,EC01_PSDavg));
lowalpha_Ox(2,iSub)=mean(EC01_PSDavg{iSub}.powspctrm_la,[1 2]);
highalpha_Ox(2,iSub)=mean(EC01_PSDavg{iSub}.powspctrm_ha, [1 2]);
alpha_Ox(2,iSub)=mean(EC01_PSDavg{iSub}.powspctrm_a, [1 2]);
beta_C3C4(2,iSub)=mean(EC01_PSDavg{iSub}.powspctrm_b,[1 2]);
delta_Fx(2,iSub)=mean(EC01_PSDavg{iSub}.powspctrm_d,[1 2]);
theta_FzCz(2,iSub)=mean(EC01_PSDavg{iSub}.powspctrm_t,[1 2]);
end

for iSub=find(~cellfun(@isempty,EC03_PSDavg));
lowalpha_Ox(3,iSub)=mean(EC03_PSDavg{iSub}.powspctrm_la,[1 2]);
highalpha_Ox(3,iSub)=mean(EC03_PSDavg{iSub}.powspctrm_ha, [1 2]);
alpha_Ox(3,iSub)=mean(EC03_PSDavg{iSub}.powspctrm_a, [1 2]);
beta_C3C4(3,iSub)=mean(EC03_PSDavg{iSub}.powspctrm_b,[1 2]);
delta_Fx(3,iSub)=mean(EC03_PSDavg{iSub}.powspctrm_d,[1 2]);
theta_FzCz(3,iSub)=mean(EC03_PSDavg{iSub}.powspctrm_t,[1 2]);
end

for iSub=find(~cellfun(@isempty,EC05_PSDavg));
lowalpha_Ox(4,iSub)=mean(EC05_PSDavg{iSub}.powspctrm_la,[1 2]);
highalpha_Ox(4,iSub)=mean(EC05_PSDavg{iSub}.powspctrm_ha, [1 2]);
alpha_Ox(4,iSub)=mean(EC05_PSDavg{iSub}.powspctrm_a, [1 2]);
beta_C3C4(4,iSub)=mean(EC05_PSDavg{iSub}.powspctrm_b,[1 2]);
delta_Fx(4,iSub)=mean(EC05_PSDavg{iSub}.powspctrm_d,[1 2]);
theta_FzCz(4,iSub)=mean(EC05_PSDavg{iSub}.powspctrm_t,[1 2]);
end

for iSub=find(~cellfun(@isempty,EC07_PSDavg));
lowalpha_Ox(5,iSub)=mean(EC07_PSDavg{iSub}.powspctrm_la,[1 2]);
highalpha_Ox(5,iSub)=mean(EC07_PSDavg{iSub}.powspctrm_ha, [1 2]);
beta_C3C4(5,iSub)=mean(EC07_PSDavg{iSub}.powspctrm_b,[1 2]);
alpha_Ox(5,iSub)=mean(EC07_PSDavg{iSub}.powspctrm_a, [1 2]);
delta_Fx(5,iSub)=mean(EC07_PSDavg{iSub}.powspctrm_d,[1 2]);
theta_FzCz(5,iSub)=mean(EC07_PSDavg{iSub}.powspctrm_t,[1 2]);
end

lowalpha_Ox(lowalpha_Ox == 0)=NaN;
highalpha_Ox(highalpha_Ox == 0)=NaN;
beta_C3C4(beta_C3C4 == 0)=NaN;
delta_Fx(delta_Fx == 0)=NaN;
theta_FzCz(theta_FzCz == 0)=NaN;


writematrix(lowalpha_Ox','lowalpha_Ox.xlsx')
writematrix(highalpha_Ox','highalpha_Ox.xlsx')
writematrix(alpha_Ox','alpha_Ox.xlsx')
writematrix(beta_C3C4','beta_C3C4.xlsx')
writematrix(delta_Fx','delta_Fx.xlsx')
writematrix(theta_FzCz','theta_FzCz.xlsx')
%% REPEAT WITH OSCILLATORY POWER
%% Power Spectral Analysis Hanning 
for iSub=find(~cellfun(@isempty,EC23ovlp))
cfg=[];
cfg.method = 'irasa';
cfg.keeptrials = 'yes';                            
cfg.output        = 'fractal';
cfg.foi = 0.5:(1/5):30;
cfg.tapsmofrq = 0;
cfg.pad     = 'nextpow2';
 %exclude empty cells
frac23{iSub}=ft_freqanalysis(cfg, EC23ovlp{iSub});
cfg.output = 'original';
orig23{iSub}= ft_freqanalysis(cfg, EC23ovlp{iSub});
% subtract the fractal component from the power spectrum
cfg               = [];
cfg.parameter     = 'powspctrm';
cfg.operation     = 'x2-x1';
osci23{iSub} = ft_math(cfg, frac23{iSub}, orig23{iSub});
osci23{iSub}.powspctrm=smoothdata(osci23{iSub}.powspctrm,3,'movmean',3);
end


for iSub=find(~cellfun(@isempty,EC01ovlp)); %exclude empty cells
cfg=[];
cfg.method = 'irasa';
cfg.keeptrials = 'yes';                            
cfg.output        = 'fractal';
cfg.foi = 0.5:(1/5):30;
cfg.tapsmofrq = 0;
cfg.pad     = 'nextpow2';
frac01{iSub}=ft_freqanalysis(cfg, EC01ovlp{iSub});
cfg.output = 'original';
orig01{iSub}= ft_freqanalysis(cfg, EC01ovlp{iSub});
% subtract the fractal component from the power spectrum
cfg               = [];
cfg.parameter     = 'powspctrm';
cfg.operation     = 'x2-x1';
osci01{iSub} = ft_math(cfg, frac01{iSub}, orig01{iSub});
osci01{iSub}.powspctrm=smoothdata(osci01{iSub}.powspctrm,3,'movmean',3);
end


for iSub=find(~cellfun(@isempty,EC03ovlp)); %exclude empty cells
cfg=[];
cfg.method = 'irasa';
cfg.keeptrials = 'yes';                            
cfg.output        = 'fractal';
cfg.foi = 0.5:(1/5):30;
cfg.tapsmofrq = 0;
cfg.pad     = 'nextpow2';
frac03{iSub}=ft_freqanalysis(cfg, EC03ovlp{iSub});
cfg.output = 'original';
orig03{iSub}= ft_freqanalysis(cfg, EC03ovlp{iSub});
% subtract the fractal component from the power spectrum
cfg               = [];
cfg.parameter     = 'powspctrm';
cfg.operation     = 'x2-x1';
osci03{iSub} = ft_math(cfg, frac03{iSub}, orig03{iSub});
osci03{iSub}.powspctrm=smoothdata(osci03{iSub}.powspctrm,3,'movmean',3);
end

for iSub=find(~cellfun(@isempty,EC05ovlp)); %exclude empty cells
cfg=[];
cfg.method = 'irasa';
cfg.keeptrials = 'yes';                            
cfg.output        = 'fractal';
cfg.foi = 0.5:(1/5):30;
cfg.tapsmofrq = 0;
cfg.pad     = 'nextpow2';
frac05{iSub}=ft_freqanalysis(cfg, EC05ovlp{iSub});
cfg.output = 'original';
orig05{iSub}= ft_freqanalysis(cfg, EC05ovlp{iSub});
% subtract the fractal component from the power spectrum
cfg               = [];
cfg.parameter     = 'powspctrm';
cfg.operation     = 'x2-x1';
osci05{iSub} = ft_math(cfg, frac05{iSub}, orig05{iSub});
osci05{iSub}.powspctrm=smoothdata(osci05{iSub}.powspctrm,3,'movmean',3);
end

for iSub=find(~cellfun(@isempty,EC07ovlp)); %exclude empty cells
cfg=[];
cfg.method = 'irasa';
cfg.keeptrials = 'yes';                            
cfg.output        = 'fractal';
cfg.foi = 0.5:(1/5):30;
cfg.tapsmofrq = 0;
cfg.pad     = 'nextpow2';
frac07{iSub}=ft_freqanalysis(cfg, EC07ovlp{iSub});
cfg.output = 'original';
orig07{iSub}= ft_freqanalysis(cfg, EC07ovlp{iSub});
% subtract the fractal component from the power spectrum
cfg               = [];
cfg.parameter     = 'powspctrm';
cfg.operation     = 'x2-x1';
osci07{iSub} = ft_math(cfg, frac07{iSub}, orig07{iSub});
osci07{iSub}.powspctrm=smoothdata(osci07{iSub}.powspctrm,3,'movmean',3);
end
clear frac23 frac01 frac03 frac05 frac07 orig23 orig01 orig03 orig05 orig07
%% AVERAGE PSD OVER ALL PARTICIPANTS
for iSub=find(~cellfun(@isempty,osci23));
cfg =[];
osci23avg{iSub}=ft_freqdescriptives(cfg, osci23{iSub});
end
for iSub=find(~cellfun(@isempty,osci01));
osci01avg{iSub}=ft_freqdescriptives(cfg, osci01{iSub});
end;
for iSub=find(~cellfun(@isempty,osci03));
osci03avg{iSub}=ft_freqdescriptives(cfg, osci03{iSub});
end;
for iSub=find(~cellfun(@isempty,osci05));
osci05avg{iSub}=ft_freqdescriptives(cfg, osci05{iSub});
end;
for iSub=find(~cellfun(@isempty,osci07));
osci07avg{iSub}=ft_freqdescriptives(cfg, osci07{iSub});
end;

%% GRANDAVERAGE
cfg =[];
cfg.foilim = [4 8] %change per band
cfg.keepindividual ='no';
cfg.parameter='powspctrm';
osci23_grd=ft_freqgrandaverage(cfg, osci23avg{find(~cellfun(@isempty,osci23avg))});
osci01_grd=ft_freqgrandaverage(cfg, osci01avg{find(~cellfun(@isempty,osci01avg))});
osci03_grd=ft_freqgrandaverage(cfg, osci03avg{find(~cellfun(@isempty,osci03avg))});
osci05_grd=ft_freqgrandaverage(cfg, osci05avg{find(~cellfun(@isempty,osci05avg))});
osci07_grd=ft_freqgrandaverage(cfg, osci07avg{find(~cellfun(@isempty,osci07avg))});

%% TOPOPLOTS 
load('D:\fieldtrip-master\template\layout\easycapM25.mat')
% Alpha Power all time points
figure;
cfg=[];
cfg.layout=lay;
cfg.freq= [8 12];
ft_hastoolbox('brewermap', 1);         % ensure this toolbox is on the path
colormap(flipud(brewermap(64,'RdBu'))) % change the colormap
ft_topoplotER(cfg,osci23_grd)
figure;
ft_topoplotER(cfg,osci01_grd)
ft_hastoolbox('brewermap', 1);         % ensure this toolbox is on the path
colormap(flipud(brewermap(64,'RdBu'))) % change the colormap
figure;
ft_topoplotER(cfg,osci03_grd)
ft_hastoolbox('brewermap', 1);         % ensure this toolbox is on the path
colormap(flipud(brewermap(64,'RdBu'))) % change the colormap
figure;
ft_topoplotER(cfg,osci05_grd)
ft_hastoolbox('brewermap', 1);         % ensure this toolbox is on the path
colormap(flipud(brewermap(64,'RdBu'))) % change the colormap
figure;
ft_topoplotER(cfg,osci07_grd)
ft_hastoolbox('brewermap', 1);         % ensure this toolbox is on the path
colormap(flipud(brewermap(64,'RdBu'))) % change the colormap
%% AVERAGE PSD PER PARTICIPANT
% Calculate Frequency Band Power for specific elecs
%ALPHA
for iSub=find(~cellfun(@isempty,osci23avg))
cfg=[];
cfg.channel = {'O1','O2'};
cfg.frequency =[8 10];
tmp{iSub}=ft_selectdata(cfg,osci23avg{iSub});
osci23avg{iSub}.powspctrm_la=tmp{iSub}.powspctrm;
cfg.frequency = [10 12];
tmp{iSub}=ft_selectdata(cfg,osci23avg{iSub});
osci23avg{iSub}.powspctrm_ha=tmp{iSub}.powspctrm;
cfg.frequency=[8 12];
tmp{iSub}=ft_selectdata(cfg,osci23avg{iSub});
osci23avg{iSub}.powspctrm_a=tmp{iSub}.powspctrm
end

for iSub=find(~cellfun(@isempty,osci01avg))
cfg=[];
cfg.channel = {'O1','O2'};
cfg.frequency =[8 10];
tmp{iSub}=ft_selectdata(cfg,osci01avg{iSub});
osci01avg{iSub}.powspctrm_la=tmp{iSub}.powspctrm;
cfg.frequency = [10 12];
tmp{iSub}=ft_selectdata(cfg,osci01avg{iSub});
osci01avg{iSub}.powspctrm_ha=tmp{iSub}.powspctrm;
cfg.frequency=[8 12];
tmp{iSub}=ft_selectdata(cfg,osci01avg{iSub});
osci01avg{iSub}.powspctrm_a=tmp{iSub}.powspctrm
end

for iSub=find(~cellfun(@isempty,osci03avg))
cfg=[];
cfg.channel = {'O1','O2'};
cfg.frequency =[8 10];
tmp{iSub}=ft_selectdata(cfg,osci03avg{iSub});
osci03avg{iSub}.powspctrm_la=tmp{iSub}.powspctrm;
cfg.frequency = [10 12];
tmp{iSub}=ft_selectdata(cfg,osci03avg{iSub});
osci03avg{iSub}.powspctrm_ha=tmp{iSub}.powspctrm;
cfg.frequency=[8 12];
tmp{iSub}=ft_selectdata(cfg,osci03avg{iSub});
osci03avg{iSub}.powspctrm_a=tmp{iSub}.powspctrm
end
for iSub=find(~cellfun(@isempty,osci05avg))
cfg=[];
cfg.channel = {'O1','O2'};
cfg.frequency =[8 10];
tmp{iSub}=ft_selectdata(cfg,osci05avg{iSub});
osci05avg{iSub}.powspctrm_la=tmp{iSub}.powspctrm;
cfg.frequency = [10 12];
tmp{iSub}=ft_selectdata(cfg,osci05avg{iSub});
osci05avg{iSub}.powspctrm_ha=tmp{iSub}.powspctrm;
cfg.frequency=[8 12];
tmp{iSub}=ft_selectdata(cfg,osci05avg{iSub});
osci05avg{iSub}.powspctrm_a=tmp{iSub}.powspctrm
end
for iSub=find(~cellfun(@isempty,osci07avg))
cfg=[];
cfg.channel = {'O1','O2'};
cfg.frequency =[8 10];
tmp{iSub}=ft_selectdata(cfg,osci07avg{iSub});
osci07avg{iSub}.powspctrm_la=tmp{iSub}.powspctrm;
cfg.frequency = [10 12];
tmp{iSub}=ft_selectdata(cfg,osci07avg{iSub});
osci07avg{iSub}.powspctrm_ha=tmp{iSub}.powspctrm;
cfg.frequency=[8 12];
tmp{iSub}=ft_selectdata(cfg,osci07avg{iSub});
osci07avg{iSub}.powspctrm_a=tmp{iSub}.powspctrm
end

% THETA
for iSub=find(~cellfun(@isempty,osci23avg))
cfg=[];
cfg.channel = {'Fz','Cz'};
cfg.frequency =[4 8];
tmp{iSub}=ft_selectdata(cfg,osci23avg{iSub});
osci23avg{iSub}.powspctrm_t=tmp{iSub}.powspctrm;
end

for iSub=find(~cellfun(@isempty,osci01avg))
cfg=[];
cfg.channel = {'Fz','Cz'};
cfg.frequency =[4 8];
tmp{iSub}=ft_selectdata(cfg,osci01avg{iSub});
osci01avg{iSub}.powspctrm_t=tmp{iSub}.powspctrm;
end

for iSub=find(~cellfun(@isempty,osci03avg))
cfg=[];
cfg.channel = {'Fz','Cz'};
cfg.frequency =[4 8];
tmp{iSub}=ft_selectdata(cfg,osci03avg{iSub});
osci03avg{iSub}.powspctrm_t=tmp{iSub}.powspctrm;
end

for iSub=find(~cellfun(@isempty,osci05avg))
cfg=[];
cfg.channel = {'Fz','Fz'};
cfg.frequency =[4 8];
tmp{iSub}=ft_selectdata(cfg,osci05avg{iSub});
osci05avg{iSub}.powspctrm_t=tmp{iSub}.powspctrm;
end

for iSub=find(~cellfun(@isempty,osci07avg))
cfg=[];
cfg.channel = {'Fz','Cz'};
cfg.frequency =[4 8];
tmp{iSub}=ft_selectdata(cfg,osci07avg{iSub});
osci07avg{iSub}.powspctrm_t=tmp{iSub}.powspctrm;
end

%DELTA
for iSub=find(~cellfun(@isempty,osci23avg))
cfg=[];
cfg.channel = {'F3','F4','Fz'};
cfg.frequency =[0.5 4];
tmp{iSub}=ft_selectdata(cfg,osci23avg{iSub});
osci23avg{iSub}.powspctrm_d=tmp{iSub}.powspctrm;
end

for iSub=find(~cellfun(@isempty,osci01avg))
cfg=[];
cfg.channel = {'F3','F4','Fz'};
cfg.frequency =[0.5 4];
tmp{iSub}=ft_selectdata(cfg,osci01avg{iSub});
osci01avg{iSub}.powspctrm_d=tmp{iSub}.powspctrm;
end

for iSub=find(~cellfun(@isempty,osci03avg))
cfg=[];
cfg.channel = {'F3','F4','Fz'};
cfg.frequency =[0.5 4];
tmp{iSub}=ft_selectdata(cfg,osci03avg{iSub});
osci03avg{iSub}.powspctrm_d=tmp{iSub}.powspctrm;
end

for iSub=find(~cellfun(@isempty,osci05avg))
cfg=[];
cfg.channel = {'F3','F4','Fz'};
cfg.frequency =[0.5 4];
tmp{iSub}=ft_selectdata(cfg,osci05avg{iSub});
osci05avg{iSub}.powspctrm_d=tmp{iSub}.powspctrm;
end

for iSub=find(~cellfun(@isempty,osci07avg))
cfg=[];
cfg.channel = {'F3','F4','Fz'};
cfg.frequency =[0.5 4];
tmp{iSub}=ft_selectdata(cfg,osci07avg{iSub});
osci07avg{iSub}.powspctrm_d=tmp{iSub}.powspctrm;
end
%BETA
for iSub=find(~cellfun(@isempty,osci23avg))
cfg=[];
cfg.channel = {'C3','C4'};
cfg.frequency =[12 30];
tmp{iSub}=ft_selectdata(cfg,osci23avg{iSub});
osci23avg{iSub}.powspctrm_b=tmp{iSub}.powspctrm;
end

for iSub=find(~cellfun(@isempty,osci01avg))
cfg=[];
cfg.channel = {'C3','C4'};
cfg.frequency =[12 30];
tmp{iSub}=ft_selectdata(cfg,osci01avg{iSub});
osci01avg{iSub}.powspctrm_b=tmp{iSub}.powspctrm;
end

for iSub=find(~cellfun(@isempty,osci03avg))
cfg=[];
cfg.channel = {'C3','C4'};
cfg.frequency =[12 30];
tmp{iSub}=ft_selectdata(cfg,osci03avg{iSub});
osci03avg{iSub}.powspctrm_b=tmp{iSub}.powspctrm;
end

for iSub=find(~cellfun(@isempty,osci05avg))
cfg=[];
cfg.channel = {'C3','C4'};
cfg.frequency =[12 30];
tmp{iSub}=ft_selectdata(cfg,osci05avg{iSub});
osci05avg{iSub}.powspctrm_b=tmp{iSub}.powspctrm;
end

for iSub=find(~cellfun(@isempty,osci07avg))
cfg=[];
cfg.channel = {'C3','C4'};
cfg.frequency =[12 30];
tmp{iSub}=ft_selectdata(cfg,osci07avg{iSub});
osci07avg{iSub}.powspctrm_b=tmp{iSub}.powspctrm;
end
%% Extract mean freq pow per participant
for iSub=find(~cellfun(@isempty,osci23avg));
lowalpha_Ox(1,iSub)=mean(osci23avg{iSub}.powspctrm_la,[1 2]);
highalpha_Ox(1,iSub)=mean(osci23avg{iSub}.powspctrm_ha, [1 2]);
alpha_Ox(1,iSub)=mean(osci23avg{iSub}.powspctrm_a, [1 2]);
beta_C3C4(1,iSub)=mean(osci23avg{iSub}.powspctrm_b,[1 2]);
delta_Fx(1,iSub)=mean(osci23avg{iSub}.powspctrm_d,[1 2]);
theta_FzCz(1,iSub)=mean(osci23avg{iSub}.powspctrm_t,[1 2]);
end

for iSub=find(~cellfun(@isempty,osci01avg));
lowalpha_Ox(2,iSub)=mean(osci01avg{iSub}.powspctrm_la,[1 2]);
highalpha_Ox(2,iSub)=mean(osci01avg{iSub}.powspctrm_ha, [1 2]);
alpha_Ox(2,iSub)=mean(osci01avg{iSub}.powspctrm_a, [1 2]);
beta_C3C4(2,iSub)=mean(osci01avg{iSub}.powspctrm_b,[1 2]);
delta_Fx(2,iSub)=mean(osci01avg{iSub}.powspctrm_d,[1 2]);
theta_FzCz(2,iSub)=mean(osci01avg{iSub}.powspctrm_t,[1 2]);
end

for iSub=find(~cellfun(@isempty,osci03avg));
lowalpha_Ox(3,iSub)=mean(osci03avg{iSub}.powspctrm_la,[1 2]);
highalpha_Ox(3,iSub)=mean(osci03avg{iSub}.powspctrm_ha, [1 2]);
alpha_Ox(3,iSub)=mean(osci03avg{iSub}.powspctrm_a, [1 2]);
beta_C3C4(3,iSub)=mean(osci03avg{iSub}.powspctrm_b,[1 2]);
delta_Fx(3,iSub)=mean(osci03avg{iSub}.powspctrm_d,[1 2]);
theta_FzCz(3,iSub)=mean(osci03avg{iSub}.powspctrm_t,[1 2]);
end

for iSub=find(~cellfun(@isempty,osci05avg));
lowalpha_Ox(4,iSub)=mean(osci05avg{iSub}.powspctrm_la,[1 2]);
highalpha_Ox(4,iSub)=mean(osci05avg{iSub}.powspctrm_ha, [1 2]);
alpha_Ox(4,iSub)=mean(osci05avg{iSub}.powspctrm_a, [1 2]);
beta_C3C4(4,iSub)=mean(osci05avg{iSub}.powspctrm_b,[1 2]);
delta_Fx(4,iSub)=mean(osci05avg{iSub}.powspctrm_d,[1 2]);
theta_FzCz(4,iSub)=mean(osci05avg{iSub}.powspctrm_t,[1 2]);
end

for iSub=find(~cellfun(@isempty,osci07avg));
lowalpha_Ox(5,iSub)=mean(osci07avg{iSub}.powspctrm_la,[1 2]);
highalpha_Ox(5,iSub)=mean(osci07avg{iSub}.powspctrm_ha, [1 2]);
beta_C3C4(5,iSub)=mean(osci07avg{iSub}.powspctrm_b,[1 2]);
alpha_Ox(5,iSub)=mean(osci07avg{iSub}.powspctrm_a, [1 2]);
delta_Fx(5,iSub)=mean(osci07avg{iSub}.powspctrm_d,[1 2]);
theta_FzCz(5,iSub)=mean(osci07avg{iSub}.powspctrm_t,[1 2]);
end

lowalpha_Ox(lowalpha_Ox == 0)=NaN;
highalpha_Ox(highalpha_Ox == 0)=NaN;
beta_C3C4(beta_C3C4 == 0)=NaN;
delta_Fx(delta_Fx == 0)=NaN;
theta_FzCz(theta_FzCz == 0)=NaN;


writematrix(lowalpha_Ox','oscilowalpha_Ox.xlsx')
writematrix(highalpha_Ox','oscihighalpha_Ox.xlsx')
writematrix(alpha_Ox','oscialpha_Ox.xlsx')
writematrix(beta_C3C4','oscibeta_C3C4.xlsx')
writematrix(delta_Fx','oscidelta_Fx.xlsx')
writematrix(theta_FzCz','oscitheta_FzCz.xlsx')