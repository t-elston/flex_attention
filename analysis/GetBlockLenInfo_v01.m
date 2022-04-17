function [blockleninfo] = GetBlockLenInfo_v01(bhv)


% go through each session separately 
SessionIDs = unique(bhv.fname);
blockleninfo=[];


for s = 1:numel(SessionIDs)
    
    blens = [];
    dim=[];
    IDshift=[];
    StateTransType=[];
    sinfo=[];
    bonusPerf=[];
    bsession=[];
    blockinsession=[];
    
    sdata = bhv(contains(bhv.fname,SessionIDs(s)),:);
    blockIDs = unique(sdata.blocknum);
    Xtrials  = find(sdata.XcritReached);
    
    for b = 1:numel(Xtrials)
        
        bdata = sdata(sdata.blocknum==b,:);
        nextBlock = sdata(sdata.blocknum==b+1,:);
        
        thisDim = bdata.DimNum(1);
        try
            nextDim = nextBlock.DimNum(1);
            
            blens(b) = numel(bdata.UseTrial) - sum(bdata.bonus);
            dim(b)   = bdata.DimNum(1);
            IDshift(b)  = thisDim == nextDim;
            
            
            
            
            if IDshift(b) ==1 & nextDim ==1
                StateTransType(b) = 1; % green to green
            elseif IDshift(b) ==1 & nextDim ==2
                StateTransType(b) = 2;      % pink to pink
            elseif IDshift(b) ==0 & nextDim ==1
                StateTransType(b) = 3; % pink to green
            elseif IDshift(b) ==0 & nextDim ==2
                StateTransType(b) = 4;   % green to pink
            end
            
            bonusPerf(b) = nanmean(bdata.PickedBest(bdata.bonus==1));
            bsession(b) = s;
            blockinsession(b) = b;

            
            
        catch
            xx=[];
        end
        
        
        
        
    end % of cycling through blocks
    
    sinfo(:,1) = bsession;
    sinfo(:,2) = blockinsession;
    sinfo(:,3) = blens;
    sinfo(:,4) = bonusPerf;
    sinfo(:,5) = dim;
    sinfo(:,6) = IDshift;
    sinfo(:,7) = StateTransType;
    
    blockleninfo = [blockleninfo ; sinfo];
    
end % of cycling through sessions




end % of function