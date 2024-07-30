clear all
close all
load("Figure 1 and 2/T_P_45.mat")
%% create precip subsets
clear Precip20162046
clearvars indicestoget presentday dimens dataout
precip45 = figure();
precip45.Position=[100 10 1700 1000]
m12=[1:0.2:12];
for i=3:8
for m=1:12 
indicestoget=find(HPCMonthlyPtot2090(:,1) >= 2016 & HPCMonthlyPtot2090(:,1) <= 2046 & HPCMonthlyPtot2090(:,2)==m); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=HPCMonthlyPtot2090(indicestoget,:); % extract specific rows
dimens=size(presentday(:,i)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,i),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
Precip20162046(:,m)=dataout; % store in new variable
end
hold on
medians1990 = median(Precip20162046(:,1:12));
p12_1990=interp1([1:12],medians1990,m12,'cubic');
sub1 = subplot(2,2,1);
int1990 = plot(m12, p12_1990, 'LineWidth',2);
end
xlim([1 12])
ylim([0 100])
ylabel("Precipitation (mm w.e.)")
title("2016 - 2046")
xticklabels([])
set(gca, 'FontSize', 20)
% for 2070-2100
clear Precip20662096
for i=3:8
for m=1:12
indicestoget=find(HPCMonthlyPtot2090(:,1) >= 2066 & HPCMonthlyPtot2090(:,1) <= 2096 & HPCMonthlyPtot2090(:,2)==m);
presentday=HPCMonthlyPtot2090(indicestoget,:);
dimens=size(presentday(:,i));
dataout=reshape(presentday(:,i),dimens(1,1)*dimens(1,2),1);
Precip20662096(:,m)=dataout;
end
hold on
medians2060 = median(Precip20662096(:,1:12));
p12_2060=interp1([1:12],medians2060,m12,'cubic');
subplot(2,2,2)
int2060 = plot(m12, p12_2060, 'LineWidth',2);
end
xlim([1 12])
ylim([0 100])
title("2066 - 2096")
xticklabels([])
set(gca, 'FontSize', 20)
% Create a cell array to store custom legend labels
legendLabels = cell(size(FilesList));

% Extract the desired part of each filename
for i = 1:numel(FilesList)
    % Find the position of "rcp45." in the filename
    rcp45_start = strfind(FilesList(i).name, 'rcp45.') + length('rcp45.');
    
    % Find the position of ".csv" in the filename
    csv_end = strfind(FilesList(i).name, '.csv') - 1;
    
    % Extract the desired part of the filename
    legendLabels{i} = FilesList(i).name(rcp45_start:csv_end);
end


leg = legend(legendLabels,'FontSize',6, 'Location', 'northwest');
set(leg, 'box', 'off')
set(leg,'Position',[0.1325 0.769678896489345 0.12 0.0989880716829669],...
    'FontSize',5);
sgtitle("RCP 4.5", 'FontSize', 25)
%% RCP 8.5
clear all
load("Figure 1 and 2/T_P_85.mat")
%% create precip subsets
clear Precip20162046
clearvars indicestoget presentday dimens dataout

m12=[1:0.2:12];
for i=3:29
for m=1:12 
indicestoget=find(HPCMonthlyPtot2090(:,1) >= 2016 & HPCMonthlyPtot2090(:,1) <= 2046 & HPCMonthlyPtot2090(:,2)==m); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=HPCMonthlyPtot2090(indicestoget,:); % extract specific rows
dimens=size(presentday(:,i)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,i),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
Precip20162046(:,m)=dataout; % store in new variable
end
hold on
medians1990 = median(Precip20162046(:,1:12));
p12_1990=interp1([1:12],medians1990,m12,'cubic');
sub2 = subplot(2,2,3);
int1990 = plot(m12, p12_1990, 'LineWidth',2);
end
xlim([1 12])
ylim([0 100])
ylabel("Precipitation (mm w.e.)")
set(gca, 'xtick',1:1:24, 'XTickLabels',{'Jan', 'Feb', 'Mar', 'Apr ', 'May ', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'})
set(gca, 'FontSize', 20)
% title("2016 - 2046")

% for 2070-2100
clear Precip20662096
for i=3:29
for m=1:12
indicestoget=find(HPCMonthlyPtot2090(:,1) >= 2066 & HPCMonthlyPtot2090(:,1) <= 2096 & HPCMonthlyPtot2090(:,2)==m);
presentday=HPCMonthlyPtot2090(indicestoget,:);
dimens=size(presentday(:,i));
dataout=reshape(presentday(:,i),dimens(1,1)*dimens(1,2),1);
Precip20662096(:,m)=dataout;
end
hold on
medians2060 = median(Precip20662096(:,1:12));
p12_2060=interp1([1:12],medians2060,m12,'cubic');
sub2 = subplot(2,2,4);
int2060 = plot(m12, p12_2060, 'LineWidth',2);
end

xlim([1 12])
ylim([0 100])
set(gca, 'xtick',1:1:24, 'XTickLabels',{'Jan', 'Feb', 'Mar', 'Apr ', 'May ', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'})
set(gca, 'FontSize', 20)
% title("2066 - 2096")

% Create a cell array to store custom legend labels
legendLabels = cell(size(FilesList));

% Extract the desired part of each filename
for i = 1:numel(FilesList)
    % Find the position of "rcp85." in the filename
    rcp85_start = strfind(FilesList(i).name, 'rcp85.') + length('rcp85.');
    
    % Find the position of ".csv" in the filename
    csv_end = strfind(FilesList(i).name, '.csv') - 1;
    
    % Extract the desired part of the filename
    legendLabels{i} = FilesList(i).name(rcp85_start:csv_end);
end


leg = legend(legendLabels,'FontSize',6, 'Location', 'northwest');
set(leg, 'box', 'off')
set(leg,...
    'Position',[-0.107704223632813 0.269122807805845 0.700704223632812 0.152631578947368],...
    'NumColumns',2,...
    'FontSize',5);
%% plot options
set(gcf, 'Position', [100 200 1000 850]);
annotation('textbox', [0.441448784376245 0.824517767235269 0.0329015544041451 0.0536062378167641], 'String', '(a)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')
annotation('textbox', [0.879316859306497 0.821510248438277 0.0334196891191709 0.0536062378167641], 'String', '(b)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')
annotation('textbox', [0.440448784376245 0.37374082487938 0.0329015544041451 0.053606237816764], 'String', '(c)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')
annotation('textbox', [0.878316859306497 0.372237065480883 0.0334196891191711 0.0536062378167642], 'String', '(d)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')
%% save plot
title("RCP 8.5", 'FontSize', 25, "FontWeight","normal")
exportgraphics(gcf, "members_precip.pdf", "Resolution",300)