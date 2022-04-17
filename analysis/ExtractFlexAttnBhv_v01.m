function bhv = ExtractFlexAttnBhv_v01(DATADIR)


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
        if contains(sessiondata.Dim{t},'green') | contains(sessiondata.Dim{t},'fruit')
            sessiondata.DimNum(t) = 1; 
        else
            sessiondata.DimNum(t) = 2;
        end
        sessiondata.Config(t)          = thisFileData(t).UserVars.config;
        
        
        if sessiondata.DimNum(t) == 1 & sessiondata.Config(t) ==1
            sessiondata.State(t) = 1;
        elseif sessiondata.DimNum(t) == 1 & sessiondata.Config(t) ==2
            sessiondata.State(t) = 2;
        elseif sessiondata.DimNum(t) == 2 & sessiondata.Config(t) ==1
            sessiondata.State(t) = 3;   
        elseif sessiondata.DimNum(t) == 2 & sessiondata.Config(t) ==2
            sessiondata.State(t) = 4; 
        end
        
        sessiondata.PickedBest(t)      = thisFileData(t).UserVars.PickedBestOpt;
        sessiondata.buffsum(t)         = thisFileData(t).UserVars.BuffSum;     
        sessiondata.XcritReached(t)    = thisFileData(t).UserVars.XcritReached;
        
        if t > 1
            if thisFileData(t-1).UserVars.BonusTrial == 1 & thisFileData(t).UserVars.BonusTrial ==0
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
        
        if contains(DATADIR,'4opt_2stim')
            
            [lP,lG,rP,rG,...
             lPtype,lGtype,rPtype,rGtype] = ParseStimValues_v02(thisFileData(t).TaskObject.Attribute);
            
        else
            [lP,lG,rP,rG] = ParseStimValues_v01(thisFileData(t).TaskObject.Attribute);
            lPtype=1; lGtype=1; rPtype=1; rGtype =1;
            
        end
        
        if contains(DATADIR,'FF')
            
            [lP,lG,rP,rG] = ParseStimValues_FF(thisFileData(t).TaskObject.Attribute);
            
        end
        
        sessiondata.lP(t) = lP;
        sessiondata.lG(t) = lG;
        sessiondata.rP(t) = rP;
        sessiondata.rG(t) = rG;      
        
        
    end % of cycling through trials

    sessiondata(~sessiondata.UseTrial,:)=[];
    sessiondata.IDshiftnum = mod(sessiondata.blocknum-1,4);
    
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