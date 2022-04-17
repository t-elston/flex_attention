% aaaFlexAttn_mega_v01

% DATADIR = 'C:\Users\Thomas Elston\Documents\MATLAB\Projects\FlexAttn\4-opt\';
DATADIR = 'C:\Users\Thomas Elston\Documents\MATLAB\Projects\FlexAttn\4optFF\';


bhv = ExtractFlexAttnBhv_v01(DATADIR);

% calculate a behavioral state-strength index
[bhv] = FlexAttn_bhvstatestrength_v01(bhv,5,'movmean');
[StateTrans] = GetStateStrength_by_block_v01(bhv);
PlotFlexAttn_StateTrans_v01(StateTrans,bhv);

FlexAttn_valuebasedchoice_v02(bhv);


% [blockleninfo] = GetBlockLenInfo_v01(bhv);
% 
% [yy] = AssessBL_v01(blockleninfo,StateTrans);

BLdata = GetFFTBlockDatav01(bhv);
PlotFFTBlockLensv01(BLdata)


% compare 4opt and 4opt_2stim

% bhv_4opt = ExtractFlexAttnBhv_v01(DATADIR2);
% bhv_4opt2stim = ExtractFlexAttnBhv_v01(DATADIR1);
% 
% [BL_4opt] = GetBlockLenInfo_v01(bhv_4opt);
% [BL_4opt2stim] = GetBlockLenInfo_v01(bhv_4opt2stim);
% 
% Compare4opt_4opt2stim(BL_4opt,BL_4opt2stim);


% get paired update info for 4opt_2stim
% [PairedUpdateInfo] = GetPairedUpdateInfo_v01(bhv);