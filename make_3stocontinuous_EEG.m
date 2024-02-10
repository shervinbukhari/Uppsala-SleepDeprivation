%% GO BACK FROM CONTINOUS TO Full


for iSub=find(~cellfun(@isempty,ECdata2300_3s))
cfg=[];
cfg.trl = [min(ECdata2300_3s{iSub}.sampleinfo(:,1)) max(ECdata2300_3s{iSub}.sampleinfo(:,2)) 0];
EC23_continuous{iSub}=ft_redefinetrial(cfg,ECdata2300_3s{iSub});
end

for iSub=find(~cellfun(@isempty,ECdata0100_3s))
cfg=[];
cfg.trl = [min(ECdata0100_3s{iSub}.sampleinfo(:,1)) max(ECdata0100_3s{iSub}.sampleinfo(:,2)) 0];
EC01_continuous{iSub}=ft_redefinetrial(cfg,ECdata0100_3s{iSub});
end

for iSub=find(~cellfun(@isempty,ECdata0300_3s))
cfg=[];
cfg.trl = [min(ECdata0300_3s{iSub}.sampleinfo(:,1)) max(ECdata0300_3s{iSub}.sampleinfo(:,2)) 0];
EC03_continuous{iSub}=ft_redefinetrial(cfg,ECdata0300_3s{iSub});
end

for iSub=find(~cellfun(@isempty,ECdata0500_3s))
cfg=[];
cfg.trl = [min(ECdata0500_3s{iSub}.sampleinfo(:,1)) max(ECdata0500_3s{iSub}.sampleinfo(:,2)) 0];
EC05_continuous{iSub}=ft_redefinetrial(cfg,ECdata0500_3s{iSub});
end

for iSub=find(~cellfun(@isempty,ECdata0700_3s))
cfg=[];
cfg.trl = [min(ECdata0700_3s{iSub}.sampleinfo(:,1)) max(ECdata0700_3s{iSub}.sampleinfo(:,2)) 0];
EC07_continuous{iSub}=ft_redefinetrial(cfg,ECdata0700_3s{iSub});
end


%% SELECT ONLY RELEVANT CHANNELS
cfg=[];
cfg.channel={'O1','O2','C3','C4','Cz','Fz','F3','F4'};
for iSub=find(~cellfun(@isempty,ECdata2300_3s))
EC23_continuous{iSub}=ft_selectdata(cfg,EC23_continuous{iSub});
end
for iSub=find(~cellfun(@isempty,ECdata0100_3s))
EC01_continuous{iSub}=ft_selectdata(cfg,EC01_continuous{iSub});
end
for iSub=find(~cellfun(@isempty,ECdata0300_3s))
EC03_continuous{iSub}=ft_selectdata(cfg,EC03_continuous{iSub});
end
for iSub=find(~cellfun(@isempty,ECdata0500_3s))
EC05_continuous{iSub}=ft_selectdata(cfg,EC05_continuous{iSub});
end
for iSub=find(~cellfun(@isempty,ECdata0700_3s))
EC07_continuous{iSub}=ft_selectdata(cfg,EC07_continuous{iSub});
end

%% Fix missing channels (Not applied, 2021-04-12)
load('D:\MATLAB\METSLEEP_topo.mat')
for iSub=find(~cellfun(@isempty,EC23_continuous)); %Change for each time 
[notmissing, dummy] = match_str(EC23_continuous{1,35}.label, EC23_continuous{iSub}.label);
newtrial = cell(size(EC23_continuous{iSub}.trial));
for k = 1:numel(EC23_continuous{iSub}.trial)
newtrial{k} = zeros(numel(EC23_continuous{1,35}.label), size(EC23_continuous{iSub}.trial{k},2));
newtrial{k}(notmissing,:) = EC23_continuous{iSub}.trial{k};
end
goodchans   = false(numel(EC23_continuous{1,35}.label),1);
goodchans(notmissing) = true;
badchanindx = find(goodchans==0);
EC23_continuous{iSub}.trial = newtrial; clear newtrial;
EC23_continuous{iSub}.label = EC23_cl{1,35}.label;
warning('Inserting grad that does not actually belong to this dataset!')
EC23_continuous{iSub}.elec  = EC23_cl{1,35}.elec;
cfg =[];
cfg.neighbours =neighbours;
cfg.badchannel    = EC23_cl{iSub}.label(badchanindx);
cfg.layout = lay;
cfg.method ='weighted';
EC23r_continuous{iSub}=ft_channelrepair(cfg, EC23_continuous{iSub});
end

