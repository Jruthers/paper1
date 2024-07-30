%% Default Snowdown SR RCP 4.5
% Clear existing data and load new data
close all  % Close all open figures
clearvars  % Clear all variables from the workspace
load("SR_45.mat")  % Load the dataset from a .mat file

% Create copies of the data for specific years
SRi_J_2046sum = SRi_2046sum;
SRi_J_2096sum = SRi_2096sum;

% Plot setup
figure('Position', [100, 100, 650, 450]);  % Create a new figure with specified size
subplot(2, 2, 1)  % Create a subplot (2x2 grid, first plot)

% Plot snow accumulation data for 2046
% Find the date when accumulation stops
ix = find(diff(SRi_J_2046sum) == 0);  % Find rows where the difference between consecutive values is 0
ix2 = find(ix > 200);  % Exclude rows pertaining to the start of snow season
ix3 = min(ix(ix2));  % Find the earliest date where snow accumulation stops
p1 = plot([1:ix3], (SRi_J_2046sum(1:ix3, 1)), 'black', 'LineWidth', 2);  % Plot the data up to the earliest stop date
hold on

% Plot snow accumulation data for 2096
% Find the date when accumulation stops
ix = find(diff(SRi_J_2096sum) == 0);  % Find rows where the difference between consecutive values is 0
ix2 = find(ix > 200);  % Exclude rows pertaining to the start of snow season
ix3 = min(ix(ix2));  % Find the earliest date where snow accumulation stops
p2 = plot([1:ix3], (SRi_J_2096sum(1:ix3, 1)), 'red', 'LineWidth', 2);  % Plot the data up to the earliest stop date

% Additional plot settings
set(gca, 'xtick', [0:20:304]);  % Set x-axis ticks at intervals of 20
hold on
xlim([0 300])  % Set x-axis limits
xtickangle(45)  % Rotate x-axis tick labels by 45 degrees

%% Sturm Snowdown SR RCP 4.5
%the above section is repeated for the sturm data
load("SR_Sturm_45.mat")

SRi_S_2046sum = SRi_2046sum;
SRi_S_2096sum = SRi_2096sum;

hold on
ix=find(diff(SRi_S_2046sum)==0); % find rows where the difference between consectiuve vals =0
ix2=find(ix > 200); % cuts off rows pertaining to start of snow season
ix3=min(ix(ix2)); % this finds the rows pertaining to end of season (i.e. >200) and then gets the minimum row (ie earliest snow off)
p3 = plot([1:ix3], (SRi_S_2046sum(1:ix3,1)), 'k--', LineWidth=2);
hold on
ix=find(diff(SRi_S_2096sum)==0); % find rows where the difference between consectiuve vals =0
ix2=find(ix > 200); % cuts off rows pertaining to start of snow season
ix3=min(ix(ix2)); % this finds the rows pertaining to end of season (i.e. >200) and then gets the minimum row (ie earliest snow off)
p4 = plot([1:ix3], (SRi_S_2096sum(1:ix3,1)), 'r--', LineWidth=2);
set(gca, 'xtick' ,[0:20:304]);
hold on
xlim([0 300])
ylim([0 60])
ylabeltext = ({"Cumulative CO_2 flux", "to the atmosphere (gC m^{-2})"});
ylabel(ylabeltext)
% ylabel('Cumulative Soil Respiration (gC/m^2/day)')
% xlabel('Days since 1^{st} Sep')
title('RCP 4.5')
legend([p1 p2 p3 p4], {'CORDEX-Jordan 2016-2046', 'CORDEX-Jordan 2066-2096', 'CORDEX-Sturm 2016-2046', 'CORDEX-Sturm 2066-2096'}, "Location", "southeast", 'FontSize', 7);
%% Default Snowdown SR RCP 8.5
%the above sections are repeated for each subplot
clearvars
load("SR_85.mat")

SRi_J_2046sum = SRi_2046sum;
SRi_J_2096sum = SRi_2096sum;

