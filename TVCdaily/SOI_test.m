%% SOIl temp rcp45
clear all
% cd /Volumes/'JR_SSD'/MATLAB/TVCdaily/h1
cd h1/
CaseList=dir('CORDEX_*rcp45*');
internalfilestruct='/lnd/hist/'; 
variable=nan(1020,length(CaseList));
for l=1:25
for i=1:length(CaseList)
filepath=strcat(CaseList(i).name,internalfilestruct);
ncname=dir(strcat(filepath,"/*2016-01-01*.nc"));
variable=ncread(strcat(filepath,ncname.name),'TSOI');
variable = squeeze(variable);
% variable=variable(1,:)
GT10(:,i)=(variable(l,:));
end

variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
GT102100=[TIME_YM, GT10];
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
set(gca, 'xtick' ,[1,32,60,91,121,152,182,213,244,274,305,335],'xticklabel',{'J','F','M','A','M','J','J','A','S','O','N','D'});
hold on
ylabel("^{o}C")
titletext=(['Layer ', num2str(l)]);
title(titletext, "FontWeight","normal")
xlim([1 366])
ylim([-20 15])
if l==1
legend([GT_plot_2046 GT_plot_2096], {'median 2016-2046', 'median 2066-2096'}, Location="northwestoutside", FontSize=8)
end
end
%% STURM GT10 rcp 4.5
clear all
% cd /Volumes/'JR_SSD'/MATLAB/TVCdaily/sturm/h1
cd h1
CaseList=dir('CORDEX_*rcp85*');
internalfilestruct='/lnd/hist/'; 
variable=nan(1020,length(CaseList));
for l=1:25
for i=1:length(CaseList)
filepath=strcat(CaseList(i).name,internalfilestruct);
ncname=dir(strcat(filepath,"/*2016-01-01*.nc"));
variable=ncread(strcat(filepath,ncname.name),'TSOI');
variable = squeeze(variable);
% variable=variable(1,:)
GT10(:,i)=(variable(l,:));
end

variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
GT102100=[TIME_YM, GT10];
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
%% Zero-curtain duraiton
% Initialize a cell array to store zero curtain days for each layer
if l==1
Autumn_zero_curtain_days_per_layer_present = cell(1, 25);
Autumn_zero_curtain_days_per_layer_future = cell(1, 25);
end
% Set the tolerance level
tolerance = 0.75;

% Initialize a counter for zero-curtain days
zero_curtain_days_present = 0;
zero_curtain_days_future = 0;
% Define the indices corresponding to the latter part of the year (Aug-Dec)
autumn_indices = 213:366; % Assuming a leap year with 366 days

% Loop through each cell of the dataset for autumn months only
for i = autumn_indices
    % Check if the absolute difference between temperature and zero is within tolerance
    if abs(GTmedian1(i)) <= tolerance
        % If so, increment the counter
        zero_curtain_days_present = zero_curtain_days_present + 1;
    end
end
Autumn_zero_curtain_days_per_layer_present{l} = zero_curtain_days_present;

% Loop through each cell of the dataset for autumn months only
for i = autumn_indices
    % Check if the absolute difference between temperature and zero is within tolerance
    if abs(GTmedian2(i)) <= tolerance
        % If so, increment the counter
        zero_curtain_days_future = zero_curtain_days_future + 1;
    end
end
Autumn_zero_curtain_days_per_layer_future{l} = zero_curtain_days_future;
%% plot options
GTi_2046=GTmedian1;
GTi_2096=GTmedian2;
m12=[1:366];
GT_plot_2046 = plot(m12, GTi_2046, 'black',"LineWidth", 1.5);
hold on
GT_plot_2096 = plot(m12, GTi_2096, 'red',"LineWidth", 1.5);
% plot options
yline(0, "--")
set(gca, 'xtick' ,[1,32,60,91,121,152,182,213,244,274,305,335],'xticklabel',{'J','F','M','A','M','J','J','A','S','O','N','D'});
hold on
ylabel("^{o}C")
titletext=(['Layer ', num2str(l)]);
title(titletext, "FontWeight","normal")
xlim([1 366])
ylim([-20 15])
if l==1
legend([GT_plot_2046 GT_plot_2096], {'median 2016-2046', 'median 2066-2096'}, Location="northoutside", FontSize=8)
end
end
%% zero-curtain duration
fig = figure;
set(gcf, 'Position', [100, 100, 1000, 500]);
subplot(1,2,1);
A1 = cell2mat(Autumn_zero_curtain_days_per_layer_present)
AP1=plot(A1,1:25,'k', LineWidth=1);
hold on
A2=cell2mat(Autumn_zero_curtain_days_per_layer_future)
AP2=plot(A2,1:25,'r', LineWidth=1)
ylabel('Soil Layer')
xlabel('Zero-Curtain Duration (days)')
legend([AP1 AP2], {'2016-2046', '2066-2096'}, Location="northeast", FontSize=8)
set(gca, 'YDir', 'reverse');
ylim([1 25])
xlim([0 200])
column_names = {'Soil Layer', 'Layer Interface Depth'};
depthdata = zeros(25, 2);
depthdata(:,1)=[1:25]
depthdata(:,2)=[0.020 0.060 0.120 0.200 0.320... 	
0.480 0.680 0.920 1.200 1.520... 	
1.880 2.280 2.720 3.260 3.900 4.640 5.480 6.420 7.460... 	
8.600 10.990 15.666 23.301 34.441 49.556]
position = [500, 10, 227, 475];
uitable(fig,"Data",depthdata, 'Position', position, 'ColumnName', column_names);
%%
% cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/Figures/'CLM STURM'/
% % cd C:/Users/jadru/'OneDrive - Northumbria University - Production Azure AD'/Documents/Figures/CLMdefaultTVC/
% exportgraphics(gcf, "GT_depth.jpg", "Resolution",300)