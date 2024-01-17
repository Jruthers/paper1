%% SWE RCP4.5 only
clear all
% cd /Volumes/'JR SSD'/MATLAB/TVCdaily/h0
cd D:/MATLAB/TVCdaily/h0
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
legend([SWE_plot_2046 SWE_plot_2096], {'2016-2046', '2066-2096'}, Location="northeast", FontSize=7)
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
%% SOIl temp rcp45
clear all
cd ../h1
GT102100=extractvar('TSOI_10CM', 'rcp45');
GT2100=GT102100(:,1:3);
GT = GT102100(:,4:end)-273.15;
GT102100=[GT2100 GT];
%% 1. Assign each month/day a julian day
juliandays=[];
for i=1:length(GT102100)
d=datetime(GT102100(i,1),GT102100(i,2),GT102100(i,3));
doy = day(d,'dayofyear');
juliandays=vertcat(juliandays,doy);
end
%paste the juliandays onto the end of GT102100 variable
GT102100=[GT102100,juliandays];
%% 2. GT 45 plot: Works, but with whitespace in middle of plot
nexttile
GT20162046_Daily=nan(30*(width(GT102100)-4),366);
for d=1:366% cycle through each of the months 
indicestoget=find(GT102100(:,1) >= 2016 & GT102100(:,1) <= 2046-1 & GT102100(:,width(GT102100))==d); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=GT102100(indicestoget,4:end-1); % extract specific rows
dimens=size(presentday(:,1:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,1:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
GT20162046_Daily(1:length(dataout),d)=dataout; % store in new variable
end
GT20662096_Daily=nan(30*(width(GT102100)-4),366);
for d=1:366% cycle through each of the months 
indicestoget=find(GT102100(:,1) >= 2066 & GT102100(:,1) <= 2096-1 & GT102100(:,width(GT102100))==d); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=GT102100(indicestoget,4:end-1); % extract specific rows
dimens=size(presentday(:,1:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,1:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
GT20662096_Daily(1:length(dataout),d)=dataout; % store in new variable
end

GTmedian1 = median(GT20162046_Daily);
GTmedian2 = median(GT20662096_Daily);
GTi_2046=GTmedian1;
GTi_2096=GTmedian2;
m12=[1:366];
GT_plot_2046 = plot(m12, GTi_2046, 'black',"LineWidth", 1.5);
hold on
GT_plot_2096 = plot(m12, GTi_2096, 'red',"LineWidth", 1.5);
% plot options
yline(0, "--")
set(gca, 'xtick' ,[1,32,60,91,121,152,182,213,244,274,305,335],'xticklabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
hold on
ylabel("^{o}C")
title('10cm Soil Temperature', "FontWeight","normal")
%legend([GT10_plot_2046 GT10_plot_2096], {'median 2016-2046', 'median 2066-2096'}, Location="northeast", FontSize=8) xticklabels([])
xlim([1 366])
ylim([-20 15])
%% STURM GT10 rcp 4.5
clearvars -except GT10_plot_20461 GT10_plot_20961
cd ../sturm/h1
clear all
GT102100=extractvar('TSOI_10CM', 'rcp45');
GT2100=GT102100(:,1:3);
GT = GT102100(:,4:end)-273.15;
GT102100=[GT2100 GT];
%% 1. Assign each month/day a julian day
juliandays=[];
for i=1:length(GT102100)
d=datetime(GT102100(i,1),GT102100(i,2),GT102100(i,3));
doy = day(d,'dayofyear');
juliandays=vertcat(juliandays,doy);
end
%paste the juliandays onto the end of GT102100 variable
GT102100=[GT102100,juliandays];
%% 2. GT 45 plot: Works, but with whitespace in middle of plot
hold on
GT20162046_Daily=nan(30*(width(GT102100)-4),366);
for d=1:366% cycle through each of the months 
indicestoget=find(GT102100(:,1) >= 2016 & GT102100(:,1) <= 2046-1 & GT102100(:,width(GT102100))==d); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=GT102100(indicestoget,4:end-1); % extract specific rows
dimens=size(presentday(:,1:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,1:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
GT20162046_Daily(1:length(dataout),d)=dataout; % store in new variable
end
GT20662096_Daily=nan(30*(width(GT102100)-4),366);
for d=1:366% cycle through each of the months 
indicestoget=find(GT102100(:,1) >= 2066 & GT102100(:,1) <= 2096-1 & GT102100(:,width(GT102100))==d); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=GT102100(indicestoget,4:end-1); % extract specific rows
dimens=size(presentday(:,1:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,1:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
GT20662096_Daily(1:length(dataout),d)=dataout; % store in new variable
end

GTmedian1 = median(GT20162046_Daily);
GTmedian2 = median(GT20662096_Daily);
GTi_2046=GTmedian1;
GTi_2096=GTmedian2;
m12=[1:366];
GT_plot_2046 = plot(m12, GTi_2046, 'k--',"LineWidth", 1.5);
hold on
GT_plot_2096 = plot(m12, GTi_2096, 'r--',"LineWidth", 1.5);
% plot options
yline(0, "--")
set(gca, 'xtick' ,[1,32,60,91,121,152,182,213,244,274,305,335],'xticklabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
hold on
ylabel("^{o}C")
title('10cm Soil Temperature', "FontWeight","normal")
% xlim([1 366])
% ylim([0 140])
%% SOIl temp rcp85
clear all
cd ../../h1
GT102100=extractvar('TSOI_10CM', 'rcp85');
GT2100=GT102100(:,1:3);
GT = GT102100(:,4:end)-273.15;
GT102100=[GT2100 GT];
%% 1. Assign each month/day a julian day
juliandays=[];
for i=1:length(GT102100)
d=datetime(GT102100(i,1),GT102100(i,2),GT102100(i,3));
doy = day(d,'dayofyear');
juliandays=vertcat(juliandays,doy);
end
%paste the juliandays onto the end of GT102100 variable
GT102100=[GT102100,juliandays];
%% 2. GT 85 plot: Works, but with whitespace in middle of plot
nexttile
GT20162046_Daily=nan(30*(width(GT102100)-4),366);
for d=1:366% cycle through each of the months 
indicestoget=find(GT102100(:,1) >= 2016 & GT102100(:,1) <= 2046-1 & GT102100(:,width(GT102100))==d); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=GT102100(indicestoget,4:end-1); % extract specific rows
dimens=size(presentday(:,1:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,1:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
GT20162046_Daily(1:length(dataout),d)=dataout; % store in new variable
end
GT20662096_Daily=nan(30*(width(GT102100)-4),366);
for d=1:366% cycle through each of the months 
indicestoget=find(GT102100(:,1) >= 2066 & GT102100(:,1) <= 2096-1 & GT102100(:,width(GT102100))==d); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=GT102100(indicestoget,4:end-1); % extract specific rows
dimens=size(presentday(:,1:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,1:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
GT20662096_Daily(1:length(dataout),d)=dataout; % store in new variable
end

GTmedian1 = median(GT20162046_Daily);
GTmedian2 = median(GT20662096_Daily);
GTi_2046=GTmedian1;
GTi_2096=GTmedian2;
m12=[1:366];
GT_plot_2046 = plot(m12, GTi_2046, 'black',"LineWidth", 1.5);
hold on
GT_plot_2096 = plot(m12, GTi_2096, 'red',"LineWidth", 1.5);
% plot options
yline(0, "--")
set(gca, 'xtick' ,[1,32,60,91,121,152,182,213,244,274,305,335],'xticklabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
hold on
ylabel("^{o}C")
title('10cm Soil Temperature', "FontWeight","normal")
%legend([GT10_plot_2046 GT10_plot_2096], {'median 2016-2046', 'median 2066-2096'}, Location="northeast", FontSize=8) xticklabels([])
xlim([1 366])
% ylim([0 140])
%% STURM GT10 rcp 8.5
clearvars -except GT10_plot_20461 GT10_plot_20961
cd ../sturm/h1
clear all
GT102100=extractvar('TSOI_10CM', 'rcp85');
GT2100=GT102100(:,1:3);
GT = GT102100(:,4:end)-273.15;
GT102100=[GT2100 GT];
%% 1. Assign each month/day a julian day
juliandays=[];
for i=1:length(GT102100)
d=datetime(GT102100(i,1),GT102100(i,2),GT102100(i,3));
doy = day(d,'dayofyear');
juliandays=vertcat(juliandays,doy);
end
%paste the juliandays onto the end of GT102100 variable
GT102100=[GT102100,juliandays];
%% 2. GT 85 plot: Works, but with whitespace in middle of plot
hold on
GT20162046_Daily=nan(30*(width(GT102100)-4),366);
for d=1:366% cycle through each of the months 
indicestoget=find(GT102100(:,1) >= 2016 & GT102100(:,1) <= 2046-1 & GT102100(:,width(GT102100))==d); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=GT102100(indicestoget,4:end-1); % extract specific rows
dimens=size(presentday(:,1:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,1:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
GT20162046_Daily(1:length(dataout),d)=dataout; % store in new variable
end
GT20662096_Daily=nan(30*(width(GT102100)-4),366);
for d=1:366% cycle through each of the months 
indicestoget=find(GT102100(:,1) >= 2066 & GT102100(:,1) <= 2096-1 & GT102100(:,width(GT102100))==d); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=GT102100(indicestoget,4:end-1); % extract specific rows
dimens=size(presentday(:,1:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,1:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
GT20662096_Daily(1:length(dataout),d)=dataout; % store in new variable
end

GTmedian1 = median(GT20162046_Daily);
GTmedian2 = median(GT20662096_Daily);
GTi_2046=GTmedian1;
GTi_2096=GTmedian2;
m12=[1:366];
GT_plot_2046 = plot(m12, GTi_2046, 'k--',"LineWidth", 1.5);
hold on
GT_plot_2096 = plot(m12, GTi_2096, 'r--',"LineWidth", 1.5);
% plot options
yline(0, "--")
set(gca, 'xtick' ,[1,32,60,91,121,152,182,213,244,274,305,335],'xticklabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
hold on
ylabel("^{o}C")
title('10cm Soil Temperature', "FontWeight","normal")
%legend([GT10_plot_2046 GT10_plot_2096], {'median 2016-2046', 'median 2066-2096'}, Location="northeast", FontSize=8) xticklabels([])
% xlim([1 366])
ylim([-20 15])
%% SOIl moisture rcp45
clear all
cd ../../h1
CaseList=dir('CORDEX_Default*rcp45*');
internalfilestruct='/lnd/hist/'; 
variable=nan(31025,length(CaseList));
for i=1:length(CaseList) 
filepath=strcat(CaseList(i).name,internalfilestruct); 
ncname=dir(strcat(filepath,"*h1.2016-0*.nc"));
variable=ncread(strcat(filepath,ncname.name),'SOILLIQ');
variable=squeeze(variable);
variable=variable(1,:);
SOILLIQ(:,i)=variable;
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
SL2100=[TIME_YM SOILLIQ];
%% 1. Assign each month/day a julian day
juliandays=[];
for i=1:length(SL2100)
d=datetime(SL2100(i,1),SL2100(i,2),SL2100(i,3));
doy = day(d,'dayofyear');
juliandays=vertcat(juliandays,doy);
end
%paste the juliandays onto the end of SL2100 variable
SL2100=[SL2100,juliandays];
%%
SL20162046_Daily=nan(30*(width(SL2100)-4),366);
for d=1:366% cycle through each of the months 
indicestoget=find(SL2100(:,1) >= 2016 & SL2100(:,1) <= 2046-1 & SL2100(:,width(SL2100))==d); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=SL2100(indicestoget,4:end-1); % extract specific rows
dimens=size(presentday(:,1:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,1:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
SL20162046_Daily(1:length(dataout),d)=dataout; % store in new variable
end
SL20662096_Daily=nan(30*(width(SL2100)-4),366);
for d=1:366% cycle through each of the months 
indicestoget=find(SL2100(:,1) >= 2066 & SL2100(:,1) <= 2096-1 & SL2100(:,width(SL2100))==d); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=SL2100(indicestoget,4:end-1); % extract specific rows
dimens=size(presentday(:,1:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,1:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
SL20662096_Daily(1:length(dataout),d)=dataout; % store in new variable
end
nexttile
SLmedian1 = median(SL20162046_Daily);
SLmedian2 = median(SL20662096_Daily);
SLi_2046=SLmedian1;
SLi_2096=SLmedian2;
m12=[1:366];
SL_plot_2046 = plot(m12, (SLi_2046), 'k',"LineWidth", 1.5);
hold on
SL_plot_2096 = plot(m12, (SLi_2096), 'r',"LineWidth", 1.5);
% plot options
set(gca, 'xtick' ,[1,32,60,91,121,152,182,213,244,274,305,335],'xticklabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
hold on
ylabel("Kg/m^2")
title('Soil Moisture', "FontWeight","normal")
%legend([GT10_plot_2046 GT10_plot_2096], {'median 2016-2046', 'median 2066-2096'}, Location="northeast", FontSize=8) xticklabels([])
xlim([1 366])
% ylim([0 140])
%% SOIl moisture rcp85
clear all
CaseList=dir('CORDEX_Default*rcp85*');
internalfilestruct='/lnd/hist/'; 
variable=nan(31025,length(CaseList));
for i=1:length(CaseList) 
filepath=strcat(CaseList(i).name,internalfilestruct); 
ncname=dir(strcat(filepath,"*h1.2016-0*.nc"));
variable=ncread(strcat(filepath,ncname.name),'SOILLIQ');
variable=squeeze(variable);
variable=variable(1,:);
SOILLIQ(:,i)=variable;
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
SL2100=[TIME_YM SOILLIQ];
%% 1. Assign each month/day a julian day
juliandays=[];
for i=1:length(SL2100)
d=datetime(SL2100(i,1),SL2100(i,2),SL2100(i,3));
doy = day(d,'dayofyear');
juliandays=vertcat(juliandays,doy);
end
%paste the juliandays onto the end of SL2100 variable
SL2100=[SL2100,juliandays];
%%
SL20162046_Daily=nan(30*(width(SL2100)-4),366);
for d=1:366% cycle through each of the months 
indicestoget=find(SL2100(:,1) >= 2016 & SL2100(:,1) <= 2046-1 & SL2100(:,width(SL2100))==d); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=SL2100(indicestoget,4:end-1); % extract specific rows
dimens=size(presentday(:,1:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,1:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
SL20162046_Daily(1:length(dataout),d)=dataout; % store in new variable
end
SL20662096_Daily=nan(30*(width(SL2100)-4),366);
for d=1:366% cycle through each of the months 
indicestoget=find(SL2100(:,1) >= 2066 & SL2100(:,1) <= 2096-1 & SL2100(:,width(SL2100))==d); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=SL2100(indicestoget,4:end-1); % extract specific rows
dimens=size(presentday(:,1:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,1:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
SL20662096_Daily(1:length(dataout),d)=dataout; % store in new variable
end
nexttile
SLmedian1 = median(SL20162046_Daily);
SLmedian2 = median(SL20662096_Daily);
SLi_2046=SLmedian1;
SLi_2096=SLmedian2;
m12=[1:366];
SL_plot_2046 = plot(m12, (SLi_2046), 'k',"LineWidth", 1.5);
hold on
SL_plot_2096 = plot(m12, (SLi_2096), 'r',"LineWidth", 1.5);
% plot options
set(gca, 'xtick' ,[1,32,60,91,121,152,182,213,244,274,305,335],'xticklabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
hold on
ylabel("Kg/m^2")
title('Soil Moisture', "FontWeight","normal")
%legend([GT10_plot_2046 GT10_plot_2096], {'median 2016-2046', 'median 2066-2096'}, Location="northeast", FontSize=8) xticklabels([])
xlim([1 366])
% ylim([0 140])
%% Set fontsizes
fontsize(12, "points")
fig = gcf;
leggy = findobj(fig,'Type', 'legend')
set(leggy, "FontSize",8);
%% Save figure
% cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/Figures/CLMdefaultTVC/
cd C:/Users/jadru/'OneDrive - Northumbria University - Production Azure AD'/Documents/Figures/CLMdefaultTVC/
exportgraphics(gcf, "SWE_GT_SL.jpg", "Resolution",300)
