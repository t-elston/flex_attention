% aaaFFTmega_v01

% DATADIR = 'C:\Users\Thomas Elston\Documents\MATLAB\Projects\FlexAttn\FFT2opt\';
DATADIR = 'C:\Users\Thomas Elston\Documents\MATLAB\Projects\FlexAttn\FFT2opt24to1\';



bhv = ExtractFFTBhv_v01(DATADIR);



BLdata = GetFFTBlockDatav01(bhv);
PlotFFTBlockLensv01(BLdata)