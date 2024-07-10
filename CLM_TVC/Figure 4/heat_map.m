%% Change directory
close all
clearvars
load("TSOI_45_P.mat")
%plot layout
figure('Renderer', 'Painters')
tiledlayout(2,4)
nexttile(1)

% set the soil layers according to their depth 
y=-1*[0.020 0.060 0.120 0.200 0.320... 	
0.480 0.680 0.920 1.200 1.520... 	
1.880 2.280 2.720 3.260 3.900 4.640 5.480 6.420 7.460... 	
8.600 10.990 15.666 23.301 34.441 49.556]';
pcolor([1:366],(y(1:21)),(GTmedian1depth_P1(1:21,:))); shading interp; colormap parula %create a colour heatmap from daily data
hold on
clim([min(GTmedian1depth_P1(:)) max(GTmedian1depth_P1(:))]); %set the colour threshold to this figure
c1 = contour([1:366],(y(1:21)),(GTmedian1depth_P1(1:21,:)),[0.75 0.75], '-k', 'LineWidth', 2); %add contour lines for the zero-curtain
hold on
c2 = contour([1:366],(y(1:21)),(GTmedian1depth_P1(1:21,:)),[-0.75 -0.75], '--k', 'LineWidth', 2);

%other plot options
xlim([1 365])
ylim([-11 0])
title('2016-2046', 'FontWeight','bold');
ytext = {'Soil Depth (m)'};
ylabel(ytext);
xticklabels([])
%% default rcp45 future
clearvars -except GTmedian1depth_P1
load("TSOI_45_F.mat")
% subplot(2,2,2)
nexttile(2)
y=-1*[0.020 0.060 0.120 0.200 0.320... 	
0.480 0.680 0.920 1.200 1.520... 	
1.880 2.280 2.720 3.260 3.900 4.640 5.480 6.420 7.460... 	
8.600 10.990 15.666 23.301 34.441 49.556]';
pcolor([1:366],(y(1:21)),(GTmedian1depth_F(1:21,:))); shading interp; colormap parula
hold on
c1 = contour([1:366],(y(1:21)),(GTmedian1depth_F(1:21,:)),[0.75 0.75], '-k', 'LineWidth', 2);
hold on
c2 = contour([1:366],(y(1:21)),(GTmedian1depth_F(1:21,:)),[-0.75 -0.75], '--k', 'LineWidth', 2);
xlim([1 365])
ylim([-11 0])
% x_low = c1(1, 2:end);
% y_low = c1(2, 2:end);
% x_high = c2(1, 2:end);
% y_high = c2(2, 2:end);
% fill([x_low, flip(x_high)], [y_low, flip(y_high)], 'k', 'EdgeColor', 'none');

% contour([1:366],(y(1:20)),(GTmedian1depth_F(1:20,:)),[0 0],'k-','LineWidth',2)
clim([min(GTmedian1depth_P1(:)) max(GTmedian1depth_P1(:))]);
title('2066-2096', 'FontWeight','bold')
xticklabels([])
%% sturm rcp45 present 
load("TSOI_Sturm_45_P.mat")
% subplot(2,2,3)
nexttile(5)
y=-1*[0.020 0.060 0.120 0.200 0.320... 	
0.480 0.680 0.920 1.200 1.520... 	
1.880 2.280 2.720 3.260 3.900 4.640 5.480 6.420 7.460... 	
8.600 10.990 15.666 23.301 34.441 49.556]';
pcolor([1:366],(y(1:21)),(GTmedian1depth_P(1:21,:))); shading interp; colormap parula
hold on
c1 = contour([1:366],(y(1:21)),(GTmedian1depth_P(1:21,:)),[0.75 0.75], '-k', 'LineWidth', 2);
hold on
c2 = contour([1:366],(y(1:21)),(GTmedian1depth_P(1:21,:)),[-0.75 -0.75], '--k', 'LineWidth', 2);
xlim([1 365])
ylim([-11 0])

