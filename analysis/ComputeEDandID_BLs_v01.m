function [BLs] = ComputeEDandID_BLs_v01(bhv)


% go through each session separately 
SessionIDs = unique(bhv.fname);
all_ID_BLs=[];
all_ED_BLs=[];

for s = 1:numel(SessionIDs)
    
    sdata = bhv(contains(bhv.fname,SessionIDs(s)),:);
    
    % find all instance of block changes
    Xtrials = find(sdata.XcritReached);
    BlockLens = diff(Xtrials);
    
    IntraShiftBlocks = sdata.DimNum(Xtrials) == sdata.DimNum(Xtrials-1);
    
    % only consider completed blocks
    IntraShiftBlocks = IntraShiftBlocks(1:numel(BlockLens));
    
    s_ID_BLs = BlockLens(IntraShiftBlocks);
    s_ED_BLs = BlockLens(~IntraShiftBlocks);
    
    all_ID_BLs = [all_ID_BLs ; s_ID_BLs];
    all_ED_BLs = [all_ED_BLs ; s_ED_BLs];
    
    % let's collect the individual blocks
    for b = 1:numel(Xtrials)
    blockHolder = NaN(1,500);
    
    blocktrials = sdata.PickedBest(Xtrials(b)-10:Xtrials(b)+40
    
    blockHolder(1,sdata.PickedBest(Xtrials(b)-10:Xtrials(b)
    
    
    end % of cycling through blocks

    
    
    
end % of cycling through sessions


meanID = mean(all_ID_BLs); 
semID = std(all_ID_BLs)/sqrt(numel(all_ID_BLs));

meanED = mean(all_ED_BLs);
semED  = std(all_ED_BLs)/sqrt(numel(all_ED_BLs));

figure;
hold on
bar([1 2],[meanID meanED]);
errorbar([1,2],[meanID meanED],[semID semED],'.','color','k','Capsize',0,'LineWidth',2);


end % of function