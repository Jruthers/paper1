%% zero-curtain duration
close all
clearvars
load("zero_curtain_data.mat");
fig = figure;
set(gcf, 'Position', [100, 100, 500, 500]);
hold on
y=[0.020 0.060 0.120 0.200 0.320... 	
0.480 0.680 0.920 1.200 1.520... 	
1.880 2.280 2.720 3.260 3.900 4.640 5.480 6.420 7.460... 	
8.600 10.990 15.666 23.301 34.441 49.556];
P3=stairs(s_present,y,'k--', LineWidth=1);
P1=stairs(d_present,y,'k', LineWidth=1);
P4=stairs(s_future,y,'r--', LineWidth=1);
P2=stairs(d_future,y,'r', LineWidth=1);
ylabel('Soil Depth (m)')
xlabel('Zero-Curtain Duration (days)')
legend([P1 P2 P3 P4], {'Jordan 2016-2046', 'Jordan 2066-2096', 'Sturm 2016-2046', 'Sturm 2066-2096' }, Location="southeast", FontSize=8)
set(gca, 'YDir', 'reverse');
ylim([0 15])
%% Optional export
% exportgraphics(gcf, "Appendix_B.png", "Resolution",300)