clim([min(GTmedian1depth_P1(:)) max(GTmedian1depth_P1(:))]);
ylabel({'Soil Depth (m)'})
%% sturm rcp45 future
load("TSOI_Sturm_45_F.mat")
% subplot(2,2,4)
nexttile(6)
y=-1*[0.020 0.060 0.120 0.200 0.320... 	
0.480 0.680 0.920 1.200 1.520... 	
1.880 2.280 2.720 3.260 3.900 4.640 5.480 6.420 7.460... 	
8.600 10.990 15.666 23.301 34.441 49.556]';
pcolor([1:366],(y(1:21)),(GTmedian1depth_F(1:21,:))); shading interp; colormap parula
hold on
c1 = contour([1:366],(y(1:21)),(GTmedian1depth_F(1:21,:)),[0.75 0.75], '-k', 'LineWidth', 2);
hold on
c2 = contour([1:366],(y(1:21)),(GTmedian1depth_F(1:21,:)),[-0.75 -0.75], '--k', 'LineWidth', 2);
xlim([1 365])
ylim([-11 0])

clim([min(GTmedian1depth_P1(:)) max(GTmedian1depth_P1(:))]);
%% default rcp85 present 
load("TSOI_85_P.mat")
nexttile(3)
y=-1*[0.020 0.060 0.120 0.200 0.320... 	
0.480 0.680 0.920 1.200 1.520... 	
1.880 2.280 2.720 3.260 3.900 4.640 5.480 6.420 7.460... 	
8.600 10.990 15.666 23.301 34.441 49.556]';
pcolor([1:366],(y(1:21)),(GTmedian1depth_P2(1:21,:))); shading interp; colormap parula
hold on
c1 = contour([1:366],(y(1:21)),(GTmedian1depth_P2(1:21,:)),[0.75 0.75], '-k', 'LineWidth', 2);
hold on
c2 = contour([1:366],(y(1:21)),(GTmedian1depth_P2(1:21,:)),[-0.75 -0.75], '--k', 'LineWidth', 2);
xlim([1 365])
ylim([-11 0])

clim([min(GTmedian1depth_P1(:)) max(GTmedian1depth_P1(:))]);
title('2016-2046', 'FontWeight','bold');
xticklabels([])
% ylabel('Soil Depth (m)')
%% default rcp85 future
load("TSOI_85_F.mat")
% subplot(2,2,2)
nexttile(4)
y=-1*[0.020 0.060 0.120 0.200 0.320... 	
0.480 0.680 0.920 1.200 1.520... 	
1.880 2.280 2.720 3.260 3.900 4.640 5.480 6.420 7.460... 	
8.600 10.990 15.666 23.301 34.441 49.556]';
pcolor([1:366],(y(1:21)),(GTmedian1depth_F(1:21,:))); shading interp; colormap parula
hold on
c1 = contour([1:366],(y(1:21)),(GTmedian1depth_F(1:21,:)),[0.75 0.75], '-k', 'LineWidth', 2);
hold on
c2 = contour([1:366],(y(1:21)),(GTmedian1depth_F(1:21,:)),[-0.75 -0.75], '--k', 'LineWidth', 2);
xlim([1 365])
ylim([-11 0])

clim([min(GTmedian1depth_P1(:)) max(GTmedian1depth_P1(:))]);
title('2066-2096', 'FontWeight','bold')
xticklabels([])
%% sturm rcp85 present 
load("TSOI_Sturm_85_P.mat")
nexttile(7)
y=-1*[0.020 0.060 0.120 0.200 0.320... 	
0.480 0.680 0.920 1.200 1.520... 	
1.880 2.280 2.720 3.260 3.900 4.640 5.480 6.420 7.460... 	
8.600 10.990 15.666 23.301 34.441 49.556]';
pcolor([1:366],(y(1:21)),(GTmedian1depth_P(1:21,:))); shading interp; colormap parula
hold on
c1 = contour([1:366],(y(1:21)),(GTmedian1depth_P(1:21,:)),[0.75 0.75], '-k', 'LineWidth', 2);
hold on
c2 = contour([1:366],(y(1:21)),(GTmedian1depth_P(1:21,:)),[-0.75 -0.75], '--k', 'LineWidth', 2);
xlim([1 365])
ylim([-11 0])

clim([min(GTmedian1depth_P1(:)) max(GTmedian1depth_P1(:))]);

%% Sturm rcp85 future
load("TSOI_Sturm_85_F.mat")
nexttile(8)
y=-1*[0.020 0.060 0.120 0.200 0.320... 	
0.480 0.680 0.920 1.200 1.520... 	
1.880 2.280 2.720 3.260 3.900 4.640 5.480 6.420 7.460... 	
8.600 10.990 15.666 23.301 34.441 49.556]';
pcolor([1:366],(y(1:21)),(GTmedian1depth_F(1:21,:))); shading interp; colormap parula 
hold on
c1 = contour([1:366],(y(1:21)),(GTmedian1depth_F(1:21,:)),[0.75 0.75], '-k', 'LineWidth', 2);
hold on
c2 = contour([1:366],(y(1:21)),(GTmedian1depth_F(1:21,:)),[-0.75 -0.75], '--k', 'LineWidth', 2);
xlim([1 365])
ylim([-11 0])

