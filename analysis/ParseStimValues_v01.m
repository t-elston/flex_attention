function [lP,lG,rP,rG] = ParseStimValues_v01(stimulidetails)
lP = [];
lG = [];
rP = [];
rG = [];


Lstim = stimulidetails{1,2}(2);
Rstim = stimulidetails{1,3}{2};

% LEFT PINK
if any(contains(Lstim,{'Pu1','Pd1'}))
    lP=1;
elseif any(contains(Lstim,{'Pu2','Pd2'}))
    lP=2;
elseif any(contains(Lstim,{'Pu3','Pd3'}))
    lP = 3;
elseif any(contains(Lstim,{'Pu4','Pd4'}))
    lP=4;
end

% LEFT GREEN
if any(contains(Lstim,{'Gu1','Gd1'}))
    lG=1;
elseif any(contains(Lstim,{'Gu2','Gd2'}))
    lG=2;
elseif any(contains(Lstim,{'Gu3','Gd3'}))
    lG=3;
elseif any(contains(Lstim,{'Gu4','Gd4'}))
    lG=4;
end

% RIGHT PINK
if any(contains(Rstim,{'Pu1','Pd1'}))
    rP=1;
elseif any(contains(Rstim,{'Pu2','Pd2'}))
    rP=2;
elseif any(contains(Rstim,{'Pu3','Pd3'}))
    rP=3;
elseif any(contains(Rstim,{'Pu4','Pd4'}))
    rP=4;
end

% RIGHT GREEN
if any(contains(Rstim,{'Gu1','Gd1'}))
    rG=1;
elseif any(contains(Rstim,{'Gu2','Gd2'}))
    rG=2;
elseif any(contains(Rstim,{'Gu3','Gd3'}))
    rG=3;
elseif any(contains(Rstim,{'Gu4','Gd4'}))
    rG=4;
end

end % of function