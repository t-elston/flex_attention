function BLdata = GetFFTBlockDatav01(bhv)
BLdata=table;

fIDs = unique(bhv.fname);
allEDshift=[];
alllastIDblock=[];
ctr=0;
for f = 1:numel(fIDs)
    
    % index which trials came from this session
    fix = contains(bhv.fname,fIDs(f));
    
    blockIDs = unique(bhv.blocknum(fix));
    ncompletedblocks = sum(bhv.XcritReached(fix));
        
    IDbctr = 0;
    for b = 1:ncompletedblocks
        ctr=ctr+1;
       % index of trials in this block
       bix = fix & bhv.blocknum == blockIDs(b);
       
       BLdata.file(ctr,1)    = f;
       BLdata.dim(ctr,1)     = bhv.DimNum(min(find(bix)));
       BLdata.state(ctr,1)   = bhv.State(min(find(bix)));
       BLdata.len(ctr,1)     = sum(bix)+1;
       
       if b > 1 & (BLdata.dim(ctr-1,1) ~= BLdata.dim(ctr,1))
           IDbctr = 0;
       end
       IDbctr = IDbctr+1;
            
       BLdata.IDblock(ctr,1)    = IDbctr;
       
       BLdata.blockinsession(ctr,1) = b;
        
        
    end % of cyling through blocks in this session
    
 
    fEDshift = [0 ; diff(BLdata.dim(BLdata.file == f)) ~= 0];
    allEDshift = [allEDshift ; fEDshift];
    alllastIDblock = [alllastIDblock ; circshift(fEDshift,-1)];
    
end % of cycling through files

BLdata.EDshift = allEDshift;
BLdata.lastID = alllastIDblock;



end % of function