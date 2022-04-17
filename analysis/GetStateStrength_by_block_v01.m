function [outdata] = GetStateStrength_by_block_v01(bhv)

xx=[];

% grab blocks and look for the switch trial...

sessIDs = unique(bhv.fname);
ctr=0;
for s = 1:numel(sessIDs)
    
    sdata = bhv(contains(bhv.fname,sessIDs(s)),:);
    States = [sdata.S1 sdata.S2 sdata.S3 sdata.S4];
    
    blockX = find(circshift(diff(sdata.blocknum),1));
    lastEDstate=[];
    
    for b = 1:numel(blockX)
        
        bX = blockX(b);
        pS = sdata.State(bX-1);
        fS = sdata.State(bX);
        
  
        blockLastTrial = max(find(sdata.blocknum ==sdata.blocknum(bX)));
        
        blockStates = States(bX-19: blockLastTrial,:);
        blockRTs    = sdata.RT(bX-19: blockLastTrial);
        blockCS     = sdata.buffsum(bX-19: blockLastTrial);
        blockOutcome= sdata.PickedBest(bX-19: blockLastTrial);
        
        block_priorS  = blockStates(:,pS);
        block_futureS = blockStates(:,fS);
        
        % store these state values
        lEDshift      = NaN(1,300);
        priorS        = NaN(1,300);
        futureS       = NaN(1,300);
        RTholder      = NaN(1,300);
        CSholder      = NaN(1,300);
        Outcomeholder = NaN(1,300);
        
        priorS(1,1:numel(block_priorS)) = block_priorS;
        futureS(1,1:numel(block_futureS)) = block_futureS;
        RTholder(1,1:numel(blockRTs)) = blockRTs;
        CSholder(1,1:numel(blockRTs)) = blockCS;
        Outcomeholder(1,1:numel(blockRTs)) = blockOutcome;

        

        
             
             
                 ctr=ctr+1;
                 PriorStates(ctr,:)  = priorS;
                 FutureStates(ctr,:) = futureS;
                 RTs(ctr,:) = RTholder;
                 CumSum(ctr,:) = CSholder;
                 Outcomes(ctr,:) = Outcomeholder;
                 IDshift(ctr,1) = sdata.DimNum(bX) == sdata.DimNum(bX-1);
                 blocklen(ctr,1) = (blockLastTrial - bX+1) - sum(sdata.bonus(bX:blockLastTrial));
     
                 
                 lEDstate(ctr,1:numel(priorS)) = NaN(size(priorS));

                 
                 if ~IDshift(ctr,1) 
                     lastEDstate = sdata.State(bX-1);
                 end
                    
                     
                 if ~isempty(lastEDstate)
                      blockED  = blockStates(:,lastEDstate);
                     
                     lEDstate(ctr,1:numel(blockED)) = blockED;
   
                     
                 end
                     

        
    end % of looping through blocks
    

    
    
end % of looping through sessions




outdata = table;
outdata.IDshift     = IDshift;
outdata.blocklen    = blocklen;
outdata.PriorS      = PriorStates;
outdata.FutureS     = FutureStates;
outdata.lastED      = lEDstate;
outdata.RT          = RTs;
outdata.CS          = CumSum;
outdata.outcomes    = Outcomes;







end % of function