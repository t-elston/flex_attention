function [lP,lG,rP,rG] = ParseStimValues_FF(stimulidetails)
lP = [];
lG = [];
rP = [];
rG = [];


Lstim = stimulidetails{1,2}(2);
Rstim = stimulidetails{1,3}(2);

% LEFT PINK
if any(contains(Lstim,{'F1'}))
    lP=1;
elseif any(contains(Lstim,{'F2'}))
    lP=2;
elseif any(contains(Lstim,{'F3'}))
    lP = 3;
elseif any(contains(Lstim,{'F4'}))
    lP=4;
end

% LEFT GREEN
if any(contains(Lstim,{'O1'}))
    lG=1;
elseif any(contains(Lstim,{'O2'}))
    lG=2;
elseif any(contains(Lstim,{'O3'}))
    lG=3;
elseif any(contains(Lstim,{'O4'}))
    lG=4;
end

% RIGHT PINK
if any(contains(Rstim,{'F1'}))
    rP=1;
elseif any(contains(Rstim,{'F2'}))
    rP=2;
elseif any(contains(Rstim,{'F3'}))
    rP=3;
elseif any(contains(Rstim,{'F4'}))
    rP=4;
end

% RIGHT GREEN
if any(contains(Rstim,{'O1'}))
    rG=1;
elseif any(contains(Rstim,{'O2'}))
    rG=2;
elseif any(contains(Rstim,{'O3'}))
    rG=3;
elseif any(contains(Rstim,{'O4'}))
    rG=4;
end


end % of function