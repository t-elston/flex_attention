function [bhv] = FlexAttn_bhvstatestrength_v01(bhv,winlen,method)

% go session by session
sessIDs = unique(bhv.fname);
allS1=[];
allS2=[];
allS3=[];
allS4=[];

for s = 1:numel(sessIDs)
    
    sdata = bhv(contains(bhv.fname,sessIDs(s)),:);   
    
    % now go through each trial and see how the response aligns with each
    % state
    
        % state 1 = green, config 2
        bestS1 = abs(4-sdata.lG) - abs(4-sdata.rG);
        bestS1dir = (bestS1 > 0)+2;
        rawS1 = bestS1dir == sdata.SideChosen;
        
        % state 2 = green, config 1
        bestS2 = sdata.lG - sdata.rG;
        bestS2dir = (bestS2 > 0)+2;
        rawS2 = bestS2dir == sdata.SideChosen;

        % state 3 = pink, config 1
        bestS3 = sdata.lP - sdata.rP;
        bestS3dir = (bestS3 > 0)+2;
        rawS3 = bestS3dir == sdata.SideChosen;
        
        % state 4 = pink, config 2
        bestS4 = abs(4-sdata.lP) - abs(4-sdata.rP);
        bestS4dir = (bestS4 > 0)+2;
        rawS4 = bestS4dir == sdata.SideChosen;
        
        % get a smoothed state estimate
        allS1 = [allS1 ; smoothdata(rawS1,method,winlen)];
        allS2 = [allS2 ; smoothdata(rawS2,method,winlen)]; 
        allS3 = [allS3 ; smoothdata(rawS4,method,winlen)]; 
        allS4 = [allS4 ; smoothdata(rawS3,method,winlen)]; 
               
    
end % of looping through sessions


bhv.S1 = allS1;
bhv.S2 = allS2;
bhv.S3 = allS3;
bhv.S4 = allS4;


end % of function