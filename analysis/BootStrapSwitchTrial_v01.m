function [bootIDSwitchTrial,bootEDSwitchTrial,Xtrial] = BootStrapSwitchTrial_v01(Fstate,Pstate,IDshift,CS,nBoots)


% bootstrap the Xtrial
FPdiffs = Fstate - Pstate;
IDblocks = find(IDshift);
EDblocks = find(~IDshift);
% figure;
% hold on

for boot = 1:nBoots
    
    shuffID = shuffle(IDblocks);
    shuffED = shuffle(EDblocks);
    
    bootID_FPdiffs = nanmean(FPdiffs(shuffID(1:round(.8*numel(shuffID))),:));
    bootED_FPdiffs = nanmean(FPdiffs(shuffED(1:round(.8*numel(shuffED))),:));
    
%     [IDmean, IDsem] = GetMeanCI(FPdiffs(shuffID(1:round(.8*numel(shuffID))),1:80),'bootstrap');
%     [EDmean, EDsem] = GetMeanCI(FPdiffs(shuffED(1:round(.8*numel(shuffED))),1:80),'bootstrap');
    
    % find the X trial
     [bootID_start, bootID_len, ~] = ZeroOnesCount(bootID_FPdiffs > 0.05);
     [bootED_start, bootED_len, ~] = ZeroOnesCount(bootED_FPdiffs > 0.05);
     
     try 
     bootIDSwitchTrial(boot)= bootID_start(min(find(bootID_len>10)))-20;
     bootEDSwitchTrial(boot)= bootED_start(min(find(bootED_len>10)))-20;
     
     catch
     bootIDSwitchTrial(boot)= NaN;
     bootEDSwitchTrial(boot)= NaN;
     end
     

% plot(bootID_FPdiffs,'b')
% plot(xlim,[0 0],'k');
% plot(bootED_FPdiffs,'r')
% 
% xlim([20 60]);
%     
    
end % of bootstrapping


% find the Xtrial
for block = 1:numel(FPdiffs(:,1))
    
%     thisblock = FPdiffs(block,20:end);
%     
%          [start, len, ~] = ZeroOnesCount(thisblock > 0);
%         
%          try
%          Xtrial(block,1)= start(min(find(len>10)));
%          catch
%          Xtrial(block,1) = NaN;
%          end

          thisblock = Fstate(block,20:end);
    
         [start, len, ~] = ZeroOnesCount(thisblock > .5);
        
         try
         Xtrial(block,1)= start(min(find(len>5)));
         catch
         Xtrial(block,1) = NaN;
         end
             
%              
    
end % of looping through blocks

% [ID_f,ID_x] = ecdf(Xtrial(IDshift));
% [ED_f,ED_x] = ecdf(Xtrial(~IDshift));
% 
% [IDmean,IDsem] = GetMeanCI(Xtrial(IDshift),'sem');
% [EDmean,EDsem] = GetMeanCI(Xtrial(~IDshift),'sem');
% 
% 
% figure; 
% subplot(1,2,1)
% hold on
% plot(ID_x,ID_f,'LineWidth',3,'color',[.5 .5 .5]);
% plot(ED_x,ED_f,'LineWidth',3,'color',[.5 .5 1]);
% plot(Xtrial(IDshift),ones(numel(Xtrial(IDshift)),1)*.1,'o','color',[.5 .5 .5],'LineWidth',1,'MarkerSize',10);
% plot(Xtrial(~IDshift),ones(numel(Xtrial(~IDshift)),1)*.15,'o','color',[.5 .5 1],'LineWidth',1,'MarkerSize',10);
% axis tight
% legend({'ID','ED'});
% xlabel('Trial Future State Stably Overtakes Prior State');
% ylabel('CDF');
% set(gca,'FontSize',12,'LineWidth',1);
% [h p] = ttest2(Xtrial(IDshift), Xtrial(~IDshift));
% 
% subplot(1,2,2);
% hold on
% bar(1,IDmean,'FaceColor',[.5 .5 .5]);
% bar(2,EDmean,'FaceColor',[.5 .5 1 ]);
% errorbar([1,2],[IDmean,EDmean],[IDsem,EDsem],'.','MarkerSize',20,'color','k','LineWidth',2,'CapSize',0);




end % of function
