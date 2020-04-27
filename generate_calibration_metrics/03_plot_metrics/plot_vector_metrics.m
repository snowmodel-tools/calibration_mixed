% Plotter script creates a comparison between the model vector (.mat file)
% at the snotel station location and the SNOTEL record, defined below.

clear all

% The model vector matfile must end with *swed.mat
SWED = dir('*swed.mat');
SWED = SWED.name;


[fig,title,RMSEswe,NSEswe,IDAswe,MAEswe,KGEswe,MBEswe,SWEmod_stats,SWEobs_stats] = plotCalib(SWED);

figfilename = strcat(title,'_Snotel_woAssim.png');
RMSEfilename = strcat(title,'_RMSE.mat');
NSEfilename = strcat(title,'_NSE.mat');
IDAfilename = strcat(title,'_IDA.mat');
MAEfilename = strcat(title,'_MAE.mat');
KGEfilename = strcat(title,'_KGE.mat');
MBEfilename = strcat(title,'_MBE.mat');
fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 20 12];
saveas(gcf,figfilename);

%This bit saves the NSE and RMSE mat files.
RMSE = table(string(title),RMSEswe);
NSE = table(string(title),NSEswe);
IDA = table(string(title),IDAswe);
MAE = table(string(title),MAEswe);
KGE = table(string(title),KGEswe);
MBE = table(string(title),MBEswe);
save(RMSEfilename,'RMSE');
save(NSEfilename, 'NSE');
save(IDAfilename, 'IDA');
save(MAEfilename, 'MAE');
save(KGEfilename, 'KGE');
save(MBEfilename, 'MBE');

% Comment out the next line if you are NOT running it in a shell script.
exit;


function [fig,title,RMSEswe,NSEswe,IDAswe,MAEswe,KGEswe,MBEswe,SWEmod_stats,SWEobs_stats] = plotCalib(SWED)

% This is the snotel observation vector in (m), created separately.
m = csvread('snotel_data_100m.csv');
% The xval col from previous scripts.
datai = m(:,2);
% The yval col from previous scripts.
dataj = m(:,1);
% The corresponding model iteration.
level = m(:,3);
% The swe column from the snotel record.
swe = m(:,4);

% Optional section if you want to extract the veg type and topo values
%ascii_topo = dlmread('topo100.asc','',6,0);
%topo = flipud(ascii_topo);
%ascii_veg = dlmread('veg100.asc','',6,0);
%veg = flipud(ascii_veg);

% Get an empty xy vectors for SWE observations versus model, veg, topo, north
SWEobs = zeros(length(datai),1);
SWEmod = zeros(length(datai),1);
%SWEveg = zeros(length(datai),1);
%SWEtopo = zeros(length(datai),1);

title = strsplit(SWED,'-');titlel = length(title);
title = title(1:titlel-1); title=strjoin(title,'-');
 
%%%Load the model data
load(SWED,'Z');
modelSWE = Z;

% Fill the vectors with the data
for k = 1:length(datai)
    SWEobs(k) = swe(k);
    SWEmod(k) = modelSWE(1,1,(k)); % ascii to vector
    %SWEveg(k) = veg(datai(k),dataj(k));
    %SWEtopo(k) = topo(datai(k),dataj(k));
 
end

% This bit gets rid of two months of zeros during Aug and Sept,
% when there is not going to be snow in this part of the domain.
SWEmod_stats = SWEmod([31:334 396:700 762:1065]);
SWEobs_stats = SWEobs([31:334 396:700 762:1065]);

% Uncomment below if you want to keep all days of the year
%SWEmod_stats = SWEmod;
%SWEobs_stats = SWEobs;

% Nash-Sutcliffe-Efficiency
nse1 = sum((SWEobs_stats - SWEmod_stats).^2);
nse2 = sum((SWEobs_stats - mean(SWEobs_stats)).^2);
NSEswe = (1-(nse1/nse2));

% Index of Agreement
MSE = (1/length(SWEobs_stats))*(sum((SWEobs_stats - SWEmod_stats).^2));
PE = sum((abs(SWEmod_stats - mean(SWEobs_stats)) + abs(SWEobs_stats - mean(SWEobs_stats))).^2);
IDAswe = (1-(length(SWEobs_stats)*(MSE/PE)));

% Mean Absolute Error
MAEswe = (1/length(SWEobs_stats))*(sum(abs(SWEobs_stats - SWEmod_stats)));

% Root Mean Squared Error
RMSEswe = sqrt(MSE);

% Kling-Gupta Efficiency
stdevs = (std(SWEmod_stats)/std(SWEobs_stats));
means = (mean(SWEmod_stats)/mean(SWEobs_stats));
linecorr = corr(SWEmod_stats,SWEobs_stats);
KGEswe = (1 - (sqrt(((linecorr-1).^2)+((stdevs-1).^2)+((means-1).^2))));

% Mean Bias Error
MBEswe = (1/length(SWEobs_stats))*(sum(SWEmod_stats - SWEobs_stats));

% Make a SWE plot
fig = figure;
set(gcf,'color','w');
pointsize = 30;
scatter(SWEobs, SWEmod, pointsize, level,'filled');
axis equal
xlim([0 1.0]); %xticks([0 0.1 0.2 0.3]);
ylim([0 1.0]); %yticks([0 0.1 0.2 0.3]);
xlabel('Mean Obs SWE (m)');
ylabel('Model SWE (m)');
text(0.40, 0.05, ['MAE (cm) = ' num2str(round(MAEswe,2)*100)],'fontSize',16);
text(0.40, 0.10, ['RMSE (cm) = ' num2str(round(RMSEswe,2)*100)],'fontSize',16);
text(0.40, 0.15, ['NSE = ' num2str(round(NSEswe,2))],'fontSize',16);
text(0.40, 0.20, ['IDA = ' num2str(round(IDAswe,2))],'fontSize',16);
text(0.40, 0.25, ['KGE = ' num2str(round(KGEswe,2))],'fontSize',16);
text(0.40, 0.30, ['MBE (cm) = ' num2str(round(MBEswe,2)*100)],'fontSize',16);
hold on;
x = 0:50:500; y = 0:50:500; plot(x,y,'k:');
ax=gca;
ax.FontName = 'Helvetica Neue';
ax.FontSize = 20;
caxis;
cb=colorbar;
cb.Label.String = 'Water Year (Days)';
cb.FontSize = 14;
hold off
subtitle(title);
end

function [ax,h]=subtitle(text)
%
%Centers a title over a group of subplots.
%Returns a handle to the title and the handle to an axis.
% [ax,h]=subtitle(text)
%           returns handles to both the axis and the title.
% ax=subtitle(text)
%           returns a handle to the axis only.
ax=axes('Units','Normal','Position',[.075 .075 .85 .85],'Visible','off');
set(get(ax,'Title'),'Visible','on')
t = title(text,'Interpreter','none');
t.FontSize = 28;
if (nargout < 2)
    return
end
h=get(ax,'Title');
end

