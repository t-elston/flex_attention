function FlexAttn_valuebasedchoice_v02(bhv)
%---------------------
% v01 -- likelihood of choosing  best option as function of current state
% v02 -- likelihood of choosing best option as function of prior, irrelevant
%        state (e.g. if current = pink 1, what was the most recent green
%        state?)
%---------------------

% data characteristics based on current state
pBest = bhv.PickedBest;
OneIX = bhv.LeftVal ==1 | bhv.RightVal ==1;
TwoIX = bhv.LeftVal ==2 | bhv.RightVal ==2;
ThreeIX = bhv.LeftVal ==3 | bhv.RightVal ==3;
FourIX = bhv.LeftVal ==4 | bhv.RightVal ==4;
BonusIX = bhv.bonus ==1;
HPIX = bhv.HighPerfIX==1;

BHP_ix = BonusIX | HPIX;

ValDiffs = bhv.LeftVal - bhv.RightVal;
absValDiffs = abs(ValDiffs);

VD_id = unique(ValDiffs);
aVD_id = unique(absValDiffs);

PickedLeft = bhv.SideChosen ==2;
PickedBest = bhv.PickedBest;
RT = bhv.RT;


for s = 1:4
    
    for vd = 1:numel(VD_id)
        
        vd_ix = ValDiffs == VD_id(vd);
        StateValChoices(s,vd) = nanmean(PickedLeft(BHP_ix & vd_ix & bhv.State ==s));
        
        OverallMean(1,vd) = nanmean(PickedLeft(BHP_ix & vd_ix));
        
        StateValDiffRT(s,vd) = nanmean(RT(BHP_ix & vd_ix & bhv.State ==s));
        OverallVD_RT(1,vd) =   nanmean(RT(BHP_ix & vd_ix));

    end % of cylcing through the value differences
      
end % of looping through states

% do logistic regression
c_tbl = table;
c_tbl.ValDiffs   = ValDiffs;
c_tbl.State      = bhv.State;
c_tbl.PickedLeft = double(PickedLeft);
mdl = fitglm(c_tbl,'PickedLeft ~ ValDiffs*State','Link','logit','Distribution','binomial');
%-----------------------------------------------------------------------


% need to go block by block and get details about the most recent
% irrelevant dimension
[logit_tbl] = GetIrrelevantStateDetailsv01(bhv);
irMdl =fitglm(logit_tbl(logit_tbl.HPix,:),'PickedLeft ~ cValDiffs + irValDiffs','Link','logit','Distribution','binomial');

%---------------------
[xmin,xmax] = GetMinMax(VD_id);

figure; 
subplot(1,2,1);
hold on
plot(VD_id,StateValChoices','Marker','.','LineWidth',2);
plot(VD_id,OverallMean,'k','Marker','.','MarkerSize',20,'LineWidth',3)
xlim([xmin,xmax]);
plot([0 0],ylim,'k','LineStyle',':','LineWidth',1);
plot(xlim,[.5 .5],'k','LineStyle',':','LineWidth',1);

xlabel('Lval - Rval');
ylabel('p(Choose Left)');
set(gca,'FontSize',12,'LineWidth',1);
legend({'G1','G2','P1','P2','overall'},'Location','northwest');


subplot(1,2,2);
 
hold on
plot(VD_id,StateValDiffRT','Marker','.','LineWidth',2);
plot(VD_id,OverallVD_RT,'k','Marker','.','MarkerSize',20,'LineWidth',3)
xlim([xmin,xmax]);
xlabel('Lval - Rval');
ylabel('RT (ms)');
set(gca,'FontSize',12,'LineWidth',1);




end % of function