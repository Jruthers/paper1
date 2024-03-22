%% SOIl default temp rcp85 present 
close all
clear
% cd /Volumes/'JR_SSD'/MATLAB/TVCdaily/sturm/h1
% cd D:/MATLAB/TVCdaily/h1
cd E:/MATLAB/TVCdaily/h1
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
GTmedian1depth_P1(l,:)=GTmedian1;
end
% subplot(2,2,1)
tiledlayout(2,2, "TileSpacing", "compact")
nexttile
y=-1*[0.020 0.060 0.120 0.200 0.320... 	
0.480 0.680 0.920 1.200 1.520... 	
1.880 2.280 2.720 3.260 3.900 4.640 5.480 6.420 7.460... 	
8.600 10.990 15.666 23.301 34.441 49.556]';
pcolor([1:366],(y(1:20)),(GTmedian1depth_P1(1:20,:))); shading interp; colormap jet
hold on
contour([1:366],(y(1:20)),(GTmedian1depth_P1(1:20,:)),[0 0],'k-','LineWidth',2)
clim([min(GTmedian1depth_P1(:)) max(GTmedian1depth_P1(:))]);
title('2016-2046', 'Jordan');
ylabel('Soil Depth (m)')
%% default SOIl temp rcp85 future
clearvars -except GTmedian1depth_P1
% cd /Volumes/'JR_SSD'/MATLAB/TVCdaily/sturm/h1
% cd D:/MATLAB/TVCdaily/h1
cd E:/MATLAB/TVCdaily/h1
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
GTmedian1depth_F(l,:)=GTmedian2;
end

% subplot(2,2,2)
nexttile
y=-1*[0.020 0.060 0.120 0.200 0.320... 	
0.480 0.680 0.920 1.200 1.520... 	
1.880 2.280 2.720 3.260 3.900 4.640 5.480 6.420 7.460... 	
8.600 10.990 15.666 23.301 34.441 49.556]';
pcolor([1:366],(y(1:20)),(GTmedian1depth_F(1:20,:))); shading interp; colormap jet
hold on
contour([1:366],(y(1:20)),(GTmedian1depth_F(1:20,:)),[0 0],'k-','LineWidth',2)
clim([min(GTmedian1depth_P1(:)) max(GTmedian1depth_P1(:))]);
title('2066-2096', 'Jordan')
%% SOIl sturm temp rcp85 present 
clearvars -except GTmedian1depth_P1
% cd /Volumes/'JR_SSD'/MATLAB/TVCdaily/sturm/h1
% cd D:/MATLAB/TVCdaily/h1
cd E:/MATLAB/TVCdaily/sturm/h1
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
GTmedian1depth_P(l,:)=GTmedian1;
end
% subplot(2,2,3)
nexttile
y=-1*[0.020 0.060 0.120 0.200 0.320... 	
0.480 0.680 0.920 1.200 1.520... 	
1.880 2.280 2.720 3.260 3.900 4.640 5.480 6.420 7.460... 	
8.600 10.990 15.666 23.301 34.441 49.556]';
pcolor([1:366],(y(1:20)),(GTmedian1depth_P(1:20,:))); shading interp; colormap jet
hold on
contour([1:366],(y(1:20)),(GTmedian1depth_P(1:20,:)),[0 0],'k-','LineWidth',2)
clim([min(GTmedian1depth_P1(:)) max(GTmedian1depth_P1(:))]);
ylabel('Soil Depth (m)')
xlabel('Julian Day')
title('Sturm', 'FontWeight', 'normal');
%% Sturm SOIl temp rcp85 future
clearvars -except GTmedian1depth_P1
% cd /Volumes/'JR_SSD'/MATLAB/TVCdaily/sturm/h1
% cd D:/MATLAB/TVCdaily/h1
cd E:/MATLAB/TVCdaily/sturm/h1
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
GTmedian1depth_F(l,:)=GTmedian2;
end

% subplot(2,2,4)
nexttile
y=-1*[0.020 0.060 0.120 0.200 0.320... 	
0.480 0.680 0.920 1.200 1.520... 	
1.880 2.280 2.720 3.260 3.900 4.640 5.480 6.420 7.460... 	
8.600 10.990 15.666 23.301 34.441 49.556]';
pcolor([1:366],(y(1:20)),(GTmedian1depth_F(1:20,:))); shading interp; colormap jet
hold on
contour([1:366],(y(1:20)),(GTmedian1depth_F(1:20,:)),[0 0],'k-','LineWidth',2)
clim([min(GTmedian1depth_P1(:)) max(GTmedian1depth_P1(:))]);
xlabel('Julian Day')
title('Sturm', 'FontWeight', 'normal');
%% further plot options
c = colorbar('Position', [0.93 0.1 0.02 0.8]);
ylabel(c, 'Soil Temperature ({^o}C)', 'FontSize',10 , 'Rotation', 90)
% annotation('textbox', [0.25, 0.95, 0.5, 0.05], 'String', 'Jordan', 'EdgeColor', 'none', 'HorizontalAlignment', 'center', 'FontSize', 14);
% annotation('textbox', [0.25, 0.45, 0.5, 0.05], 'String', 'Sturm', 'EdgeColor', 'none', 'HorizontalAlignment', 'center', 'FontSize', 14);