subplot(2,2,2)
ix=find(diff(SRi_J_2046sum)==0); % find rows where the difference between consectiuve vals =0
ix2=find(ix > 200); % cuts off rows pertaining to start of snow season
ix3=min(ix(ix2)); % this finds the rows pertaining to end of season (i.e. >200) and then gets the minimum row (ie earliest snow off)
p3 = plot([1:ix3], (SRi_J_2046sum(1:ix3,1)), 'k-', LineWidth=2);
hold on
ix=find(diff(SRi_J_2096sum)==0); % find rows where the difference between consectiuve vals =0
ix2=find(ix > 200); % cuts off rows pertaining to start of snow season
ix3=min(ix(ix2)); % this finds the rows pertaining to end of season (i.e. >200) and then gets the minimum row (ie earliest snow off)
p4 = plot([1:ix3], (SRi_J_2096sum(1:ix3,1)), 'r-', LineWidth=2);
set(gca, 'xtick' ,[0:20:304]);
hold on
xlim([0 300])
xtickangle(45)
%% Sturm Snowdown SR RCP 8.5
load("SR_Sturm_85.mat")

SRi_S_2046sum = SRi_2046sum;
SRi_S_2096sum = SRi_2096sum;

hold on
ix=find(diff(SRi_S_2046sum)==0); % find rows where the difference between consectiuve vals =0
ix2=find(ix > 200); % cuts off rows pertaining to start of snow season
ix3=min(ix(ix2)); % this finds the rows pertaining to end of season (i.e. >200) and then gets the minimum row (ie earliest snow off)
p3 = plot([1:ix3], (SRi_S_2046sum(1:ix3,1)), 'k--', LineWidth=2);
hold on
ix=find(diff(SRi_S_2096sum)==0); % find rows where the difference between consectiuve vals =0
ix2=find(ix > 200); % cuts off rows pertaining to start of snow season
ix3=min(ix(ix2)); % this finds the rows pertaining to end of season (i.e. >200) and then gets the minimum row (ie earliest snow off)
p4 = plot([1:ix3], (SRi_S_2096sum(1:ix3,1)), 'r--', LineWidth=2);
set(gca, 'xtick' ,[0:20:304]);
hold on
ylim([0 60])
xlim([0 300])
% xlabel('Days since 1^{st} Sep')
title('RCP 8.5')
%% Default Snowdown FCH4 RCP 4.5
clearvars
load("FCH4_45.mat")
FCH4i_J_2046sum = FCH4i_2046sum;
FCH4i_J_2096sum = FCH4i_2096sum;

load("FCH4_45.mat")
subplot(2,2,3)
ix=find(diff(FCH4i_J_2046sum)==0); % find rows where the difference between consectiuve vals =0
ix2=find(ix > 200); % cuts off rows pertaining to start of snow season
ix3=min(ix(ix2)); % this finds the rows pertaining to end of season (i.e. >200) and then gets the minimum row (ie earliest snow off)
p3 = plot([1:ix3], (FCH4i_J_2046sum(1:ix3,1)), 'k-', LineWidth=2);
hold on
ix=find(diff(FCH4i_J_2096sum)==0); % find rows where the difference between consectiuve vals =0
ix2=find(ix > 200); % cuts off rows pertaining to start of snow season
ix3=min(ix(ix2)); % this finds the rows pertaining to end of season (i.e. >200) and then gets the minimum row (ie earliest snow off)
p4 = plot([1:ix3], (FCH4i_J_2096sum(1:ix3,1)), 'r-', LineWidth=2);
set(gca, 'xtick' ,[0:20:304]);
hold on
xlim([0 300])
xtickangle(45)
%% Sturm Snowdown FCH4 RCP 4.5
load("FCH4_Sturm_45.mat")

FCH4i_S_2046sum = FCH4i_2046sum;
FCH4i_S_2096sum = FCH4i_2096sum;

