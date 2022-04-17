function [yy] = AssessBL_v01(blockleninfo,StateTrans)
yy=[];

% define the color map
CT = cbrewer('qual','Paired',12);

% blockleninfo(blockleninfo(:,2)>100,:)=[];


    bsession       = blockleninfo(:,1);
    blockinsession = blockleninfo(:,2);
    blens          = blockleninfo(:,3);
    bonusperf      = blockleninfo(:,4);
    dim            = blockleninfo(:,5);
    IDshift        = blockleninfo(:,6);
    transtype      = blockleninfo(:,7);
    
    
    
%     figure;
%     hold on
%     plot(blockinsession(IDshift==1),blens(IDshift==1),'.','MarkerSize',10);
%     plot(blockinsession(IDshift==0),blens(IDshift==0),'.','MarkerSize',10);

    
    
    % key for transtype
gg = 1;  % green to green
pp = 2;  % pink to pink
pg = 3;  % green to pink
gp = 4;  % pink to green


sID = unique(bsession);

  for s = 1:numel(sID)
      
      IDmean(s) = nanmean(blens(bsession == sID(s) & IDshift));
      IDsem(s) = nanstd(blens(bsession == sID(s) & IDshift)) / sqrt(numel(blens(bsession == sID(s) & IDshift)));  
      
      EDmean(s) = nanmean(blens(bsession == sID(s) & ~IDshift));
      EDsem(s) = nanstd(blens(bsession == sID(s) & ~IDshift)) / sqrt(numel(blens(bsession == sID(s) & ~IDshift)));  
      
      Allmean(s) = nanmean(blens(bsession == sID(s)));
      Allsem(s)  = nanstd(blens(bsession == sID(s))) / sqrt(numel(blens(bsession == sID(s))));  
      
      CompletedBlocks(s) = sum(bsession == sID(s));
      
      % check if blocks get faster over time
      
      
      
  end % of looping through sessions
  
  figure; 
  subplot(1,5,[1 2]);
  hold on
%   errorbar(Allmean,Allsem,'color',[.5 .5 .5],'Marker','.','MarkerSize',20,'CapSize',0,'LineWidth',2);
    errorbar(IDmean,IDsem,'color',CT(2,:),'Marker','.','MarkerSize',20,'CapSize',0,'LineWidth',2);
  errorbar(EDmean,EDsem,'color',CT(6,:),'Marker','.','MarkerSize',20,'CapSize',0,'LineWidth',2);
  ylim([20 80]);
  xticks([1:numel(IDmean)]);
  grid on
  ylabel('Trials to Crit');
  xlabel('Session Number');
  set(gca,'LineWidth',1,'FontSize',10)
  legend({'ID','ED'});

  
  
[allIDmean,allIDsem] = GetMeanCI(blens(IDshift==1),'sem');
[allEDmean,allEDsem] = GetMeanCI(blens(IDshift==0),'sem');
[~,pval] = ttest2(blens(IDshift==1),blens(IDshift==0),'tail','right');
  
  subplot(1,5,3);
  hold on
bar([1],allIDmean,'FaceColor',CT(2,:));
bar([2],allEDmean,'FaceColor',CT(6,:));
errorbar([1:2],[allIDmean,allEDmean],[allIDsem,allEDsem],'.','MarkerSize',20,'LineWidth',2,'Capsize',10,'color','k');
xticks([1:2]);
xticklabels({'ID','ED'});
ylabel('Trials to Crit');
xlabel('Switch Type');
set(gca,'LineWidth',1,'FontSize',10)


subplot(1,5,[4 5]);
Idshift = StateTrans.IDshift;

hold on
plot(nanmean(StateTrans.CS(Idshift,:)),'color',CT(2,:),'LineWidth',2)
plot(nanmean(StateTrans.CS(~Idshift,:)),'color',CT(6,:),'LineWidth',2)
xlim([1 50]);
ylabel('Cumulative Correct Trials');
xlabel('Trials Relative to Switch');
xticklabels(xticks-20);
plot([20 20],ylim,'k','LineWidth',1);


  
  
  
  
end % of function