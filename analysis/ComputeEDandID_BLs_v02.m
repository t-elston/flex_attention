function [Xoutcomes,Xrt,blockdata] = ComputeEDandID_BLs_v02(bhv)


% go through each session separately 
SessionIDs = unique(bhv.fname);
Xoutcomes=[];
Xrt=[];
blockdata=[];

for s = 1:numel(SessionIDs)
    
    sdata = bhv(contains(bhv.fname,SessionIDs(s)),:);
    
    blockIDs = unique(sdata.blocknum);
    blockIDs(1)=[];
    Xtrials  = find(sdata.XcritReached);
    
    for b = 1:numel(Xtrials)
        blockoutcomes=[];
        blockRTs=[];
        
        Xtrialsback = Xtrials(b) - 9;
        lastblocktrial = max(find(blockIDs(b)==sdata.blocknum));
        
        blockoutcomes(1,:) = sdata.PickedBest(Xtrialsback:lastblocktrial);
        blockRTs(1,:) = sdata.RT(Xtrialsback:lastblocktrial);
        
        outcomeholder = NaN(1,500);
        RTholder      = NaN(1,500);
        
        outcomeholder(1:numel(blockoutcomes)) = blockoutcomes;
        RTholder(1:numel(blockoutcomes)) = blockRTs;
 
        if Xtype ==1 & sdata.DimNum(Xtrials(b)) ==1
            StateTransType = 1; % green to green
        elseif Xtype ==1 & sdata.DimNum(Xtrials(b)) ==2
            StateTransType = 2;      % pink to pink
        elseif Xtype ==2 & sdata.DimNum(Xtrials(b)) ==1
            StateTransType = 3; % pink to green
        elseif Xtype ==2 & sdata.DimNum(Xtrials(b)) ==2
            StateTransType = 4;   % green to pink
        end
                    
        bdata(1) = s;
        bdata(2) = StateTransType;
         
        % accumulate everyting into arrays for later analysis
        Xoutcomes = [Xoutcomes ; outcomeholder];
        Xrt       = [Xrt ; RTholder];
        
        blockdata = [blockdata; bdata];
        
        
    end % of cycling through blocks

    
    
    
end % of cycling through sessions




end % of function