hold on
ix=find(diff(FCH4i_S_2046sum)==0); % find rows where the difference between consectiuve vals =0
ix2=find(ix > 200); % cuts off rows pertaining to start of snow season
ix3=min(ix(ix2)); % this finds the rows pertaining to end of season (i.e. >200) and then gets the minimum row (ie earliest snow off)
p3 = plot([1:ix3], (FCH4i_S_2046sum(1:ix3,1)), 'k--', LineWidth=2);
hold on
ix=find(diff(FCH4i_S_2096sum)==0); % find rows where the difference between consectiuve vals =0
ix2=find(ix > 200); % cuts off rows pertaining to start of snow season
ix3=min(ix(ix2)); % this finds the rows pertaining to end of season (i.e. >200) and then gets the minimum row (ie earliest snow off)
p4 = plot([1:ix3], (FCH4i_S_2096sum(1:ix3,1)), 'r--', LineWidth=2);
set(gca, 'xtick' ,[0:20:304]);
hold on
xlim([0 300])
ylim([0 1.5])
ylabeltext = ({"Cumulative CH_4 flux", "to the atmosphere (gC m^{-2})"});
ylabel(ylabeltext)
% ylabel('Cumulative Soil Respiration (gC/m^2/day)')
xlabel('Days since 1^{st} Sep')
% legend([p1 p2 p3 p4], {'Default 2016-2046', 'Default 2066-2096', 'Sturm 2016-2046', 'Sturm 2066-2096'}, Location="southeast");
%% Default Snowdown FCH4 RCP 8.5
clearvars
load("FCH4_85.mat")

FCH4i_J_2046sum = FCH4i_2046sum;
FCH4i_J_2096sum = FCH4i_2096sum;

subplot(2,2,4)
ix=find(diff(FCH4i_J_2046sum)==0); % find rows where the difference between consectiuve vals =0
ix2=find(ix > 200); % cuts off rows pertaining to start of snow season
ix3=min(ix(ix2)); % this finds the rows pertaining to end of season (i.e. >200) and then gets the minimum row (ie earliest snow off)
p3 = plot([1:ix3], (FCH4i_J_2046sum(1:ix3,1)), 'k-', LineWidth=2);
hold on
ix=find(diff(FCH4i_J_2096sum)==0); % find rows where the difference between consectiuve vals =0
ix2=find(ix > 200); % cuts off rows pertaining to start of snow season
ix3=min(ix(ix2)); % this finds the rows pertaining to end of season (i.e. >200) and then gets the minimum row (ie earliest snow off)
p4 = plot([1:ix3], (FCH4i_J_2096sum(1:ix3,1)), 'r-', LineWidth=2);
set(gca, 'xtick' ,[0:20:304]);
hold on
xlim([0 300])
%% Sturm Snowdown FCH4 RCP 8.5
load("FCH4_Sturm_85.mat")

FCH4i_S_2046sum = FCH4i_2046sum;
FCH4i_S_2096sum = FCH4i_2096sum;

hold on
ix=find(diff(FCH4i_S_2046sum)==0); % find rows where the difference between consectiuve vals =0
ix2=find(ix > 200); % cuts off rows pertaining to start of snow season
ix3=min(ix(ix2)); % this finds the rows pertaining to end of season (i.e. >200) and then gets the minimum row (ie earliest snow off)
p3 = plot([1:ix3], (FCH4i_S_2046sum(1:ix3,1)), 'k--', LineWidth=2);
hold on
ix=find(diff(FCH4i_S_2096sum)==0); % find rows where the difference between consectiuve vals =0
ix2=find(ix > 200); % cuts off rows pertaining to start of snow season
ix3=min(ix(ix2)); % this finds the rows pertaining to end of season (i.e. >200) and then gets the minimum row (ie earliest snow off)
p4 = plot([1:ix3], (FCH4i_S_2096sum(1:ix3,1)), 'r--', LineWidth=2);
set(gca, 'xtick' ,[0:20:304]);
hold on
ylim([0 1.5])
xlim([0 300])
xtickangle(45)
xlabel('Days since 1^{st} Sep')
%% plot options
annotation('textbox', [0.433448784376245 0.869630549190156 0.0329015544041451 0.0536062378167641], 'String', '(a)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')
annotation('textbox', [0.874316859306496 0.869630549190156 0.0334196891191709 0.0536062378167641], 'String', '(b)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')
annotation('textbox', [0.433448784376245 0.396297215856823 0.0329015544041451 0.053606237816764], 'String', '(c)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')
annotation('textbox', [0.874316859306496 0.396297215856823 0.0334196891191711 0.0536062378167641], 'String', '(d)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')
%% save plot
set(gcf, 'Position', [100 200 1150 850]);
fontsize(15,'points')
legendObj = findobj(gcf, 'Type', 'Legend');
fs=8;
set(legendObj, 'FontSize', fs);
%% figure export
exportgraphics(gcf, "cumu.pdf", "Resolution",300)