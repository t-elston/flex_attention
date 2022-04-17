function [outdata] = GetIrrelevantStateDetailsv01(bhv)
allPickedLeft=[];
c_state=[];
c_valdiffs=[];
ir_state=[];
ir_valdiffs=[];
allHP=[];


BlockChanges = find(diff(bhv.blocknum)); % gives last trial of block

% get current and irrelevant state for each block
for b = 1:numel(BlockChanges)
    
    if b ==1
        bStart = 1;
    else
        bStart = BlockChanges(b-1)+1;
    end
    
    bEnd = BlockChanges(b);
    DimLog(b) = unique(bhv.DimNum(bStart:bEnd));
    StateLog(b) = unique(bhv.State(bStart:bEnd));
    
    % get current state info
    bState    = bhv.State(bStart:bEnd);
    bHPix     = bhv.HighPerfIX(bStart:bEnd);
    bValDiffs = bhv.LeftVal(bStart:bEnd) - bhv.RightVal(bStart:bEnd);
    bPickedLeft= double(bhv.SideChosen(bStart:bEnd) ==2);
    bColor = bhv.DimNum(bEnd);
    
    % get information related to last block of another dimension
    % most recent other-colored state
    OtherDimTrials = find(bhv.DimNum ~= bColor);
    
    % are any of those trials before this current block?
    if isempty(find(OtherDimTrials < bEnd))
        ir_bState=[];      
    else
       ir_bState = StateLog(max(find(diff(DimLog))));
    end % of determining the most recent irrelevant state
    
    
        
    
    % if there is no such instance (i.e. the first 4 blocks ever)
    if isempty(ir_bState)
        ir_bState    = NaN(size(bState));
        ir_bValDiffs = NaN(size(bState));
        
    else % if there was a prior state
        ir_bState = ones(size(bState))*ir_bState;
        ir_bValDiffs=[];
        
        switch ir_bState(1)
            case 1
                irLval = bhv.lG(bStart:bEnd);
                irRval = bhv.rG(bStart:bEnd);
                
            case 2           
                irLvalholder = bhv.lG(bStart:bEnd);
                irRvalholder = bhv.rG(bStart:bEnd);
                irLval = NaN(size(bState));
                irRval = NaN(size(bState));
                irLval(irLvalholder==1) = 4;
                irLval(irLvalholder==2) = 3;
                irLval(irLvalholder==3) = 2;
                irLval(irLvalholder==4) = 1;
                irRval(irRvalholder==1) = 4;
                irRval(irRvalholder==2) = 3;
                irRval(irRvalholder==3) = 2;
                irRval(irRvalholder==4) = 1;
                
            case 3
                irLval = bhv.lP(bStart:bEnd);
                irRval = bhv.rP(bStart:bEnd);
                
            case 4
                irLvalholder = bhv.lP(bStart:bEnd);
                irRvalholder = bhv.rP(bStart:bEnd);
                irLval = NaN(size(bState));
                irRval = NaN(size(bState));
                irLval(irLvalholder==1) = 4;
                irLval(irLvalholder==2) = 3;
                irLval(irLvalholder==3) = 2;
                irLval(irLvalholder==4) = 1;
                irRval(irRvalholder==1) = 4;
                irRval(irRvalholder==2) = 3;
                irRval(irRvalholder==3) = 2;
                irRval(irRvalholder==4) = 1;       
        end % of switch-case
        ir_bValDiffs(:,1) = irLval - irRval;
        xx=[];
        
    end % of figuring out value components of most recent irrelevant dim/state

    % let's add everything to some accumulating matrices
    allHP = [allHP; bHPix];
    allPickedLeft = [allPickedLeft;bPickedLeft];
    c_state=[c_state; bState];
    c_valdiffs=[c_valdiffs; bValDiffs];
    ir_state=[ir_state;ir_bState];
    ir_valdiffs=[ir_valdiffs;ir_bValDiffs];
    
    if numel(bValDiffs) ~= numel(ir_bValDiffs)
        xx=[];
    end
    
end % of cycling through blocks

outdata = table;
outdata.PickedLeft = allPickedLeft;
outdata.cState = c_state;
outdata.cValDiffs = c_valdiffs;
outdata.irState  = ir_state;
outdata.irValDiffs= ir_valdiffs;
outdata.HPix = logical(allHP);


outdata(isnan(outdata.irState),:)=[];

end % of function