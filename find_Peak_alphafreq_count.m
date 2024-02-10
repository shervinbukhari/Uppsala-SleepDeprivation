for iSub=find(~cellfun(@isempty,EC23_PSDavg))
[peakpower(1,iSub), peakfreq(1,iSub)]=max(mean(EC23_PSDavg{iSub}.powspctrm_a, [1]));
end

for iSub=find(~cellfun(@isempty,EC01_PSDavg));
[peakpower(2,iSub), peakfreq(2,iSub)]=max(mean(EC01_PSDavg{iSub}.powspctrm_a, [1]));
end

for iSub=find(~cellfun(@isempty,EC03_PSDavg));
[peakpower(3,iSub),peakfreq(3,iSub)]=max(mean(EC03_PSDavg{iSub}.powspctrm_a, [1]));
end

for iSub=find(~cellfun(@isempty,EC05_PSDavg));
[peakpower(4,iSub), peakfreq(4,iSub)]=max(mean(EC05_PSDavg{iSub}.powspctrm_a, [1]));
end

for iSub=find(~cellfun(@isempty,EC07_PSDavg));
[peakpower(5,iSub), peakfreq(5,iSub)]=max(mean(EC07_PSDavg{iSub}.powspctrm_a, [1]));
end 

peakpower(peakpower == 0)=NaN;
peakfreq(peakfreq == 0)=NaN;
writematrix(peakpower','peakalphapower.xlsx')
writematrix(peakfreq','peakalphafreq.xlsx')