function PlotFFTBlockLensv01(BLdata)

BLdata(BLdata.blockinsession==1,:)=[];


CT = cbrewer('qual','Paired',12);

for f = 1:numel(unique(BLdata.file))
    fIDmean(f) = mean(BLdata.len(BLdata.file == f & BLdata.EDshift ==0 ));
    fIDsem(f) = std(BLdata.len(BLdata.file == f & BLdata.EDshift ==0 )) / sqrt(sum(BLdata.file == f & BLdata.EDshift ==0 ));
% %     
%     fIDmean(f) = mean(BLdata.len(BLdata.file == f & BLdata.lastID ==1 ));
%     fIDsem(f) = std(BLdata.len(BLdata.file == f & BLdata.lastID ==1 )) / sqrt(sum(BLdata.file == f & BLdata.lastID ==1 ));
%     
    fEDmean(f) = mean(BLdata.len(BLdata.file == f & BLdata.EDshift ==1 ));
    fEDsem(f) = std(BLdata.len(BLdata.file == f & BLdata.EDshift ==1 )) / sqrt(sum(BLdata.file == f & BLdata.EDshift ==1 ));

end



allIDmean = mean(BLdata.len(BLdata.EDshift ==0));
allIDsem = std(BLdata.len(BLdata.EDshift ==0)) / sqrt(sum(BLdata.EDshift == 0));

allEDmean = mean(BLdata.len(BLdata.EDshift ==1));
allEDsem = std(BLdata.len(BLdata.EDshift ==1)) / sqrt(sum(BLdata.EDshift == 1));

figure;
subplot(2,2,1);
hold on
errorbar(fIDmean,fIDsem,'color',CT(2,:),'Marker','.','MarkerSize',20,'CapSize',0,'LineWidth',2);
errorbar(fEDmean,fEDsem,'color',CT(6,:),'Marker','s','MarkerSize',10,'CapSize',0,'LineWidth',2,'MarkerFaceColor',CT(6,:));
% ylim([10 60]);
xlim([0 numel(fIDmean)+1]);
xticks([1:numel(fIDmean)]);
grid on
ylabel('Trials to Crit (16/20) ');
xlabel('Session Number');
set(gca,'FontSize',12,'LineWidth',1);
legend({'ID','ED'});
title('Block Lens by Session');




subplot(2,2,2);
sIDs = unique(BLdata.state);
hold on
% plot([1 1],[0 120],'k');
for s = 1:numel(sIDs)
plot(BLdata.IDblock(BLdata.state==sIDs(s)),BLdata.len(BLdata.state==sIDs(s)),'.','MarkerSize',25,...
    'color',CT(s,:));
end
grid on
xlabel('ID block #');
ylabel('Trials to Crit (16/20) ');
set(gca,'FontSize',12,'LineWidth',1);
ylim([10 120]);
xlim([0 25]);
title({'Block by Block'; '(all Sessions)'});

% do a regression
tbl = table;
tbl.len = BLdata.len;
tbl.IDblock = BLdata.IDblock;
tbl.dim     = BLdata.dim;
tbl.state = BLdata.state;

mdl = fitglm(tbl,'len ~ IDblock+dim');
[r p] = corr(tbl.len,tbl.IDblock);

% plot the fit
plot(xlim,xlim*mdl.Coefficients.Estimate(2) + mdl.Coefficients.Estimate(1),'k','LineWidth',2);


% now let's go through each session and see how the fit parameters change

for f = 1:numel(unique(BLdata.file))
    
    ftbl = table;
    ftbl.len = BLdata.len(BLdata.file == f);
    ftbl.IDblock = BLdata.IDblock(BLdata.file == f);
    ftbl.state = BLdata.state(BLdata.file == f);   
    fmdl = fitglm(ftbl,'len ~ IDblock + state');   
    fIntercepts(f) = fmdl.Coefficients.Estimate(1);
    fIDblocks(f)   = fmdl.Coefficients.Estimate(2);
    
    [fCorr(f), fPval(f)] = corr(BLdata.IDblock(BLdata.file == f),BLdata.len(BLdata.file == f));
    
end % of cycling through files

pholder = double(fPval<.05);
pholder(pholder==0) = NaN;

subplot(2,2,3); 
hold on
bar(fCorr)
plot(pholder.*fCorr-.05,'k*','LineWidth',1,'MarkerSize',10)
xlabel('Session Number');
ylabel('IDblock x BlockLen Corr (R)');
set(gca,'FontSize',12,'LineWidth',1);
xlim([0,numel(fCorr)+1]);
xticks([1:numel(fCorr)]);
ylim([-.65 .2]);
title({'Set Formation Rate';'(by Session)'});


allbmat=[];
for f = 1:numel(unique(BLdata.file))
    fdata = BLdata(BLdata.file == f,:);
    
    for b = 2:numel(fdata.dim)
        thisdim = fdata.dim(b);
        lastdim = fdata.dim(b-1);
        bmat = NaN(3,3);
        
        bmat(lastdim,thisdim) = fdata.len(b);
        
        allbmat = cat(3,allbmat,bmat);
        
        
    end % of cycling throug individual blocks

end % of cycling through files

meantranstypes = nanmean(allbmat,3);

% figure;
subplot(2,2,4); 

imagesc(meantranstypes)
xticks([1:3]);
yticks([1:3]);
xticklabels({'Faces','Fruit','Tools'});
yticklabels({'Faces','Fruit','Tools'});
xlabel('Shifting From');
ylabel('Shifting To');
cb = colorbar;
cb.Label.String = 'Mean Block Len';
colormap('bone');
title('Block Len by State Transition Type');
set(gca,'FontSize',12,'LineWidth',1);




end % of function