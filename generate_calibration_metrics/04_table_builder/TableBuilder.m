%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%
% Create NSE Output

clear all

run = 'calib6_';
type1 = 'merra2_30m';
type2 = 'merra2_100m';
ftype = '.csv';
metric1 = 'RMSE_';

% Get the list of the RMSE matfiles from this directory
RMSE_list1 = dir('*domain30m*RMSE.mat');

% Create an empty table
RMSE_table = table();

% Add RMSE values to blank table
for i = 1:length(RMSE_list1)
    inputRMSE = RMSE_list1(i).name; % Gets the name of the file to load below
    load(inputRMSE); % Loads the file
    RMSE_table = [RMSE_table;RMSE]; % Adds the RMSE table (saved as a .mat file in plotter.m and loaded above) to a longer table for sorting
end

% This adds columns for the ranking of RMSE for each variable
RMSE_table = sortrows(RMSE_table,'RMSEswe');
RMSE_table.SWErank = (1:length(RMSE_list1))';
% Write to csv
writetable(RMSE_table,strcat(metric1,run,type1,ftype));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get the list of the RMSE matfiles from this directory
RMSE_list2 = dir('*domain100m*RMSE.mat');

% Create an empty table
RMSE_table = table();

% Add RMSE values to blank table
for i = 1:length(RMSE_list2)
    inputRMSE = RMSE_list2(i).name; % Gets the name of the file to load below
    load(inputRMSE); % Loads the file
    RMSE_table = [RMSE_table;RMSE]; % Adds the RMSE table (saved as a .mat file in plotter.m and loaded above) to a longer table for sorting
end

% This adds columns for the ranking of RMSE for each variable
RMSE_table = sortrows(RMSE_table,'RMSEswe');
RMSE_table.SWErank = (1:length(RMSE_list2))';
writetable(RMSE_table,strcat(metric1,run,type2,ftype));


%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%
% Create NSE Output

metric2 = 'NSE_';

% Get the list of the NSE matfiles from this directory
NSE_list1 = dir('*domain30m*NSE.mat');

% Create an empty table
NSE_table = table();

% Add NSE values to blank table
for i = 1:length(NSE_list1)
    inputNSE = NSE_list1(i).name; % Gets the name of the file to load below
    load(inputNSE); % Loads the file
    NSE_table = [NSE_table;NSE]; % Adds the NSE table (saved as a .mat file in plotter.m and loaded above) to a longer table for sorting
end

% This adds columns for the ranking of NSE for each variable
NSE_table = sortrows(NSE_table,'NSEswe');
NSE_table.SWErank = (1:length(NSE_list1))';
% Write to csv
writetable(NSE_table,strcat(metric2,run,type1,ftype));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get the list of the NSE matfiles from this directory
NSE_list2 = dir('*domain100m*NSE.mat');

% Create an empty table
NSE_table = table();

% Add NSE values to blank table
for i = 1:length(NSE_list2)
    inputNSE = NSE_list2(i).name; % Gets the name of the file to load below
    load(inputNSE); % Loads the file
    NSE_table = [NSE_table;NSE]; % Adds the NSE table (saved as a .mat file in plotter.m and loaded above) to a longer table for sorting
end

% This adds columns for the ranking of NSE for each variable
NSE_table = sortrows(NSE_table,'NSEswe');
NSE_table.SWErank = (1:length(NSE_list2))';
writetable(NSE_table,strcat(metric2,run,type2,ftype));


%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%
% Create KGE Output

metric3 = 'KGE_';

% Get the list of the KGE matfiles from this directory
KGE_list1 = dir('*domain30m*KGE.mat');

% Create an empty table
KGE_table = table();

% Add KGE values to blank table
for i = 1:length(KGE_list1)
    inputKGE = KGE_list1(i).name; % Gets the name of the file to load below
    load(inputKGE); % Loads the file
    KGE_table = [KGE_table;KGE]; % Adds the KGE table (saved as a .mat file in plotter.m and loaded above) to a longer table for sorting
end

% This adds columns for the ranking of KGE for each variable
KGE_table = sortrows(KGE_table,'KGEswe');
KGE_table.SWErank = (1:length(KGE_list1))';
% Write to csv
writetable(KGE_table,strcat(metric3,run,type1,ftype));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get the list of the KGE matfiles from this directory
KGE_list2 = dir('*domain100m*KGE.mat');

% Create an empty table
KGE_table = table();

% Add KGSE values to blank table
for i = 1:length(KGE_list2)
    inputKGE = KGE_list2(i).name; % Gets the name of the file to load below
    load(inputKGE); % Loads the file
    KGE_table = [KGE_table;KGE]; % Adds the KGE table (saved as a .mat file in plotter.m and loaded above) to a longer table for sorting
end

