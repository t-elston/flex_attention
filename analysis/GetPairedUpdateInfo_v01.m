function [PairedUpdateInfo] = GetPairedUpdateInfo_v01(bhv)


% go through each session separately 
SessionIDs = unique(bhv.fname);
PairedUpdateInfo=[];

ctr=1;
for s = 1:numel(SessionIDs)
    
    blens = [];
    dim=[];
    IDshift=[];
    StateTransType=[];
    sinfo=[];
    bonusPerf=[];
    bsession=[];
    
    sdata = bhv(contains(bhv.fname,SessionIDs(s)),:);
    blockIDs = unique(sdata.blocknum);
    Xtrials  = find(sdata.XcritReached);
    
    for b = 1:numel(Xtrials)
        
        
        bdata = sdata(sdata.blocknum==b,:);
        nextBlock = sdata(sdata.blocknum==b+1,:);     
        thisDim = bdata.DimNum(1);
        
        % cycle through the values
        
        for v = 1:4
            
            % find first time he picked this value
            ValChosenIX = find(bdata.chosenval ==v);
            first_vIX = ValChosenIX(1);
            
            if thisDim ==1 % green
                if bdata.SideChosen(first_vIX) ==2 % picked left
                    ChosenType = bdata.lGtype(first_vIX);
                else % he picked right
                    ChosenType = bdata.rGtype(first_vIX);
                end
                
                % find the next time he sees this value of the other stim type
                if ChosenType ==1
                    OtherTypeValIX = find((bdata.chosenval ==v) & (bdata.lGtype==2 | bdata.rGtype==2));
                else
                    OtherTypeValIX = find((bdata.chosenval ==v) & (bdata.lGtype==1 | bdata.rGtype==1));
                end
                        
            end
            
            
            
            
            
            
            
            if thisDim ==2 % pink
                if bdata.SideChosen(first_vIX) ==2 % picked left
                    ChosenType = bdata.lPtype(first_vIX);
                else % he picked right
                    ChosenType = bdata.rPtype(first_vIX);
                end
                
                % find the next time he sees this value of the other stim type
                if ChosenType ==1
                    OtherTypeValIX = find((bdata.chosenval ==v) & (bdata.lPtype==2 | bdata.rPtype==2));
                else
                    OtherTypeValIX = find((bdata.chosenval ==v) & (bdata.lPtype==1 | bdata.rPtype==1));
                end
            end
            
            
            
           NextTrial = OtherTypeValIX(min(find(OtherTypeValIX > first_vIX)));
           
           if isempty(NextTrial)
               candoanalysis = false;
           else
               candoanalysis = true;
           end
             
             if candoanalysis
           % see if he responded optimally on that next trial
           StimGenBest(ctr,v) = bdata.PickedBest(NextTrial);
           
            StimGenRepeat(ctr,v) = bdata.chosenval(NextTrial) == v;            
             end
            
        end % of cycling through values
          if candoanalysis
          StateID(ctr,1) = bdata.State(1);
          ctr = ctr+1;
          end   
        
    end % of cycling through blocks
    
    
end % of cycling through sessions

% make some plots
[Bestmeans,Bestsems] = grpstats(StimGenBest,StateID,{'mean','sem'});
[Repeatmeans,Repeatsems] = grpstats(StimGenRepeat,StateID,{'mean','sem'});


figure;
subplot(1,2,1);
hold on
errorbar(Bestmeans',Bestsems','CapSize',0,'LineWidth',1);
plot(nanmean(StimGenBest),'k','LineWidth',3);
ylim([0 1]);
xlabel('Option Value');
ylabel('p(Choose Best)');
set(gca,'FontSize',12,'LineWidth',1);
legend({'P1','P2','G1','G2','All'});

subplot(1,2,2);
hold on
errorbar(Repeatmeans',Repeatsems','CapSize',0,'LineWidth',1);
plot(nanmean(Repeatmeans),'k','LineWidth',3);
ylim([0 1]);
ylabel('p(Choose Again)');
set(gca,'FontSize',12,'LineWidth',1);








end % of function
