function Compare4opt_4opt2stim(BL_4opt,BL_4opt2stim)

bSess_4opt = BL_4opt(:,1);
BL4opt     = BL_4opt(:,2);

bSess_4opt2stim = BL_4opt2stim(:,1);
BL4opt2stim     = BL_4opt2stim(:,2);

sID_4opt = unique(bSess_4opt);

for s = 1:numel(sID_4opt)
    
      mean4opt(s) = nanmean(BL4opt(bSess_4opt == sID_4opt(s)));
      sem4opt(s)  = nanstd(BL4opt(bSess_4opt == sID_4opt(s))) / sqrt(numel(BL4opt(bSess_4opt == sID_4opt(s))));  
      
      CB_4opt(s) = sum(bSess_4opt == sID_4opt(s));
    
end % of looping through 4opt sessions
total4opt_mean = nanmean(BL4opt);
total4opt_sem  = nanstd(BL4opt) / sqrt(numel(BL4opt));



sID_4opt2stim = unique(bSess_4opt2stim);

for s = 1:numel(sID_4opt2stim)
    
      mean4opt2stim(s) = nanmean(BL4opt2stim(bSess_4opt2stim == sID_4opt2stim(s)));
      sem4opt2stim(s)  = nanstd(BL4opt2stim(bSess_4opt2stim == sID_4opt2stim(s))) / sqrt(numel(BL4opt2stim(bSess_4opt2stim == sID_4opt2stim(s))));  
      
      CB_4opt2stim(s) = sum(bSess_4opt2stim == sID_4opt2stim(s));
    
end % of looping through 4opt sessions

total4opt2stim_mean = nanmean(BL4opt2stim);
total4opt2stim_sem  = nanstd(BL4opt2stim) / sqrt(numel(BL4opt2stim));


figure;
subplot(2,3,[1 2])
hold on
errorbar(mean4opt,sem4opt,'Marker','.','MarkerSize',20,'CapSize',0,'LineWidth',2);
errorbar(mean4opt2stim,sem4opt2stim,'Marker','.','MarkerSize',20,'CapSize',0,'LineWidth',2,'color',[ .5 .5 .5]);
ylabel('Trials to Crit');
xlabel('Session Number');
legend({'No pair','Paired stimuli'});
set(gca,'FontSize',12,'LineWidth',1);


subplot(2,3,3);
hold on
bar(1,total4opt_mean);
bar(2,total4opt2stim_mean,'FaceColor',[ .5 .5 .5]);
errorbar([1 2],[total4opt_mean total4opt2stim_mean],[total4opt_sem , total4opt2stim_sem],...
        '.','MarkerSize',20,'CapSize',10,'LineWidth',2,'color','k');
    xticks([ 1 2]);
    ylim([20 80]);
    set(gca,'FontSize',12,'LineWidth',1);


subplot(2,3,[4 5]);
hold on
plot(CB_4opt,'Marker','.','MarkerSize',20,'LineWidth',2);
plot(CB_4opt2stim,'Marker','.','MarkerSize',20,'color',[ .5 .5 .5],'LineWidth',2);
ylabel('Total Blocks Completed');
xlabel('Session Number');
set(gca,'FontSize',12,'LineWidth',1);


subplot(2,3,6);
hold on
bar(1,nanmean(CB_4opt));
bar(2,nanmean(CB_4opt2stim),'FaceColor',[ .5 .5 .5]);
errorbar([1 2],[nanmean(CB_4opt) nanmean(CB_4opt2stim)],[nanstd(CB_4opt)/sqrt(numel(CB_4opt)) , nanstd(CB_4opt2stim)/sqrt(numel(CB_4opt2stim))],...
        '.','MarkerSize',20,'CapSize',10,'LineWidth',2,'color','k');
    xticks([ 1 2]);
ylim([10 20]);
set(gca,'FontSize',12,'LineWidth',1);



end % of function