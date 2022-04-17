function bhv = ExtractFFTBhv_v01(DATADIR)


bhv=table;

FileData= dir([DATADIR '*.bhv2']);
[nFiles,~] = size(FileData);

for f = 1:nFiles
    
    % load the data
    thisFileData = mlread([DATADIR FileData(f).name]);
    
    [~,trialsinsession] = size(thisFileData);
    
    sessiondata = table;
    b = 1;
    % extract each trial's data
    for t = 1:trialsinsession
        
        sessiondata.fname{t}           = FileData(f).name;
        sessiondata.UseTrial(t)        = thisFileData(t).UserVars.UseTrial;
        sessiondata.Dim{t}             = thisFileData(t).UserVars.RelevantDim;
        if contains(sessiondata.Dim{t},'faces')
            sessiondata.DimNum(t) = 1; 
        elseif contains(sessiondata.Dim{t},'fruit')
            sessiondata.DimNum(t) = 2;
        elseif contains(sessiondata.Dim{t},'tools')
            sessiondata.DimNum(t) = 3;
        end
        
        sessiondata.Config(t)          = thisFileData(t).UserVars.config;
        
        % find out the unique state
        sessiondata.State(t) = 2*sessiondata.DimNum(t) - sessiondata.Config(t) +1;

        
        sessiondata.PickedBest(t)      = thisFileData(t).UserVars.PickedBestOpt;
        sessiondata.buffsum(t)         = thisFileData(t).UserVars.BuffSum;     
        sessiondata.XcritReached(t)    = thisFileData(t).UserVars.XcritReached;
        
        if t > 1
            if  sessiondata.XcritReached(t-1) == 1;
            b = b+1;
            end        
        end
        
        sessiondata.blocknum(t) = b;
        sessiondata.bonus(t)    = thisFileData(t).UserVars.BonusTrial;

        
        
        sessiondata.RT(t)              = thisFileData(t).UserVars.RT;
        sessiondata.LeftVal(t)         = thisFileData(t).UserVars.OptionVals(1);
        sessiondata.RightVal(t)        = thisFileData(t).UserVars.OptionVals(2);
        sessiondata.chosenval(t)       = thisFileData(t).UserVars.ChosenVal;
        sessiondata.SideChosen(t)      = thisFileData(t).UserVars.SideChosen;
        
       lStimVals = thisFileData(1).TaskObject.CurrentConditionInfo.cL;
       rStimVals = thisFileData(1).TaskObject.CurrentConditionInfo.cR;

        
        sessiondata.lFace(t) = thisFileData(t).TaskObject.CurrentConditionInfo.fL;
        sessiondata.rFace(t) = thisFileData(t).TaskObject.CurrentConditionInfo.fR;
        sessiondata.lFruit(t) = thisFileData(t).TaskObject.CurrentConditionInfo.oL;
        sessiondata.rFruit(t) = thisFileData(t).TaskObject.CurrentConditionInfo.oR;
        sessiondata.lTool(t) = thisFileData(t).TaskObject.CurrentConditionInfo.tL;
        sessiondata.rTool(t) = thisFileData(t).TaskObject.CurrentConditionInfo.tR;


        
    end % of cycling through trials

    sessiondata(~sessiondata.UseTrial,:)=[];
%     sessiondata.IDshiftnum = mod(sessiondata.blocknum-1,4);
    
    HP_starts = find(sessiondata.XcritReached)-19;
    
    HP_starts(HP_starts==0) = 1;
    
    sessiondata.HighPerfIX = zeros(size(sessiondata.UseTrial));
    for h = 1:numel(HP_starts)
        
    sessiondata.HighPerfIX(HP_starts(h):HP_starts(h)+19) = 1;
    end
    
    sessiondata.chosenval(sessiondata.chosenval==0) =1;
    sessiondata.chosenval(sessiondata.chosenval==1.5) =2;
    sessiondata.chosenval(sessiondata.chosenval==3.8) =3;
    sessiondata.chosenval(sessiondata.chosenval==5) =4;

    
    bhv = [bhv; sessiondata];
    
end % of cycling through sessions