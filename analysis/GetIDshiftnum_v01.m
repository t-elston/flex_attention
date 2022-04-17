function GetIDshiftnum_v01(bhv)

% go session by session
sessIDs = unique(bhv.fname);
allIDblocklens=[];

for s = 1:numel(sessIDs)
    
    sdata = bhv(contains(bhv.fname,sessIDs(s)),:); 
    
    
    % find mean block length of each block following an ED shift
    IDshiftnums = unique(sdata.IDshiftnum);
    
    IDblocklens = NaN(10,numel(IDshiftnums));

    for id = 1:numel(IDshiftnums)
        
        id_data = sdata(sdata.IDshiftnum ==IDshiftnums(id),:);
        
        blockdata = tabulate(id_data.blocknum);
        blocklens = blockdata(:,2);
        blocklens(blocklens==0)=[];
        
        IDblocklens(1:numel(blocklens),id) = blocklens;
    
    end % of looping over shifts
    
    allIDblocklens = [allIDblocklens;IDblocklens];
    
end % of looping over sessions

[BLmeans,BLsems] = GetMeanCI(allIDblocklens,'sem');


errorbar([1:numel(BLmeans)],BLmeans,BLsems)



end % of function