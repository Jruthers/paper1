%% SR JORDAN RCP 4.5
load("SR_45.mat")
tiledlayout(2,2, "TileSpacing","compact")
nexttile
hold on
SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'blue', "FaceAlpha", 0.2, "LineStyle", "none");
hold on
default = plot(medianSWE,'blue');
box on
xticks(1:10:85)
xlim([0 84])
ylim([0 1])
ylabeltext = ({'CO_2 flux', 'to atmosphere (gC/m^2/day)'});
ylabel(ylabeltext)
fontsize(15,'points')

%% SR STURM RCP 4.5
load("SR_Sturm_45.mat")
% plot
hold on
sturm = plot(medianSWE,'red');
box on
x1=[1:84];
hold on
SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'red', "FaceAlpha", 0.2, "LineStyle", "none");

% plot options
legend([default, sturm],"CORDEX-Jordan", "CORDEX-Sturm", Location="northwest", FontSize=7)
xticks(1:10:85)
xticklabels([])
xlim([1 84])
ylim([0 0.8])
title('RCP 4.5')
fontsize(15,'points')
%% SR JORDAN RCP 8.5
load("SR_85.mat")
% plot options
nexttile
hold on
SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'blue', "FaceAlpha", 0.2, "LineStyle", "none");
hold on
plot(medianSWE,'blue')
box on
xticks(1:10:85)
ylim([0 1])
fontsize(15,'points')
%% SR STURM RCP 8.5
load("SR_Sturm_85.mat")
hold on
SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'red', "FaceAlpha", 0.2, "LineStyle", "none");
hold on
plot(medianSWE,'red')
box on
x1=[1:84];
xticks(1:10:85)
xticklabels([])
xlim([1 84])
ylim([0 0.8])
title('RCP 8.5')
fontsize(15,'points')
%% FCH4 JORDAN RCP 8.5
load("FCH4_45.mat");
nexttile
hold on
SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'blue', "FaceAlpha", 0.2, "LineStyle", "none");
hold on
default = plot(medianSWE,'blue');
box on
xticks(1:10:85)
xlim([0 84])
ylim([0 0.015])
ylabeltext = ({'CH_4 flux', 'to atmosphere (gC/m^2/day)'});
ylabel(ylabeltext)
fontsize(15,'points')
%% FCH4 STURM RCP 4.5
load("FCH4_Sturm_45.mat");
% plot
hold on
SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'red', "FaceAlpha", 0.2, "LineStyle", "none");
hold on
sturm = plot(medianSWE,'red');
box on
% plot options
% legend([default, sturm],"Default", "Sturm", Location="northeast", FontSize=7)
xticks(1:10:85)
xticklabels(UNIQUE_YR(1:10:85,1))
xlim([1 84])
% title('RCP4.5')
fontsize(15,'points')
%% FCH4 JORDAN RCP 8.5
load("FCH4_85.mat")
nexttile
hold on
SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'blue', "FaceAlpha", 0.2, "LineStyle", "none");
hold on
plot(medianSWE,'blue')
box on
xticks([1:10:85])
xticklabels(UNIQUE_YR([1:10:85],1))
fontsize(15,'points')
%% 
load("FCH4_Sturm_85.mat");
hold on
SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'red', "FaceAlpha", 0.2, "LineStyle", "none");
hold on
plot(medianSWE,'red');
box on
xticks(1:10:85);
xticklabels(UNIQUE_YR(1:10:85,1));
xlim([1 84])
ylim([0 0.015])
fontsize(15,'points')
%% letters
annotation('textbox', [0.450392115656364 0.862744983161598 0.0329015544041452 0.0536062378167641], 'String', '(a)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')
annotation('textbox', [0.88095322294286 0.862744983161598 0.0334196891191709 0.0536062378167641], 'String', '(b)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')
annotation('textbox', [0.450392115656364 0.418963882523489 0.0329015544041451 0.053606237816764], 'String', '(c)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')
annotation('textbox', [0.88095322294286 0.418963882523489 0.0334196891191711 0.053606237816764], 'String', '(d)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')
%% save plot
set(gcf, 'Position', [271 310 1375 608]);
%% optional figure export
cd C:\Users\jadru\'OneDrive - Northumbria University - Production Azure AD'\Documents\Figures\'CLM STURM' 
exportgraphics(gcf, "jordan_vs_sturm.jpg", "Resolution",300)