for iSub=43:46; %Change for each time 
[notmissing, dummy] = match_str(EC23_continuous{1,35}.label, EC01_continuous{iSub}.label);
newtrial = cell(size(EC01_continuous{iSub}.trial));
for k = 1:numel(EC01_continuous{iSub}.trial)
newtrial{k} = zeros(numel(EC23_continuous{1,35}.label), size(EC01_continuous{iSub}.trial{k},2));
newtrial{k}(notmissing,:) = EC01_continuous{iSub}.trial{k};
end
goodchans   = false(numel(EC23_continuous{1,35}.label),1);
goodchans(notmissing) = true;
badchanindx = find(goodchans==0);
EC01_continuous{iSub}.trial = newtrial; clear newtrial;
EC01_continuous{iSub}.label = EC23_continuous{1,35}.label;
warning('Inserting grad that does not actually belong to this dataset!')
EC01_continuous{iSub}.elec  = EC23_continuous{1,35}.elec;
cfg =[];
cfg.neighbours =neighbours;
cfg.badchannel    = EC01_continuous{iSub}.label(badchanindx);
cfg.layout = lay;
cfg.method ='weighted';
EC01r_continuous{iSub}=ft_channelrepair(cfg, EC01_continuous{iSub});
end
EC01r_continuous{8}=EC01_continuous;
for iSub=find(~cellfun(@isempty,EC03_continuous)); %Change for each time 
[notmissing, dummy] = match_str(EC23_continuous{1,35}.label, EC03_continuous{iSub}.label);
newtrial = cell(size(EC03_continuous{iSub}.trial));
for k = 1:numel(EC03_continuous{iSub}.trial)
newtrial{k} = zeros(numel(EC23_continuous{1,35}.label), size(EC03_continuous{iSub}.trial{k},2));
newtrial{k}(notmissing,:) = EC03_continuous{iSub}.trial{k};
end
goodchans   = false(numel(EC23_continuous{1,35}.label),1);
goodchans(notmissing) = true;
badchanindx = find(goodchans==0);
EC03_continuous{iSub}.trial = newtrial; clear newtrial;
EC03_continuous{iSub}.label = EC23_continuous{1,35}.label;
warning('Inserting grad that does not actually belong to this dataset!')
EC03_continuous{iSub}.elec  = EC23_continuous{1,35}.elec;
cfg =[];
cfg.neighbours =neighbours;
cfg.badchannel    = EC03_continuous{iSub}.label(badchanindx);
cfg.layout = lay;
cfg.method ='weighted';
EC03r_continuous{iSub}=ft_channelrepair(cfg, EC03_continuous{iSub});
end

for iSub=find(~cellfun(@isempty,EC05_continuous)); %Change for each time 
[notmissing, dummy] = match_str(EC23_continuous{1,35}.label, EC05_continuous{iSub}.label);
newtrial = cell(size(EC05_continuous{iSub}.trial));
for k = 1:numel(EC05_continuous{iSub}.trial)
newtrial{k} = zeros(numel(EC23_continuous{1,35}.label), size(EC05_continuous{iSub}.trial{k},2));
newtrial{k}(notmissing,:) = EC05_continuous{iSub}.trial{k};
end
goodchans   = false(numel(EC23_continuous{1,35}.label),1);
goodchans(notmissing) = true;
badchanindx = find(goodchans==0);
EC05_continuous{iSub}.trial = newtrial; clear newtrial;
EC05_continuous{iSub}.label = EC23_continuous{1,35}.label;
warning('Inserting grad that does not actually belong to this dataset!')
EC05_continuous{iSub}.elec  = EC23_continuous{1,35}.elec;
cfg =[];
cfg.neighbours =neighbours;
cfg.badchannel    = EC05_continuous{iSub}.label(badchanindx);
cfg.layout = lay;
cfg.method ='weighted';
EC05r_continuous{iSub}=ft_channelrepair(cfg, EC05_continuous{iSub});
end

for iSub=find(~cellfun(@isempty,EC07_continuous)); %Change for each time 
[notmissing, dummy] = match_str(EC23_continuous{1,35}.label, EC07_continuous{iSub}.label);
newtrial = cell(size(EC07_continuous{iSub}.trial));
for k = 1:numel(EC07_continuous{iSub}.trial)
newtrial{k} = zeros(numel(EC23_continuous{1,35}.label), size(EC07_continuous{iSub}.trial{k},2));
newtrial{k}(notmissing,:) = EC07_continuous{iSub}.trial{k};
end
goodchans   = false(numel(EC23_continuous{1,35}.label),1);
goodchans(notmissing) = true;
badchanindx = find(goodchans==0);
EC07_continuous{iSub}.trial = newtrial; clear newtrial;
EC07_continuous{iSub}.label = EC23_continuous{1,35}.label;
warning('Inserting grad that does not actually belong to this dataset!')
EC07_continuous{iSub}.elec  = EC23_continuous{1,35}.elec;
cfg =[];
cfg.neighbours =neighbours;
cfg.badchannel    = EC07_continuous{iSub}.label(badchanindx);
cfg.layout = lay;
cfg.method ='weighted';
EC07r_continuous{iSub}=ft_channelrepair(cfg, EC07_continuous{iSub});
end
