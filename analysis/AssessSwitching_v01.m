function [xx] = AssessSwitching_v01(Xoutcomes,Xrt,blockdata)

% column info for blockdata
snum = 1;
transtype = 2;

% key for transtype
gg = 1;  % green to green
pp = 2;  % pink to pink
pg = 3;  % pink to green
gp = 4;  % green to pink


% let's look at the percent correct for the different transition types
ppOutcome = nanmean(Xoutcomes(blockdata(:,transtype)==pp,:));
ggOutcome = nanmean(Xoutcomes(blockdata(:,transtype)==gg,:));

if numel(nanmean(Xoutcomes(blockdata(:,transtype)==pg,:))) < 2
    pgOutcome = Xoutcomes(blockdata(:,transtype)==pg,:);
else
pgOutcome = nanmean(Xoutcomes(blockdata(:,transtype)==pg,:));
end
gpOutcome = nanmean(Xoutcomes(blockdata(:,transtype)==gp,:));

figure;
hold on
plot(smoothdata(ppOutcome,'gaussian'),'LineWidth',1);
plot(smoothdata(ggOutcome,'gaussian'),'LineWidth',1);
plot(smoothdata(pgOutcome,'gaussian'),'LineWidth',1);
plot(smoothdata(gpOutcome,'gaussian'),'LineWidth',1);
xlim([1 50]);






% let's look at RTs for the different transition types
ppRT = nanmean(Xrt(blockdata(:,transtype)==pp,:));
ggRT = nanmean(Xrt(blockdata(:,transtype)==gg,:));

if numel(nanmean(Xrt(blockdata(:,transtype)==pg,:))) < 2
    pgRT = Xrt(blockdata(:,transtype)==pg,:);
else
pgRT = nanmean(Xrt(blockdata(:,transtype)==pg,:));
end
gpRT = nanmean(Xrt(blockdata(:,transtype)==gp,:));

figure;
hold on
plot(ppRT,'LineWidth',1);
plot(ggRT,'LineWidth',1);
plot(pgRT,'LineWidth',1);
plot(gpRT,'LineWidth',1);
xlim([1 50]);







end % of function