function [lP,lG,rP,rG,...
          lPtype,lGtype,rPtype,rGtype] = ParseStimValues_v02(stimulidetails)
lP = [];
lG = [];
rP = [];
rG = [];


Lstim = stimulidetails{1,2}(2);
Rstim = stimulidetails{1,3}(2);

% LEFT PINK
if any(contains(Lstim,{'P1'}))
    lP=1;
elseif any(contains(Lstim,{'P2'}))
    lP=2;
elseif any(contains(Lstim,{'P3'}))
    lP = 3;
elseif any(contains(Lstim,{'P4'}))
    lP=4;
end

% LEFT GREEN
if any(contains(Lstim,{'G1'}))
    lG=1;
elseif any(contains(Lstim,{'G2'}))
    lG=2;
elseif any(contains(Lstim,{'G3'}))
    lG=3;
elseif any(contains(Lstim,{'G4'}))
    lG=4;
end

% RIGHT PINK
if any(contains(Rstim,{'P1'}))
    rP=1;
elseif any(contains(Rstim,{'P2'}))
    rP=2;
elseif any(contains(Rstim,{'P3'}))
    rP=3;
elseif any(contains(Rstim,{'P4'}))
    rP=4;
end

% RIGHT GREEN
if any(contains(Rstim,{'G1'}))
    rG=1;
elseif any(contains(Rstim,{'G2'}))
    rG=2;
elseif any(contains(Rstim,{'G3'}))
    rG=3;
elseif any(contains(Rstim,{'G4'}))
    rG=4;
end

%-----------------------------------
% get the stim types
%-----------------------------------
% LEFT PINK
if any(contains(Lstim{1}(85),{'1'}))
    lPtype=1;
elseif any(contains(Lstim{1}(85),{'2'}))
    lPtype=2;
end

% LEFT GREEN
if any(contains(Lstim{1}(90),{'1'}))
    lGtype=1;
elseif any(contains(Lstim{1}(90),{'2'}))
    lGtype=2;
end

% RIGHT PINK
if any(contains(Rstim{1}(85),{'1'}))
    rPtype=1;
elseif any(contains(Rstim{1}(85),{'2'}))
    rPtype=2;
end

% RIGHT GREEN
if any(contains(Rstim{1}(90),{'1'}))
    rGtype=1;
elseif any(contains(Rstim{1}(90),{'2'}))
    rGtype=2;
end

end % of function