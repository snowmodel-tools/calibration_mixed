% This script builds a single vector from the SnowModel timesteps
% and gdat files of interest. 
% INPUTS: parameters, gdat filenames, timesteps of interest
% OUTPUTS: matlab matfile

% To Run in Terminal: 
% Navigate to the correct directory
% The version of Matlab that you use is dependent on the version
% that is installed on the server.
% >> matlab.2017b -nodisplay -nodesktop -nosplash -r mk_vector_for_grid_location

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% USER INPUT SECTION %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create list of iterations that corresponds with the SnowModel run
timesteps = 1:1096;

% Select other parameters
xll=405062; %This is the bottom left corner of the SnowModel domain
yll=1243311; %This is the bottom left corner of the SnowModel domain
nx=767; %See XDEF in .ctl file 
ny=739; %See YDEF in .ctl file
cell=100;

% Access the ctl files that you want to build the .mat files.
ctl_files = ["swed.ctl"];
var_names = ["swed"];
% ctl_files = ["snod.ctl"];
% var_names = ["snowd"];

% This grid xval and yval comes from anothe script.
% This is the snowmodel grid i,j pair where the snotel station 
% is located.
gridi=414;
gridj=301;

%NOTE: This script needs the read_grads.m to function correctly.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% END USER INPUT %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:length(ctl_files)
    ctl_file = char(ctl_files(i));
    var_name = char(var_names(i)); % The variable you're interested in
    [X,Y,Z,xmax,ymax] = readGDAT(timesteps,ctl_file,var_name,xll,yll,nx,ny,cell,gridi,gridj);
    dir = pwd; dir = strsplit(dir, '/');
    dirl = length(dir);
    ref = dir(dirl-8:dirl-2); ref = strjoin(ref,'-');
    savename = strcat(ref,'-',var_name,'.mat');
    cd 
    save(savename,'Z');
end

clear
exit


function [X,Y,Z,xmax,ymax] = readGDAT(timesteps,ctl_file,var_name,xll,yll,nx,ny,cell,gridi,gridj)
    xmin=xll;
    ymin=yll;
    xmax=xmin+nx*cell; % finds the maximum x coord
    ymax=ymin+ny*cell; % finds the maximum y coord
    [X,Y]=meshgrid(xmin:cell:xmax-cell,ymin:cell:ymax-cell); % Create a mesh grid of the model domain space with the right coordinates
    for j=1:length(timesteps) % Loop to create the vector
        nt=timesteps(j); % Starts the loop at the appropriate timestep
        [var,h]=read_grads(ctl_file,var_name,'x',[gridi gridi],'y',[gridj gridj],'z',[1 1],'t',[nt nt]); 
        Z(:,:,j)=(var'); % So now, Z is a vector of values from the grads file.
    end
end