% This adds columns for the ranking of KGE for each variable
KGE_table = sortrows(KGE_table,'KGEswe');
KGE_table.SWErank = (1:length(KGE_list2))';
writetable(KGE_table,strcat(metric3,run,type2,ftype));


%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%
% Create MBE Output

metric4 = 'MBE_';

% Get the list of the MBE matfiles from this directory
MBE_list1 = dir('*domain30m*MBE.mat');

% Create an empty table
MBE_table = table();

% Add MBE values to blank table
for i = 1:length(MBE_list1)
    inputMBE = MBE_list1(i).name; % Gets the name of the file to load below
    load(inputMBE); % Loads the file
    MBE_table = [MBE_table;MBE]; % Adds the MBE table (saved as a .mat file in plotter.m and loaded above) to a longer table for sorting
end

% This adds columns for the ranking of MBE for each variable
MBE_table = sortrows(MBE_table,'MBEswe');
MBE_table.SWErank = (1:length(MBE_list1))';
% Write to csv
writetable(MBE_table,strcat(metric4,run,type1,ftype));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get the list of the MBE matfiles from this directory
MBE_list2 = dir('*domain100m*MBE.mat');

% Create an empty table
MBE_table = table();

% Add MBE values to blank table
for i = 1:length(MBE_list2)
    inputMBE = MBE_list2(i).name; % Gets the name of the file to load below
    load(inputMBE); % Loads the file
    MBE_table = [MBE_table;MBE]; % Adds the MBE table (saved as a .mat file in plotter.m and loaded above) to a longer table for sorting
end

% This adds columns for the ranking of MBE for each variable
MBE_table = sortrows(MBE_table,'MBEswe');
MBE_table.SWErank = (1:length(MBE_list2))';
writetable(MBE_table,strcat(metric4,run,type2,ftype));


%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%
% Create MAE Output

metric5 = 'MAE_';

% Get the list of the MAE matfiles from this directory
MAE_list1 = dir('*domain30m*MAE.mat');

% Create an empty table
MAE_table = table();

% Add MAE values to blank table
for i = 1:length(MAE_list1)
    inputMAE = MAE_list1(i).name; % Gets the name of the file to load below
    load(inputMAE); % Loads the file
    MAE_table = [MAE_table;MAE]; % Adds the MAE table (saved as a .mat file in plotter.m and loaded above) to a longer table for sorting
end

% This adds columns for the ranking of MAE for each variable
MAE_table = sortrows(MAE_table,'MAEswe');
MAE_table.SWErank = (1:length(MAE_list1))';
% Write to csv
writetable(MAE_table,strcat(metric5,run,type1,ftype));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get the list of the MAE matfiles from this directory
MAE_list2 = dir('*domain100m*MAE.mat');

% Create an empty table
MAE_table = table();

% Add MAE values to blank table
for i = 1:length(MAE_list2)
    inputMAE = MAE_list2(i).name; % Gets the name of the file to load below
    load(inputMAE); % Loads the file
    MAE_table = [MAE_table;MAE]; % Adds the MAE table (saved as a .mat file in plotter.m and loaded above) to a longer table for sorting
end

% This adds columns for the ranking of MAE for each variable
MAE_table = sortrows(MAE_table,'MAEswe');
MAE_table.SWErank = (1:length(MAE_list2))';
writetable(MAE_table,strcat(metric5,run,type2,ftype));


%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%
% Create IDA Output

metric6 = 'IDA_';

% Get the list of the IDA matfiles from this directory
IDA_list1 = dir('*domain30m*IDA.mat');

% Create an empty table
IDA_table = table();

% Add IDA values to blank table
for i = 1:length(IDA_list1)
    inputIDA = IDA_list1(i).name; % Gets the name of the file to load below
    load(inputIDA); % Loads the file
    IDA_table = [IDA_table;IDA]; % Adds the IDA table (saved as a .mat file in plotter.m and loaded above) to a longer table for sorting
end

% This adds columns for the ranking of IDA for each variable
IDA_table = sortrows(IDA_table,'IDAswe');
IDA_table.SWErank = (1:length(IDA_list1))';
% Write to csv
writetable(IDA_table,strcat(metric6,run,type1,ftype));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get the list of the IDA matfiles from this directory
IDA_list2 = dir('*domain100m*IDA.mat');

% Create an empty table
IDA_table = table();

% Add IDA values to blank table
for i = 1:length(IDA_list2)
    inputIDA = IDA_list2(i).name; % Gets the name of the file to load below
    load(inputIDA); % Loads the file
    IDA_table = [IDA_table;IDA]; % Adds the IDA table (saved as a .mat file in plotter.m and loaded above) to a longer table for sorting
end

% This adds columns for the ranking of IDA for each variable
IDA_table = sortrows(IDA_table,'IDAswe');
IDA_table.SWErank = (1:length(IDA_list2))';
writetable(IDA_table,strcat(metric6,run,type2,ftype));