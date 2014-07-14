function batch_process

%% Steps for processing

% User Input
Folder_Name = fullfile('/Volumes/Se/Michelle_Data/Data/-140617 Fish4 KR15-3A Deconvolved/'); %Folder with data
x = 50; %Number of pixels to include in square ROI [x y] and get mean activity within those pixels
y = 50;
Baseline_strt = 1; %Start time of baseline
Baseline_end = 10; %End time of baseline


% %% Step1
% % Convert .stk to .tif
% [Stimulus_List, T,Z] = read_images(Folder_Name);
% save([Folder_Name, 'Experiment_Parameters.mat'], 'T', 'Z', 'Stimulus_List')


%% Step 2
% Ask user Which stimulus to use as template?
load([Folder_Name, 'Experiment_Parameters.mat'])
[selection,ok_or_not] = listdlg('PromptString','Select an odor stimulus to use as template:',...
    'SelectionMode','single',...
    'ListString',Stimulus_List);

if ok_or_not == 1
    Use_Stim = selection;
else
    return;
end

%% Step 3
% Go around image using a square ROI, get OB pixels and mean intensity of those
% pixels within ROI
makeROIS(Folder_Name,Stimulus_List, T, Z, x,y, Baseline_strt, Baseline_end, Use_Stim)

%% Step 4
% Do PCA and plot
% Temporal PCA with cells as eigenvector
load([Folder_Name, 'Experiment_Parameters.mat'])
Color_mat = {'b','r','g'};
pca_stimulus_time(Folder_Name,Stimulus_List, T, Z, Color_mat);

% Spatial PCA with time as eigenvector
% load([Folder_Name, 'Experiment_Parameters.mat'])
% pca_stimulus_space(Folder_Name,Stimulus_List, T, Z);