clim([min(GTmedian1depth_P1(:)) max(GTmedian1depth_P1(:))]);
sgtitle('Jordan', 'FontWeight', 'bold');
%% further plot options
c = colorbar('Position', [0.93 0.1 0.02 0.8]);
ylabel(c, 'Soil Temperature ({^o}C)', 'FontSize',10 , 'Rotation', 90)
set(gcf, 'Position', [118,102,1250,620])
figure1=gcf;
annotation(figure1,'textbox',...
    [0.478248334566986 0.465148983570039 0.100785714285715 0.0428571428571441],...
    'String',{'Sturm'},...
    'FontWeight','bold',...
    'FontSize',13,...
    'FitBoxToText','off',...
    'EdgeColor','none');
annotation(figure1,'textbox',...
    [0.263176165803107 0.935672514619883 0.0725751295336787 0.0428849902534111],...
    'String',{'RCP 4.5'},...
    'FontSize',12,...
    'FitBoxToText','off',...
    'EdgeColor','none');
annotation(figure1,'textbox',...
    [0.688046632124348 0.927875243664717 0.0705025906735754 0.0506822612085771],...
    'String',{'RCP 8.5'},...
    'FontSize',12,...
    'FitBoxToText','off',...
    'EdgeColor','none');
% annotation('textbox', [0.25, 0.95, 0.5, 0.05], 'String', 'Jordan', 'EdgeColor', 'none', 'HorizontalAlignment', 'center', 'FontSize', 14);
% annotation('textbox', [0.25, 0.45, 0.5, 0.05], 'String', 'Sturm', 'EdgeColor', 'none', 'HorizontalAlignment', 'center', 'FontSize', 14);
%% xticks and labels
% Define the xticks and labels
xticks = [1,32,60,91,121,152,182,213,244,274,305,335];
xticklabels = {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};

% Find all axes in the current figure
all_axes = findall(gcf, 'Type', 'axes');
target_axis = all_axes([1,2,5,6]);
% Loop through each axis and set the xticks and xticklabels
for k = 1:length(target_axis)
    set(target_axis(k), 'XTick', xticks, 'XTickLabel', xticklabels);
end
%% letters
annotation('textbox', [0.103958549222797 0.577189427606042 0.0329015544041451 0.0536062378167641], 'String', '(a)', 'EdgeColor', 'none', 'FontSize', 13, 'FontWeight', 'normal')
annotation('textbox', [0.316393782383419 0.574074993634601 0.033419689119171 0.0536062378167641], 'String', '(b)', 'EdgeColor', 'none', 'FontSize', 13, 'FontWeight', 'normal')
annotation('textbox', [0.526756476683937 0.5740749936346 0.0329015544041451 0.0536062378167641], 'String', '(c)', 'EdgeColor', 'none', 'FontSize', 13, 'FontWeight', 'normal')
annotation('textbox', [0.739227871329879 0.574074993634601 0.0334196891191709 0.0536062378167641], 'String', '(d)', 'EdgeColor', 'none', 'FontSize', 13, 'FontWeight', 'normal')
annotation('textbox', [0.103958549222798 0.103157894736842 0.0329015544041451 0.0536062378167641], 'String', '(e)', 'EdgeColor', 'none', 'FontSize', 13, 'FontWeight', 'normal')
annotation('textbox', [0.316429943868739 0.101208576998051 0.0292746113989638 0.0536062378167641], 'String', '(f)', 'EdgeColor', 'none', 'FontSize', 13, 'FontWeight', 'normal')
annotation('textbox', [0.526756476683937 0.101208576998051 0.0292746113989638 0.0536062378167641], 'String', '(g)', 'EdgeColor', 'none', 'FontSize', 13, 'FontWeight', 'normal')
annotation('textbox', [0.739227871329879 0.101208576998051 0.0292746113989638 0.0536062378167641], 'String', '(h)', 'EdgeColor', 'none', 'FontSize', 13, 'FontWeight', 'normal')

%% Optional figure export
exportgraphics(gcf, "heat_map.pdf", "Resolution",300)