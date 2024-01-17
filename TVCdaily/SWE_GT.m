%% SWE RCP4.5 only
clear all
cd /Volumes/'JR SSD'/MATLAB/TVCdaily/h0
% cd h0
SWE2100=extractvar('H2OSNO', 'rcp45');
%% 1. Assign each month/day a julian day
juliandays=[];
for i=1:length(SWE2100)
d=datetime(SWE2100(i,1),SWE2100(i,2),SWE2100(i,3));
doy = day(d,'dayofyear');
juliandays=vertcat(juliandays,doy);
end
%paste the juliandays onto the end of SWE2100 variable
SWE2100=[SWE2100,juliandays];
%% 2. SWE 45 plot: Works, but with whitespace in middle of plot
SWEplot = figure()
SWEplot.Position=[100 20 800 1500]
T = tiledlayout(3,2, "TileSpacing","compact");
nexttile
SWE20162046_Daily=nan(30*(width(SWE2100)-4),366);
for d=1:366% cycle through each of the months 
indicestoget=find(SWE2100(:,1) >= 2016 & SWE2100(:,1) <= 2046-1 & SWE2100(:,width(SWE2100))==d); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=SWE2100(indicestoget,4:end-1); % extract specific rows
dimens=size(presentday(:,1:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,1:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
SWE20162046_Daily(1:length(dataout),d)=dataout; % store in new variable
end
SWE20662096_Daily=nan(30*(width(SWE2100)-4),366);
for d=1:366% cycle through each of the months 
indicestoget=find(SWE2100(:,1) >= 2066 & SWE2100(:,1) <= 2096-1 & SWE2100(:,width(SWE2100))==d); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=SWE2100(indicestoget,4:end-1); % extract specific rows
dimens=size(presentday(:,1:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,1:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
SWE20662096_Daily(1:length(dataout),d)=dataout; % store in new variable
end

%calc medians and percentiles
clear SWEmedian1
clear SWEmedian2
SWEmedian1 = median(SWE20162046_Daily);
SWEmedian2 = median(SWE20662096_Daily);
SWE1perc25 = prctile(SWE20162046_Daily(:,1:end),25);
SWE1perc75 = prctile(SWE20162046_Daily(:,1:end),75);
SWE2perc25 = prctile(SWE20662096_Daily(:,1:end),25);
SWE2perc75 = prctile(SWE20662096_Daily(:,1:end),75);

m12=[1:366];
SWEi_2046=SWEmedian1;
SWEi_2096=SWEmedian2;
SWEi_2046_25 = SWE1perc25;
SWEi_2046_75 = SWE1perc75;
SWEi_2096_25  = SWE2perc25;
SWEi_2096_75 = SWE2perc75;

%plot
SWE_plot_2046 = plot(m12, SWEi_2046, 'black',"LineWidth", 1.5);
hold on
SWE_plot_2096 = plot(m12, SWEi_2096, 'red',"LineWidth", 1.5);

%percentiles fill
% SWE_Y_fill_2046 = [SWEi_2046_25, fliplr(SWEi_2046_75)];
% SWE_X_fill_2046 = [m12, fliplr(m12(1:end))];
% f = fill(SWE_X_fill_2046, SWE_Y_fill_2046, 'black', "FaceAlpha", 0.2, "LineStyle", "none");
% hold on
% SWE_Y_fill_2096 = [SWEi_2096_25, fliplr(SWEi_2096_75)];
% SWE_X_fill_2096 = [m12, fliplr(m12(1:end))];
% f = fill(SWE_X_fill_2096, SWE_Y_fill_2096, 'red', "FaceAlpha", 0.2, "LineStyle", "none");

%plot options
legend([SWE_plot_2046 SWE_plot_2096], {'median 2016-2046', 'median 2066-2096'}, Location="northeast", FontSize=7)
set(gca, 'XTickLabel', []);
% set(gca, 'xtick' ,[1,32,60,91,121,152,182,213,244,274,305,335],'xticklabel',[]);
set(gca, 'xtick' ,[1,32,60,91,121,152,182,213,244,274,305,335],'xticklabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
xtickangle(45);xlim([1 366]);
ylim([1 250]);
ylabel("mm w.e.");
title('RCP 4.5', 'Snow Water Equivalent (SWE)');
%% SWE RCP8.5 only
clear all
SWE2100=extractvar('H2OSNO', 'rcp85');
%% 1. Assign each month/day a julian day
juliandays=[];
for i=1:length(SWE2100)
d=datetime(SWE2100(i,1),SWE2100(i,2),SWE2100(i,3));
doy = day(d,'dayofyear');
juliandays=vertcat(juliandays,doy);
end
%paste the juliandays onto the end of SWE2100 variable
SWE2100=[SWE2100,juliandays];
%% 2. SWE 85 plot: Works, but with whitespace in middle of plot
nexttile
SWE20162046_Daily=nan(30*(width(SWE2100)-4),366);
for d=1:366% cycle through each of the months 
indicestoget=find(SWE2100(:,1) >= 2016 & SWE2100(:,1) <= 2046-1 & SWE2100(:,width(SWE2100))==d); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=SWE2100(indicestoget,4:end-1); % extract specific rows
dimens=size(presentday(:,1:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,1:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
SWE20162046_Daily(1:length(dataout),d)=dataout; % store in new variable
end
SWE20662096_Daily=nan(30*(width(SWE2100)-4),366);
for d=1:366% cycle through each of the months 
indicestoget=find(SWE2100(:,1) >= 2066 & SWE2100(:,1) <= 2096-1 & SWE2100(:,width(SWE2100))==d); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=SWE2100(indicestoget,4:end-1); % extract specific rows
dimens=size(presentday(:,1:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,1:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
SWE20662096_Daily(1:length(dataout),d)=dataout; % store in new variable
end

%calc medians and percentiles
clear SWEmedian1
clear SWEmedian2
SWEmedian1 = median(SWE20162046_Daily);
SWEmedian2 = median(SWE20662096_Daily);
SWE1perc25 = prctile(SWE20162046_Daily(:,1:end),25);
SWE1perc75 = prctile(SWE20162046_Daily(:,1:end),75);
SWE2perc25 = prctile(SWE20662096_Daily(:,1:end),25);
SWE2perc75 = prctile(SWE20662096_Daily(:,1:end),75);

m12=[1:366];
SWEi_2046=SWEmedian1;
SWEi_2096=SWEmedian2;
SWEi_2046_25 = SWE1perc25;
SWEi_2046_75 = SWE1perc75;
SWEi_2096_25  = SWE2perc25;
SWEi_2096_75 = SWE2perc75;

%plot
SWE_plot_2046 = plot(m12, SWEi_2046, 'black',"LineWidth", 1.5);
hold on
SWE_plot_2096 = plot(m12, SWEi_2096, 'red',"LineWidth", 1.5);

%percentiles fill
% SWE_Y_fill_2046 = [SWEi_2046_25, fliplr(SWEi_2046_75)];
% SWE_X_fill_2046 = [m12, fliplr(m12(1:end))];
% f = fill(SWE_X_fill_2046, SWE_Y_fill_2046, 'black', "FaceAlpha", 0.2, "LineStyle", "none");
% hold on
% SWE_Y_fill_2096 = [SWEi_2096_25, fliplr(SWEi_2096_75)];
% SWE_X_fill_2096 = [m12, fliplr(m12(1:end))];
% f = fill(SWE_X_fill_2096, SWE_Y_fill_2096, 'red', "FaceAlpha", 0.2, "LineStyle", "none");


%plot options
set(gca, 'XTickLabel', []);
set(gca, 'YTickLabel', []);
% set(gca, 'xtick' ,[1,32,60,91,121,152,182,213,244,274,305,335],'xticklabel',[]);
set(gca, 'xtick' ,[1,32,60,91,121,152,182,213,244,274,305,335],'xticklabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
xtickangle(45);
% ylabel("mm w.e.");
title('RCP 8.5', 'Snow Water Equivalent (SWE)');
fontsize(13, "points")
xlim([1 366])
ylim([1 250]);
%% GT10 rcp 4.5
clear all
cd ../h1
GT102100=extractvar('TSOI_10CM', 'rcp45');
GT2100=GT102100(:,1:3);
GT = GT102100(:,4:end)-273.15;
GT102100=[GT2100 GT];
%% GT10 plot
clear GT1020162046
clear GT1020662096
indicestoget=find(GT102100(:,1) >= 2016 & GT102100(:,1) <= 2046);
GT1020162046=GT102100(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(GT1020162046(:,2)==m & GT1020162046(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
GT101perc25(c,1)=m;
GT101perc25(c,2)=d;
GT101perc25(c,3) = prctile(GT1020162046(rows,4:end),25,'all');
GT101perc75(c,1)=m;
GT101perc75(c,2)=d;
GT101perc75(c,3) = prctile(GT1020162046(rows,4:end),75,'all');
GT10median1(c,1)=m;
GT10median1(c,2)=d;
GT10median1(c,3) = nanmedian(GT1020162046(rows,4:end),'all');
        end
    end
end
indicestoget=find(GT102100(:,1) >= 2066 & GT102100(:,1) <= 2096);
GT1020662096=GT102100(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(GT1020662096(:,2)==m & GT1020662096(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
GT102perc25(c,1)=m;
GT102perc25(c,2)=d;
GT102perc25(c,3) = prctile(GT1020662096(rows,4:end),25,'all');
GT102perc75(c,1)=m;
GT102perc75(c,2)=d;
GT102perc75(c,3) = prctile(GT1020662096(rows,4:end),75,'all');
GT10median2(c,1)=m;
GT10median2(c,2)=d;
GT10median2(c,3) = nanmedian(GT1020662096(rows,4:end),'all');
        end
    end
end

% median calculation
d366=[1:366];
GT10i_2046=GT10median1(:,3);   %interp1([1:12],GT10median1,m12,'cubic');
GT10i_2096=GT10median2(:,3);   %interp1([1:12],GT10median2,m12,'cubic');
GT10i_2046_25 = GT101perc25(:,3); %interp1([1:12], GT101perc25,m12,'cubic');
GT10i_2046_75 = GT101perc75(:,3); %interp1([1:12], GT101perc75,m12,'cubic');
GT10i_2096_25  = GT102perc25(:,3); %interp1([1:12], GT102perc25,m12,'cubic');
GT10i_2096_75 = GT102perc75(:,3); %interp1([1:12], GT102perc75,m12,'cubic');

% plot
% GTplot = figure()
% GTplot.Position=[100 20 800 300]
% T = tiledlayout(1,2, "TileSpacing","compact");
nexttile
GT10_plot_20461 = plot([1:366], GT10i_2046, 'black',"LineWidth", 2);
hold on
GT10_plot_20961 = plot([1:366], GT10i_2096, 'r',"LineWidth", 2);
hold on

%percentiles fill
% GT10_Y_fill_2046 = [GT10i_2046_25', fliplr(GT10i_2046_75')];
% GT10_X_fill_2046 = [d366, fliplr(d366(1:end))];
% f = fill(GT10_X_fill_2046, GT10_Y_fill_2046, 'black', "FaceAlpha", 0.2, "LineStyle", "none");
% hold on
% GT10_Y_fill_2096 = [GT10i_2096_25', fliplr(GT10i_2096_75')];
% GT10_X_fill_2096 = [d366, fliplr(d366(1:end))];
% f = fill(GT10_X_fill_2096, GT10_Y_fill_2096, 'red', "FaceAlpha", 0.2, "LineStyle", "none");

% plot options
yline(0, "--")
set(gca, 'xtick' ,[1,32,60,91,121,152,182,213,244,274,305,335],'xticklabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
hold on
ylabel("^{o}C")
title('10cm Soil Temperature', "FontWeight","normal")
%legend([GT10_plot_2046 GT10_plot_2096], {'median 2016-2046', 'median 2066-2096'}, Location="northeast", FontSize=8) xticklabels([])
% xlim([1 366])
% ylim([0 140])
%% STURM GT10 rcp 4.5
clearvars -except GT10_plot_20461 GT10_plot_20961
cd ../sturm/h1
GT102100=extractvar('TSOI_10CM', 'rcp45');
GT2100=GT102100(:,1:3);
GT = GT102100(:,4:end)-273.15;
GT102100=[GT2100 GT];
%% GT10 plot
clear GT1020162046
clear GT1020662096
indicestoget=find(GT102100(:,1) >= 2016 & GT102100(:,1) <= 2046);
GT1020162046=GT102100(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(GT1020162046(:,2)==m & GT1020162046(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
GT101perc25(c,1)=m;
GT101perc25(c,2)=d;
GT101perc25(c,3) = prctile(GT1020162046(rows,4:end),25,'all');
GT101perc75(c,1)=m;
GT101perc75(c,2)=d;
GT101perc75(c,3) = prctile(GT1020162046(rows,4:end),75,'all');
GT10median1(c,1)=m;
GT10median1(c,2)=d;
GT10median1(c,3) = nanmedian(GT1020162046(rows,4:end),'all');
        end
    end
end
indicestoget=find(GT102100(:,1) >= 2066 & GT102100(:,1) <= 2096);
GT1020662096=GT102100(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(GT1020662096(:,2)==m & GT1020662096(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
GT102perc25(c,1)=m;
GT102perc25(c,2)=d;
GT102perc25(c,3) = prctile(GT1020662096(rows,4:end),25,'all');
GT102perc75(c,1)=m;
GT102perc75(c,2)=d;
GT102perc75(c,3) = prctile(GT1020662096(rows,4:end),75,'all');
GT10median2(c,1)=m;
GT10median2(c,2)=d;
GT10median2(c,3) = nanmedian(GT1020662096(rows,4:end),'all');
        end
    end
end

d366=[1:366];
GT10i_2046=GT10median1(:,3);   %interp1([1:12],GT10median1,m12,'cubic');
GT10i_2096=GT10median2(:,3);   %interp1([1:12],GT10median2,m12,'cubic');
GT10i_2046_25 = GT101perc25(:,3); %interp1([1:12], GT101perc25,m12,'cubic');
GT10i_2046_75 = GT101perc75(:,3); %interp1([1:12], GT101perc75,m12,'cubic');
GT10i_2096_25  = GT102perc25(:,3); %interp1([1:12], GT102perc25,m12,'cubic');
GT10i_2096_75 = GT102perc75(:,3); %interp1([1:12], GT102perc75,m12,'cubic');

hold on
GT10_plot_20462 = plot([1:366], GT10i_2046, 'k', "LineStyle",  '--',"LineWidth", 1.5);
hold on
GT10_plot_20962 = plot([1:366], GT10i_2096, 'red', "LineStyle",'--',"LineWidth", 1.5);
hold on
%percentiles fill
% GT10_Y_fill_2046 = [GT10i_2046_25', fliplr(GT10i_2046_75')];
% GT10_X_fill_2046 = [d366, fliplr(d366(1:end))];
% f = fill(GT10_X_fill_2046, GT10_Y_fill_2046, 'black', "FaceAlpha", 0.2, "LineStyle", "none");
% hold on
% GT10_Y_fill_2096 = [GT10i_2096_25', fliplr(GT10i_2096_75')];
% GT10_X_fill_2096 = [d366, fliplr(d366(1:end))];
% f = fill(GT10_X_fill_2096, GT10_Y_fill_2096, 'red', "FaceAlpha", 0.2, "LineStyle", "none");
xlim([0 366])
ylim([-20 15])
yline(0, "--")
%labels etc
%legend([GT10_plot_20461 GT10_plot_20961 GT10_plot_20462 GT10_plot_20962], {'Present Jordan', 'Future Jordan', 'Present Sturm', 'Future Sturm'}); Location="northeast", FontSize=7;
set(gca, 'xtick' ,[1,32,60,91,121,152,182,213,244,274,305,335],'xticklabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
hold on
%% GT10 rcp8.5
clear all
cd ../../h1
GT102100=extractvar('TSOI_10CM', 'rcp85');
GT2100=GT102100(:,1:3);
GT = GT102100(:,4:end)-273.15;
GT102100=[GT2100 GT];
%% GT10 plot
clear GT1020162046
clear GT1020662096
nexttile
indicestoget=find(GT102100(:,1) >= 2016 & GT102100(:,1) <= 2046);
GT1020162046=GT102100(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(GT1020162046(:,2)==m & GT1020162046(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
GT101perc25(c,1)=m;
GT101perc25(c,2)=d;
GT101perc25(c,3) = prctile(GT1020162046(rows,4:end),25,'all');
GT101perc75(c,1)=m;
GT101perc75(c,2)=d;
GT101perc75(c,3) = prctile(GT1020162046(rows,4:end),75,'all');
GT10median1(c,1)=m;
GT10median1(c,2)=d;
GT10median1(c,3) = nanmedian(GT1020162046(rows,4:end),'all');
        end
    end
end
indicestoget=find(GT102100(:,1) >= 2066 & GT102100(:,1) <= 2096);
GT1020662096=GT102100(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(GT1020662096(:,2)==m & GT1020662096(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
GT102perc25(c,1)=m;
GT102perc25(c,2)=d;
GT102perc25(c,3) = prctile(GT1020662096(rows,4:end),25,'all');
GT102perc75(c,1)=m;
GT102perc75(c,2)=d;
GT102perc75(c,3) = prctile(GT1020662096(rows,4:end),75,'all');
GT10median2(c,1)=m;
GT10median2(c,2)=d;
GT10median2(c,3) = nanmedian(GT1020662096(rows,4:end),'all');
        end
    end
end

d366=[1:366];
GT10i_2046=GT10median1(:,3);   %interp1([1:12],GT10median1,m12,'cubic');
GT10i_2096=GT10median2(:,3);   %interp1([1:12],GT10median2,m12,'cubic');
GT10i_2046_25 = GT101perc25(:,3); %interp1([1:12], GT101perc25,m12,'cubic');
GT10i_2046_75 = GT101perc75(:,3); %interp1([1:12], GT101perc75,m12,'cubic');
GT10i_2096_25  = GT102perc25(:,3); %interp1([1:12], GT102perc25,m12,'cubic');
GT10i_2096_75 = GT102perc75(:,3); %interp1([1:12], GT102perc75,m12,'cubic');
GT10_plot_20461 = plot([1:366], GT10i_2046, 'black',"LineWidth", 1.5);
hold on
GT10_plot_20961 = plot([1:366], GT10i_2096, 'r',"LineWidth", 1.5);
hold on
%percentiles fill
% GT10_Y_fill_2046 = [GT10i_2046_25', fliplr(GT10i_2046_75')];
% GT10_X_fill_2046 = [d366, fliplr(d366(1:end))];
% f = fill(GT10_X_fill_2046, GT10_Y_fill_2046, 'black', "FaceAlpha", 0.2, "LineStyle", "none");
% hold on
% GT10_Y_fill_2096 = [GT10i_2096_25', fliplr(GT10i_2096_75')];
% GT10_X_fill_2096 = [d366, fliplr(d366(1:end))];
% f = fill(GT10_X_fill_2096, GT10_Y_fill_2096, 'red', "FaceAlpha", 0.2, "LineStyle", "none");
xlim([1 366])
% ylim([0 140])
yline(0, "--")
%labels etc
%legend([GT10_plot_2046 GT10_plot_2096], {'median 2016-2046', 'median 2066-2096'}, Location="northeast", FontSize=8)
set(gca, 'xtick' ,[1,32,60,91,121,152,182,213,244,274,305,335],'xticklabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
hold on
% ylabel("^{o}C")
title('10cm Soil Temperature', "FontWeight","normal")
yticklabels([])
%% STURM GT10 rcp8.5
clearvars -except GT10_plot_20461 GT10_plot_20961 GT10_plot_20462 GT10_plot_20962
cd ../sturm/h1
GT102100=extractvar('TSOI_10CM', 'rcp85');
GT2100=GT102100(:,1:3);
GT = GT102100(:,4:end)-273.15;
GT102100=[GT2100 GT];

%% GT10 plot
clear GT1020162046
clear GT1020662096
indicestoget=find(GT102100(:,1) >= 2016 & GT102100(:,1) <= 2046);
GT1020162046=GT102100(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(GT1020162046(:,2)==m & GT1020162046(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
GT101perc25(c,1)=m;
GT101perc25(c,2)=d;
GT101perc25(c,3) = prctile(GT1020162046(rows,4:end),25,'all');
GT101perc75(c,1)=m;
GT101perc75(c,2)=d;
GT101perc75(c,3) = prctile(GT1020162046(rows,4:end),75,'all');
GT10median1(c,1)=m;
GT10median1(c,2)=d;
GT10median1(c,3) = nanmedian(GT1020162046(rows,4:end),'all');
        end
    end
end
indicestoget=find(GT102100(:,1) >= 2066 & GT102100(:,1) <= 2096);
GT1020662096=GT102100(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(GT1020662096(:,2)==m & GT1020662096(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
GT102perc25(c,1)=m;
GT102perc25(c,2)=d;
GT102perc25(c,3) = prctile(GT1020662096(rows,4:end),25,'all');
GT102perc75(c,1)=m;
GT102perc75(c,2)=d;
GT102perc75(c,3) = prctile(GT1020662096(rows,4:end),75,'all');
GT10median2(c,1)=m;
GT10median2(c,2)=d;
GT10median2(c,3) = nanmedian(GT1020662096(rows,4:end),'all');
        end
    end
end

d366=[1:366];
GT10i_2046=GT10median1(:,3);   %interp1([1:12],GT10median1,m12,'cubic');
GT10i_2096=GT10median2(:,3);   %interp1([1:12],GT10median2,m12,'cubic');
GT10i_2046_25 = GT101perc25(:,3); %interp1([1:12], GT101perc25,m12,'cubic');
GT10i_2046_75 = GT101perc75(:,3); %interp1([1:12], GT101perc75,m12,'cubic');
GT10i_2096_25  = GT102perc25(:,3); %interp1([1:12], GT102perc25,m12,'cubic');
GT10i_2096_75 = GT102perc75(:,3); %interp1([1:12], GT102perc75,m12,'cubic');
hold on
GT10_plot_2046 = plot([1:366], GT10i_2046, 'k',"LineStyle", '--',"LineWidth", 1.5);
hold on
GT10_plot_2096 = plot([1:366], GT10i_2096, 'red',"LineStyle", '--',"LineWidth", 1.5);
hold on
%percentiles fill
% GT10_Y_fill_2046 = [GT10i_2046_25', fliplr(GT10i_2046_75')];
% GT10_X_fill_2046 = [d366, fliplr(d366(1:end))];
% f = fill(GT10_X_fill_2046, GT10_Y_fill_2046, 'black', "FaceAlpha", 0.2, "LineStyle", "none");
% hold on
% GT10_Y_fill_2096 = [GT10i_2096_25', fliplr(GT10i_2096_75')];
% GT10_X_fill_2096 = [d366, fliplr(d366(1:end))];
% f = fill(GT10_X_fill_2096, GT10_Y_fill_2096, 'red', "FaceAlpha", 0.2, "LineStyle", "none");
xlim([1 366])
ylim([-20 15])
yline(0, "--")
%labels etc
set(gca, 'xtick' ,[1,32,60,91,121,152,182,213,244,274,305,335],'xticklabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
hold on
% ylabel("^{o}C")
fontsize(13, "points")
% title('10cm Soil Temperature', 'FontWeight', 'normal')
%% SOILLIQ rcp4.5
clearvars -except SWEnew1
cd ../../h1
CaseList=dir('CORDEX_Default*rcp45*');
internalfilestruct='/lnd/hist/'; 
variable=nan(31025,length(CaseList));
for i=1:length(CaseList) 
filepath=strcat(CaseList(i).name,internalfilestruct); 
ncname=dir(strcat(filepath,"*h1.2016-0*.nc"));
variable=ncread(strcat(filepath,ncname.name),'SOILLIQ');
%SOILLIQ(:,i)=24*3600*1000*variable;
variable=squeeze(variable);
variable=variable(1,:);
SOILLIQ(:,i)=variable;
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
% TIME=double(variabletime+datenum('2016-01-01','yyyy-mm'));
% % TIME_YM=str2num(datestr(TIME,'yyyy mm'));
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
SOILLIQ2100=[TIME_YM SOILLIQ];
%% SOILLIQ plot
clear SOILLIQ20162046
clear SOILLIQ20662096
nexttile
indicestoget=find(SOILLIQ2100(:,1) >= 2016 & SOILLIQ2100(:,1) <= 2046);
SOILLIQ20162046=SOILLIQ2100(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(SOILLIQ20162046(:,2)==m & SOILLIQ20162046(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
SOILLIQ1perc25(c,1)=m;
SOILLIQ1perc25(c,2)=d;
SOILLIQ1perc25(c,3) = prctile(SOILLIQ20162046(rows,4:end),25,'all');
SOILLIQ1perc75(c,1)=m;
SOILLIQ1perc75(c,2)=d;
SOILLIQ1perc75(c,3) = prctile(SOILLIQ20162046(rows,4:end),75,'all');
SOILLIQmedian1(c,1)=m;
SOILLIQmedian1(c,2)=d;
SOILLIQmedian1(c,3) = nanmedian(SOILLIQ20162046(rows,4:end),'all');
        end
    end
end
indicestoget=find(SOILLIQ2100(:,1) >= 2066 & SOILLIQ2100(:,1) <= 2096);
SOILLIQ20662096=SOILLIQ2100(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(SOILLIQ20662096(:,2)==m & SOILLIQ20662096(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
SOILLIQ2perc25(c,1)=m;
SOILLIQ2perc25(c,2)=d;
SOILLIQ2perc25(c,3) = prctile(SOILLIQ20662096(rows,4:end),25,'all');
SOILLIQ2perc75(c,1)=m;
SOILLIQ2perc75(c,2)=d;
SOILLIQ2perc75(c,3) = prctile(SOILLIQ20662096(rows,4:end),75,'all');
SOILLIQmedian2(c,1)=m;
SOILLIQmedian2(c,2)=d;
SOILLIQmedian2(c,3) = nanmedian(SOILLIQ20662096(rows,4:end),'all');
        end
    end
end

d366=[1:366];
SOILLIQi_2046=SOILLIQmedian1(:,3);   %interp1([1:12],SOILLIQmedian1,m12,'cubic');
SOILLIQi_2096=SOILLIQmedian2(:,3);   %interp1([1:12],SOILLIQmedian2,m12,'cubic');
SOILLIQi_2046_25 = SOILLIQ1perc25(:,3); %interp1([1:12], SOILLIQ1perc25,m12,'cubic');
SOILLIQi_2046_75 = SOILLIQ1perc75(:,3); %interp1([1:12], SOILLIQ1perc75,m12,'cubic');
SOILLIQi_2096_25  = SOILLIQ2perc25(:,3); %interp1([1:12], SOILLIQ2perc25,m12,'cubic');
SOILLIQi_2096_75 = SOILLIQ2perc75(:,3); %interp1([1:12], SOILLIQ2perc75,m12,'cubic');
SOILLIQ_plot_2046 = plot([1:366], log10(SOILLIQi_2046), 'black',"LineWidth", 1.5);
hold on
SOILLIQ_plot_2096 = plot([1:366], log10(SOILLIQi_2096), 'r',"LineWidth", 1.5);
hold on
%percentiles fill
% SOILLIQ_Y_fill_2046 = [SOILLIQi_2046_25', fliplr(SOILLIQi_2046_75')];
% SOILLIQ_X_fill_2046 = [d366, fliplr(d366(1:end))];
% f = fill(SOILLIQ_X_fill_2046, log10(SOILLIQ_Y_fill_2046), 'black', "FaceAlpha", 0.2, "LineStyle", "none");
% hold on
% SOILLIQ_Y_fill_2096 = [SOILLIQi_2096_25', fliplr(SOILLIQi_2096_75')];
% SOILLIQ_X_fill_2096 = [d366, fliplr(d366(1:end))];
% f = fill(SOILLIQ_X_fill_2096, log10(SOILLIQ_Y_fill_2096), 'red', "FaceAlpha", 0.2, "LineStyle", "none");
xlim([1 366])
% ylim([0 6])
yline(0, "--")
%labels etc
%legend([SOILLIQ_plot_2046 SOILLIQ_plot_2096], {'median 2016-2046', 'median 2066-2096'}, Location="northeast", FontSize=8)
set(gca, 'XTickLabel', []);
set(gca, 'xtick' ,[1,32,60,91,121,152,182,213,244,274,305,335],'xticklabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
hold on
ylabel('log10 Kg/m^2')
title('Soil Liquid Water', "FontWeight","normal")
%% SOILLIQ rcp8.5
clearvars -except SWEnew1
cd ../h1
CaseList=dir('CORDEX_Default*rcp85*');
internalfilestruct='/lnd/hist/'; 
variable=nan(31025,length(CaseList));
for i=1:length(CaseList) 
filepath=strcat(CaseList(i).name,internalfilestruct); 
ncname=dir(strcat(filepath,"*h1.2016-0*.nc"));
variable=ncread(strcat(filepath,ncname.name),'SOILLIQ');
%SOILLIQ(:,i)=24*3600*1000*variable;
variable=squeeze(variable);
variable=variable(1,:);
SOILLIQ(:,i)=variable;
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
% TIME=double(variabletime+datenum('2016-01-01','yyyy-mm'));
% % TIME_YM=str2num(datestr(TIME,'yyyy mm'));
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
SOILLIQ2100=[TIME_YM SOILLIQ];
%% SOILLIQ plot
clear SOILLIQ20162046
clear SOILLIQ20662096
nexttile
indicestoget=find(SOILLIQ2100(:,1) >= 2016 & SOILLIQ2100(:,1) <= 2046);
SOILLIQ20162046=SOILLIQ2100(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(SOILLIQ20162046(:,2)==m & SOILLIQ20162046(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
SOILLIQ1perc25(c,1)=m;
SOILLIQ1perc25(c,2)=d;
SOILLIQ1perc25(c,3) = prctile(SOILLIQ20162046(rows,4:end),25,'all');
SOILLIQ1perc75(c,1)=m;
SOILLIQ1perc75(c,2)=d;
SOILLIQ1perc75(c,3) = prctile(SOILLIQ20162046(rows,4:end),75,'all');
SOILLIQmedian1(c,1)=m;
SOILLIQmedian1(c,2)=d;
SOILLIQmedian1(c,3) = nanmedian(SOILLIQ20162046(rows,4:end),'all');
        end
    end
end
indicestoget=find(SOILLIQ2100(:,1) >= 2066 & SOILLIQ2100(:,1) <= 2096);
SOILLIQ20662096=SOILLIQ2100(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(SOILLIQ20662096(:,2)==m & SOILLIQ20662096(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
SOILLIQ2perc25(c,1)=m;
SOILLIQ2perc25(c,2)=d;
SOILLIQ2perc25(c,3) = prctile(SOILLIQ20662096(rows,4:end),25,'all');
SOILLIQ2perc75(c,1)=m;
SOILLIQ2perc75(c,2)=d;
SOILLIQ2perc75(c,3) = prctile(SOILLIQ20662096(rows,4:end),75,'all');
SOILLIQmedian2(c,1)=m;
SOILLIQmedian2(c,2)=d;
SOILLIQmedian2(c,3) = nanmedian(SOILLIQ20662096(rows,4:end),'all');
        end
    end
end

d366=[1:366];
SOILLIQi_2046=SOILLIQmedian1(:,3);   %interp1([1:12],SOILLIQmedian1,m12,'cubic');
SOILLIQi_2096=SOILLIQmedian2(:,3);   %interp1([1:12],SOILLIQmedian2,m12,'cubic');
SOILLIQi_2046_25 = SOILLIQ1perc25(:,3); %interp1([1:12], SOILLIQ1perc25,m12,'cubic');
SOILLIQi_2046_75 = SOILLIQ1perc75(:,3); %interp1([1:12], SOILLIQ1perc75,m12,'cubic');
SOILLIQi_2096_25  = SOILLIQ2perc25(:,3); %interp1([1:12], SOILLIQ2perc25,m12,'cubic');
SOILLIQi_2096_75 = SOILLIQ2perc75(:,3); %interp1([1:12], SOILLIQ2perc75,m12,'cubic');
SOILLIQ_plot_2046 = plot([1:366], log10(SOILLIQi_2046), 'black',"LineWidth", 1.5);
hold on
SOILLIQ_plot_2096 = plot([1:366], log10(SOILLIQi_2096), 'r',"LineWidth", 1.5);
hold on

%percentiles fill
% SOILLIQ_Y_fill_2046 = [SOILLIQi_2046_25', fliplr(SOILLIQi_2046_75')];
% SOILLIQ_X_fill_2046 = [d366, fliplr(d366(1:end))];
% f = fill(SOILLIQ_X_fill_2046, log10(SOILLIQ_Y_fill_2046), 'black', "FaceAlpha", 0.2, "LineStyle", "none");
% hold on
% SOILLIQ_Y_fill_2096 = [SOILLIQi_2096_25', fliplr(SOILLIQi_2096_75')];
% SOILLIQ_X_fill_2096 = [d366, fliplr(d366(1:end))];
% f = fill(SOILLIQ_X_fill_2096, log10(SOILLIQ_Y_fill_2096), 'red', "FaceAlpha", 0.2, "LineStyle", "none");
xlim([1 366])
% ylim([0 140])
yline(0, "--")
%labels etc
%legend([SOILLIQ_plot_2046 SOILLIQ_plot_2096], {'median 2016-2046', 'median 2066-2096'}, Location="northeast", FontSize=8)
set(gca, 'XTickLabel', []);
set(gca, 'xtick' ,[1,32,60,91,121,152,182,213,244,274,305,335],'xticklabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
hold on
% ylabel('log10 Kg/m^2')
title('Soil Liquid Water', "FontWeight","normal")
yticklabels([])
%% Set legend size
fig = gcf;
leggy = findobj(fig,'Type', 'legend')
set(leggy, "FontSize",7);
% %% Save figure
% cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/Figures/CLMdefaultTVC/
% exportgraphics(gcf, "SWE_GT_SL.jpg", "Resolution",300)
