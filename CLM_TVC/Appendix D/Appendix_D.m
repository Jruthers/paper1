%% Subplot 1 
%Default Snowdown SR RCP 4.5
close all
clearvars
load("SR_45.mat")

SRi_J_2046sum = SRi_2046sum;
SRi_J_2096sum = SRi_2096sum;

figure('Position', [100, 100, 650, 450]);
subplot(2,2,1)

% this script finds the date when accumulation stops and stops the plotting
% there
ix=find(diff(SRi_J_2046sum)==0); % find rows where the difference between consectiuve vals =0
ix2=find(ix > 200); % cuts off rows pertaining to start of snow season
ix3=min(ix(ix2)); % this finds the rows pertaining to end of season (i.e. >200) and then gets the minimum row (ie earliest snow off)
p1 = plot([1:ix3], (SRi_J_2046sum(1:ix3,1)), 'black', LineWidth=2);
hold on
ix=find(diff(SRi_J_2096sum)==0); % find rows where the difference between consectiuve vals =0
ix2=find(ix > 200); % cuts off rows pertaining to start of snow season
ix3=min(ix(ix2)); % this finds the rows pertaining to end of season (i.e. >200) and then gets the minimum row (ie earliest snow off)
p2 = plot([1:ix3], (SRi_J_2096sum(1:ix3,1)), 'red', LineWidth=2);

%further plot options
set(gca, 'xtick' ,[0:20:304]);
hold on
xlim([0 300])

% Sturm snowdown SR RCP 4.5
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
hold on
xlim([0 300])
ylim([0 60])
ylabeltext = ({"Cumulative CO_2 flux", "to the atmosphere (gC m^-2)"});
ylabel(ylabeltext)
% ylabel('Cumulative Soil Respiration (gC/m^2/day)')
% xlabel('Days since 1^{st} Sep')
title('RCP 4.5')
% legend([p1 p2 p3 p4], {'CORDEX-Jordan 2016-2046', 'CORDEX-Jordan 2066-2096', 'CORDEX-Sturm 2016-2046', 'CORDEX-Sturm 2066-2096'}, "Location", "northwest", 'FontSize', 7);

clearvars -except p1 p2 p3 p4
load("SR_IR_45.mat")
p5 = plot(SRi_2046sum, 'Color', [0.4660    0.6740    0.1880]);
p6 = plot(SRi_2096sum, 'Color', [0.3010    0.7450    0.9330]);
ylim([0 250])

clearvars -except p1 p2 p3 p4 p5 p6
load("SR_IR_Sturm_45.mat")
p7 = plot(SRi_2046sum, 'Color', [0.4660    0.6740    0.1880], 'LineStyle', '--');
p8 = plot(SRi_2096sum, 'Color', [0.3010    0.7450    0.9330], 'LineStyle', '--');
xticklabels([])
legend([p1 p2 p3 p4 p5 p6 p7 p8], {'Snow-down CORDEX-Jordan 2016-2046', 'Snow-down CORDEX-Jordan 2066-2096', 'Snow-down CORDEX-Sturm 2016-2046', 'Snow-down CORDEX-Sturm 2066-2096', 'CORDEX-Jordan 2016-2046', 'CORDEX-Jordan 2066-2096', 'CORDEX-Sturm 2016-2046', 'CORDEX-Sturm 2066-2096'}, "Location", "northwest", 'FontSize', 7);

%% Subplot 2
% Default Snowdown SR RCP 8.5
clearvars
load("SR_85.mat")

SRi_J_2046sum = SRi_2046sum;
SRi_J_2096sum = SRi_2096sum;

subplot(2,2,2)

% this script finds the date when accumulation stops and stops the plotting
% there
ix=find(diff(SRi_J_2046sum)==0); % find rows where the difference between consectiuve vals =0
ix2=find(ix > 200); % cuts off rows pertaining to start of snow season
ix3=min(ix(ix2)); % this finds the rows pertaining to end of season (i.e. >200) and then gets the minimum row (ie earliest snow off)
p1 = plot([1:ix3], (SRi_J_2046sum(1:ix3,1)), 'black', LineWidth=2);
hold on
ix=find(diff(SRi_J_2096sum)==0); % find rows where the difference between consectiuve vals =0
ix2=find(ix > 200); % cuts off rows pertaining to start of snow season
ix3=min(ix(ix2)); % this finds the rows pertaining to end of season (i.e. >200) and then gets the minimum row (ie earliest snow off)
p2 = plot([1:ix3], (SRi_J_2096sum(1:ix3,1)), 'red', LineWidth=2);

%further plot options
set(gca, 'xtick' ,[0:20:304]);
hold on
xlim([0 300])

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
xlim([0 300])
ylim([0 60])
title('RCP 8.5')

clearvars
load("SR_IR_85.mat")
p5 = plot(SRi_2046sum, 'Color', [0.4660    0.6740    0.1880]);
p6 = plot(SRi_2096sum, 'Color', [0.3010    0.7450    0.9330]);
ylim([0 250])

clearvars
load("SR_IR_Sturm_85.mat")
p7 = plot(SRi_2046sum, 'Color', [0.4660    0.6740    0.1880], 'LineStyle', '--');
p8 = plot(SRi_2096sum, 'Color', [0.3010    0.7450    0.9330], 'LineStyle', '--');
xticklabels([])

%% Subplot 3
% Default Snowdown FCH4 RCP 4.5
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

% Sturm Snowdown FCH4 RCP 4.5
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
ylabeltext = ({"Cumulative CH_4 flux", "to the atmosphere (gC m^-2)"});
ylabel(ylabeltext)
% ylabel('Cumulative Soil Respiration (gC/m^2/day)')
xlabel('Days since 1^{st} Sep')

clearvars
load("FCH4_IR_45.mat")
p5 = plot(FCH4i_2046sum, 'Color', [0.4660    0.6740    0.1880]);
p6 = plot(FCH4i_2096sum, 'Color', [0.3010    0.7450    0.9330]);

clearvars
load("FCH4_IR_STURM_45.mat")
p5 = plot(FCH4i_2046sum, 'Color', [0.4660    0.6740    0.1880], 'LineStyle', '--');
p6 = plot(FCH4i_2096sum, 'Color', [0.3010    0.7450    0.9330], 'LineStyle', '--');
ylim([0 15])

%% Subplot 4
% Default Snowdown FCH4 RCP 8.5
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

% Sturm Snowdown FCH4 RCP 8.5
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
xlim([0 300])
xlabel('Days since 1^{st} Sep')

clearvars
load("FCH4_IR_85.mat")
p5 = plot(FCH4i_2046sum, 'Color', [0.4660    0.6740    0.1880]);
p6 = plot(FCH4i_2096sum, 'Color', [0.3010    0.7450    0.9330]);

clearvars
load("FCH4_IR_STURM_85.mat")
p5 = plot(FCH4i_2046sum, 'Color', [0.4660    0.6740    0.1880], 'LineStyle', '--');
p6 = plot(FCH4i_2096sum, 'Color', [0.3010    0.7450    0.9330], 'LineStyle', '--');
ylim([0 15])

