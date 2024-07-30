%% SR
%% RCP4.5 q10 7.5 psimin -2
clearvars
close all
load("SR_45_7.5_-2.mat")
tiledlayout(4,2,"TileSpacing","compact")
nexttile(1)
lower1 = plot(medianSWE1, 'blue');
hold on
SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'blue', "FaceAlpha", 0.2, "LineStyle", "none");
hold on
%% RCP4.5 q10 1.5 psimin -20
clearvars -except lower1
load("SR_45_1.5_-20.mat")
upper1 = plot(medianSWE,'blue', 'LineStyle','--');
% hold on
SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'blue', "FaceAlpha", 0.2, "LineStyle", "none");
xlim([0 84])
ylim([0 1.5])
xticks([1:10:85])
xticklabels([])
ylabeltext = ({'CO_2 flux to', 'atmosphere (gC m^{-2} day^{-1})'});
ylabel(ylabeltext)
title('RCP 4.5')
leg1 = legend([lower1, upper1],"CORDEX-Jordan 7.5 -2", "CORDEX-Jordan 1.5 -20", Location="northwest", FontSize=10);
%% STURM RCP4.5 q10 7.5 psimin -2
clearvars
load("SR_45_Sturm_7.5_-2.mat")
nexttile(3)
low = plot(medianSWE1, 'r');
hold on
SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'r', "FaceAlpha", 0.2, "LineStyle", "none");
%% STURM RCP4.5 q10 1.5 psimin -20
clearvars -except low
load("SR_45_Sturm_1.5_-20.mat")
up = plot(medianSWE,'r', 'LineStyle','--');
hold on
% SWEX = [1:length(medianSWE1'), length(medianSWE'):-1:1];
% SWEY = [medianSWE1', fliplr(medianSWE')];
% f = fill(SWEX, SWEY, 'r', "FaceAlpha", 0.2, "LineStyle", "none");

SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'r', "FaceAlpha", 0.2, "LineStyle", "none");

leg2 = legend([low, up], {'CORDEX-Sturm 7.5 -2', 'CORDEX-Sturm 1.5 -20'}, 'Location', 'northwest', 'FontSize', 10);
%plot options
% set(gcf, 'Position', [100 200 1100 450]);
ylabeltext = ({'CO_2 flux to', 'atmosphere (gC m^{-2} day^{-1})'});
ylabel(ylabeltext)
box on
xticks([1:10:85])
xticklabels([])
xlim([0 84])
ylim([0 1.5])
%% RCP8.5 q10 7.5 psimin -2
load("SR_85_7.5_-2.mat")
nexttile(2)
% subplot(4,2,2)
lower1 = plot(medianSWE1, 'blue');
hold on
xticks([1:10:85])
SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'blue', "FaceAlpha", 0.2, "LineStyle", "none");
hold on
%% RCP8.5 q10 1.5 psimin -20
load("SR_85_1.5_-20.mat")
upper1 = plot(medianSWE,'blue', 'LineStyle','--');
% hold on
SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'blue', "FaceAlpha", 0.2, "LineStyle", "none");
% SWEX = [1:length(medianSWE1'), length(medianSWE'):-1:1];
% SWEY = [medianSWE1', fliplr(medianSWE')];
% f = fill(SWEX, SWEY, 'blue', "FaceAlpha", 0.2, "LineStyle", "none");
xlim([0 84])
ylim([0 1.5])
xticklabels([])
title('RCP 8.5')
%% STURM RCP8.5 q10 7.5 psimin -2
load("SR_85_Sturm_7.5_-2.mat")
nexttile(4)
% subplot(4,2,4)
low = plot(medianSWE1, 'r');
hold on
SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'r', "FaceAlpha", 0.2, "LineStyle", "none");
%% STURM RCP8.5 q10 1.5 psimin -20
load("SR_85_Sturm_1.5_-20.mat")
up = plot(medianSWE,'r', 'LineStyle','--');
hold on
% SWEX = [1:length(medianSWE1'), length(medianSWE'):-1:1];
% SWEY = [medianSWE1', fliplr(medianSWE')];
% f = fill(SWEX, SWEY, 'r', "FaceAlpha", 0.2, "LineStyle", "none");

SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'r', "FaceAlpha", 0.2, "LineStyle", "none");

%plot options
% set(gcf, 'Position', [100 200 1100 450]);
box on
xticks([1:10:85])
xticklabels([])
xlim([0 84])
ylim([0 1.5])
%% CH4
%% RCP4.5 q10 7.5 psimin -2 CH4Q10 4
clearvars
load("CH4_45_7.5_-2_4.mat")
nexttile(5)
% subplot(4,2,5)
lower1 = plot(medianSWE1, 'blue');
hold on
SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'blue', "FaceAlpha", 0.2, "LineStyle", "none");
hold on
%% RCP4.5 q10 1.5 psimin -20
clearvars -except lower1
load("CH4_45_1.5_-20.mat")
upper1 = plot(medianSWE,'blue', 'LineStyle','--');
% hold on
SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'blue', "FaceAlpha", 0.2, "LineStyle", "none");
% SWEX = [1:length(medianSWE1'), length(medianSWE'):-1:1];
% SWEY = [medianSWE1', fliplr(medianSWE')];
% f = fill(SWEX, SWEY, 'blue', "FaceAlpha", 0.2, "LineStyle", "none");
xlim([0 84])
ylim([0 0.015])
xticks([1:10:85])
xticklabels([])
ylabeltext = ({'CH_4 flux to', 'atmosphere (gC m^{-2} day^{-1})'});
ylabel(ylabeltext)
leg3 = legend([lower1, upper1],"CORDEX-Jordan 7.5 -2 4", "CORDEX-Jordan 1.5 -20 1.3", Location="northwest", FontSize=10);
%% STURM RCP4.5 q10 7.5 psimin -2 CH4Q10 4
clearvars
load("CH4_45_Sturm_7.5_-2_4.mat")
nexttile(7)
low = plot(medianSWE1, 'r');
hold on
SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'r', "FaceAlpha", 0.2, "LineStyle", "none");
%% STURM RCP4.5 q10 1.5 psimin -20
clearvars -except low
load("CH4_45_Sturm_1.5_-20.mat")
load("uniq_yr.mat")
up = plot(medianSWE,'r', 'LineStyle','--');
hold on
% SWEX = [1:length(medianSWE1'), length(medianSWE'):-1:1];
% SWEY = [medianSWE1', fliplr(medianSWE')];
% f = fill(SWEX, SWEY, 'r', "FaceAlpha", 0.2, "LineStyle", "none");

SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'r', "FaceAlpha", 0.2, "LineStyle", "none");

%plot options
% set(gcf, 'Position', [100 200 1100 450]);
ylabeltext = ({'CH_4 flux to', 'atmosphere (gC m^{-2} day^{-1})'});
ylabel(ylabeltext)
box on
xticks([1:10:85])
xticklabels(UNIQUE_YR([1:10:85],1))
xlim([0 84])
ylim([0 0.015])
leg4 = legend([low, up], {'CORDEX-Sturm 7.5 -2 4', 'CORDEX-Sturm 1.5 -20 1.3'}, 'Location', 'northwest', 'FontSize', 10);
%% RCP8.5 q10 7.5 psimin -2 CH4Q10 4
clearvars
load("CH4_85_7.5_-2_4.mat")
nexttile(6)
% subplot(4,2,6)
lower1 = plot(medianSWE1, 'blue');
hold on
SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'blue', "FaceAlpha", 0.2, "LineStyle", "none");
hold on
xticks([1:10:85])
xticklabels([])
xlim([0 84])
ylim([0 0.015])
%% RCP8.5 q10 1.5 psimin -20
clearvars
load("CH4_85_1.5_-20.mat")
hold on
upper1 = plot(medianSWE,'blue', 'LineStyle','--');
% hold on
SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'blue', "FaceAlpha", 0.2, "LineStyle", "none");
%% STURM RCP8.5 q10 7.5 psimin -2 CH4Q10 4
clearvars
load("CH4_85_Sturm_7.5_-2_4.mat")
nexttile(8)
low = plot(medianSWE1, 'r');
hold on
SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'r', "FaceAlpha", 0.2, "LineStyle", "none");
%% STURM RCP8.5 q10 1.5 psimin -20
clearvars
load("CH4_85_Sturm_1.5_-20.mat")
load("uniq_yr.mat")
hold on
up = plot(medianSWE,'r', 'LineStyle','--');
hold on
% SWEX = [1:length(medianSWE1'), length(medianSWE'):-1:1];
% SWEY = [medianSWE1', fliplr(medianSWE')];
% f = fill(SWEX, SWEY, 'r', "FaceAlpha", 0.2, "LineStyle", "none");

SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'r', "FaceAlpha", 0.2, "LineStyle", "none");

%plot options
set(gcf, 'Position', [583   138   806   799]);
box on
xticks([1:10:85])
xticklabels(UNIQUE_YR([1:10:85],1))
xlim([0 84])
ylim([0 0.015])

%% letters
annotation('textbox', [0.445149616220316 0.867852078208452 0.0329015544041451 0.0536062378167641], 'String', '(a)', 'EdgeColor', 'none', 'FontSize', 13, 'FontWeight', 'normal')
annotation('textbox', [0.868502963524858 0.863231620140625 0.0334196891191709 0.0536062378167641], 'String', '(b)', 'EdgeColor', 'none', 'FontSize', 13, 'FontWeight', 'normal')
annotation('textbox', [0.446111315393614 0.656906318935805 0.0329015544041451 0.0536062378167641], 'String', '(c)', 'EdgeColor', 'none', 'FontSize', 13, 'FontWeight', 'normal')
annotation('textbox', [0.873222908550723 0.662930415321348 0.0334196891191709 0.0536062378167641], 'String', '(d)', 'EdgeColor', 'none', 'FontSize', 13, 'FontWeight', 'normal')
annotation('textbox', [0.451353090165726 0.451049461001903 0.032901554404145 0.0536062378167642], 'String', '(e)', 'EdgeColor', 'none', 'FontSize', 13, 'FontWeight', 'normal')
annotation('textbox', [0.877223988533751 0.44608809507034 0.0292746113989637 0.0536062378167642], 'String', '(f)', 'EdgeColor', 'none', 'FontSize', 13, 'FontWeight', 'normal')
annotation('textbox', [0.448592704971778 0.238256769769136 0.0292746113989638 0.0536062378167641], 'String', '(g)', 'EdgeColor', 'none', 'FontSize', 13, 'FontWeight', 'normal')
annotation('textbox', [0.875704298128886 0.238256769769136 0.0292746113989638 0.0536062378167641], 'String', '(h)', 'EdgeColor', 'none', 'FontSize', 13, 'FontWeight', 'normal')


exportgraphics(gcf, "Appendix_E.pdf", "Resolution",300)

