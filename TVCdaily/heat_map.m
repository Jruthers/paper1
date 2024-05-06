%% default rcp45 present 
close all
clearvars
%change into the directory containing soil data and extract into new var
cd C:\Users\w22026593\'OneDrive - Northumbria University - Production Azure AD'\Documents\MATLAB\TVCdaily\'q10 1.5 psimin -2'\h0
% cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/'q10 1.5 psimin -2'/h1/
CaseList=dir('CORDEX_*rcp45*');
internalfilestruct='/lnd/hist/'; 
variable=nan(1020,length(CaseList));
for l=1:25 %loops through 25 soil layers
for i=1:length(CaseList) %loops through ensemble members
filepath=strcat(CaseList(i).name,internalfilestruct);
ncname=dir(strcat(filepath,"/*2016-01-01*.nc"));
variable=ncread(strcat(filepath,ncname.name),'TSOI');
variable = squeeze(variable); % if variable is 3D convert to 2D with squeeze
GT10(:,i)=(variable(l,:));
end

variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
GT102100=[TIME_YM, GT10];
GT2100=GT102100(:,1:3);
GT = GT102100(:,4:end)-273.15; %convert from Kelvin to DegC
GT102100=[GT2100 GT];

% 1. Assign each month/day a julian day
juliandays=[];
for i=1:length(GT102100)
d=datetime(GT102100(i,1),GT102100(i,2),GT102100(i,3));
doy = day(d,'dayofyear');
juliandays=vertcat(juliandays,doy);
end
%paste the juliandays onto the end of GT102100 variable
GT102100=[GT102100,juliandays];

% sort data into two 30 year time periods
GT20162046_Daily=nan(30*(width(GT102100)-4),366);
for d=1:366% cycle through each of the months 
indicestoget=find(GT102100(:,1) >= 2016 & GT102100(:,1) <= 2046-1 & GT102100(:,width(GT102100))==d); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=GT102100(indicestoget,4:end-1); % extract specific rows
dimens=size(presentday(:,1:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,1:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
GT20162046_Daily(1:length(dataout),d)=dataout; % store in new variable
end

%calculate a median daily value across members and years
GTmedian1 = median(GT20162046_Daily);
GTmedian1depth_P1(l,:)=GTmedian1;
end
 
%plot layout
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
xlim([0 300])
ylim([-11 0])
title('2016-2046', 'FontWeight','normal');
ytext = {'Soil Depth (m)'};
ylabel(ytext);

%% default rcp45 future
clearvars -except GTmedian1depth_P1
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/'q10 1.5 psimin -2'/h1
% cd D:/MATLAB/TVCdaily/h1
% cd E:/MATLAB/TVCdaily/h1
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

% 1. Assign each month/day a julian day
juliandays=[];
for i=1:length(GT102100)
d=datetime(GT102100(i,1),GT102100(i,2),GT102100(i,3));
doy = day(d,'dayofyear');
juliandays=vertcat(juliandays,doy);
end
%paste the juliandays onto the end of GT102100 variable
GT102100=[GT102100,juliandays];

% 2. GT 45 plot: Works, but with whitespace in middle of plot

GT20662096_Daily=nan(30*(width(GT102100)-4),366);
for d=1:366% cycle through each of the months 
indicestoget=find(GT102100(:,1) >= 2066 & GT102100(:,1) <= 2096-1 & GT102100(:,width(GT102100))==d); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=GT102100(indicestoget,4:end-1); % extract specific rows
dimens=size(presentday(:,1:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,1:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
GT20662096_Daily(1:length(dataout),d)=dataout; % store in new variable
end

GTmedian2 = median(GT20662096_Daily);
GTmedian1depth_F(l,:)=GTmedian2;
end

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
xlim([0 300])
ylim([-11 0])
% x_low = c1(1, 2:end);
% y_low = c1(2, 2:end);
% x_high = c2(1, 2:end);
% y_high = c2(2, 2:end);
% fill([x_low, flip(x_high)], [y_low, flip(y_high)], 'k', 'EdgeColor', 'none');

% contour([1:366],(y(1:20)),(GTmedian1depth_F(1:20,:)),[0 0],'k-','LineWidth',2)
clim([min(GTmedian1depth_P1(:)) max(GTmedian1depth_P1(:))]);
title('2066-2096', 'FontWeight','normal')

%% sturm rcp45 present 
clearvars -except GTmedian1depth_P1
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/sturm/'q10 1.5 psimin -2'/h1
% cd D:/MATLAB/TVCdaily/h1
% cd E:/MATLAB/TVCdaily/sturm/h1
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

% 1. Assign each month/day a julian day
juliandays=[];
for i=1:length(GT102100)
d=datetime(GT102100(i,1),GT102100(i,2),GT102100(i,3));
doy = day(d,'dayofyear');
juliandays=vertcat(juliandays,doy);
end
%paste the juliandays onto the end of GT102100 variable
GT102100=[GT102100,juliandays];

% 2. GT 45 plot: Works, but with whitespace in middle of plot

GT20162046_Daily=nan(30*(width(GT102100)-4),366);
for d=1:366% cycle through each of the months 
indicestoget=find(GT102100(:,1) >= 2016 & GT102100(:,1) <= 2046-1 & GT102100(:,width(GT102100))==d); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=GT102100(indicestoget,4:end-1); % extract specific rows
dimens=size(presentday(:,1:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,1:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
GT20162046_Daily(1:length(dataout),d)=dataout; % store in new variable
end

GTmedian1 = median(GT20162046_Daily);
GTmedian1depth_P(l,:)=GTmedian1;
end
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
xlim([0 300])
ylim([-11 0])

clim([min(GTmedian1depth_P1(:)) max(GTmedian1depth_P1(:))]);
ylabel({'Soil Depth (m)'})
xlabel('Julian Day')

%% sturm rcp45 future
clearvars -except GTmedian1depth_P1
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/sturm/'q10 1.5 psimin -2'/h1
% cd D:/MATLAB/TVCdaily/h1
% cd E:/MATLAB/TVCdaily/sturm/h1
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

% 1. Assign each month/day a julian day
juliandays=[];
for i=1:length(GT102100)
d=datetime(GT102100(i,1),GT102100(i,2),GT102100(i,3));
doy = day(d,'dayofyear');
juliandays=vertcat(juliandays,doy);
end
%paste the juliandays onto the end of GT102100 variable
GT102100=[GT102100,juliandays];

% 2. GT 45 plot: Works, but with whitespace in middle of plot

GT20662096_Daily=nan(30*(width(GT102100)-4),366);
for d=1:366% cycle through each of the months 
indicestoget=find(GT102100(:,1) >= 2066 & GT102100(:,1) <= 2096-1 & GT102100(:,width(GT102100))==d); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=GT102100(indicestoget,4:end-1); % extract specific rows
dimens=size(presentday(:,1:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,1:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
GT20662096_Daily(1:length(dataout),d)=dataout; % store in new variable
end

GTmedian2 = median(GT20662096_Daily);
GTmedian1depth_F(l,:)=GTmedian2;
end

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
xlim([0 300])
ylim([-11 0])

clim([min(GTmedian1depth_P1(:)) max(GTmedian1depth_P1(:))]);
xlabel('Julian Day')
% title('Sturm', 'FontWeight', 'normal');

%% default rcp85 present 
clearvars -except GTmedian1depth_P1
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/'q10 1.5 psimin -2'/h1
% cd D:/MATLAB/TVCdaily/h1
% cd E:/MATLAB/TVCdaily/h1
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

% 1. Assign each month/day a julian day
juliandays=[];
for i=1:length(GT102100)
d=datetime(GT102100(i,1),GT102100(i,2),GT102100(i,3));
doy = day(d,'dayofyear');
juliandays=vertcat(juliandays,doy);
end
%paste the juliandays onto the end of GT102100 variable
GT102100=[GT102100,juliandays];

% 2. GT 45 plot: Works, but with whitespace in middle of plot

GT20162046_Daily=nan(30*(width(GT102100)-4),366);
for d=1:366% cycle through each of the months 
indicestoget=find(GT102100(:,1) >= 2016 & GT102100(:,1) <= 2046-1 & GT102100(:,width(GT102100))==d); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=GT102100(indicestoget,4:end-1); % extract specific rows
dimens=size(presentday(:,1:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,1:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
GT20162046_Daily(1:length(dataout),d)=dataout; % store in new variable
end

GTmedian1 = median(GT20162046_Daily);
GTmedian1depth_P2(l,:)=GTmedian1;
end
% subplot(2,2,1)
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
xlim([0 300])
ylim([-11 0])

clim([min(GTmedian1depth_P1(:)) max(GTmedian1depth_P1(:))]);
title('2016-2046', 'FontWeight','normal');
% ylabel('Soil Depth (m)')
%% default rcp85 future
clearvars -except GTmedian1depth_P1
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/'q10 1.5 psimin -2'/h1
% cd D:/MATLAB/TVCdaily/h1
% cd E:/MATLAB/TVCdaily/h1
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

% 1. Assign each month/day a julian day
juliandays=[];
for i=1:length(GT102100)
d=datetime(GT102100(i,1),GT102100(i,2),GT102100(i,3));
doy = day(d,'dayofyear');
juliandays=vertcat(juliandays,doy);
end
%paste the juliandays onto the end of GT102100 variable
GT102100=[GT102100,juliandays];

% 2. GT 45 plot: Works, but with whitespace in middle of plot

GT20662096_Daily=nan(30*(width(GT102100)-4),366);
for d=1:366% cycle through each of the months 
indicestoget=find(GT102100(:,1) >= 2066 & GT102100(:,1) <= 2096-1 & GT102100(:,width(GT102100))==d); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=GT102100(indicestoget,4:end-1); % extract specific rows
dimens=size(presentday(:,1:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,1:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
GT20662096_Daily(1:length(dataout),d)=dataout; % store in new variable
end

GTmedian2 = median(GT20662096_Daily);
GTmedian1depth_F(l,:)=GTmedian2;
end

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
xlim([0 300])
ylim([-11 0])

clim([min(GTmedian1depth_P1(:)) max(GTmedian1depth_P1(:))]);
title('2066-2096', 'FontWeight','normal')
%% sturm rcp85 present 
clearvars -except GTmedian1depth_P1
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/sturm/'q10 1.5 psimin -2'/h1
% cd D:/MATLAB/TVCdaily/h1
% cd E:/MATLAB/TVCdaily/sturm/h1
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

% 1. Assign each month/day a julian day
juliandays=[];
for i=1:length(GT102100)
d=datetime(GT102100(i,1),GT102100(i,2),GT102100(i,3));
doy = day(d,'dayofyear');
juliandays=vertcat(juliandays,doy);
end
%paste the juliandays onto the end of GT102100 variable
GT102100=[GT102100,juliandays];

% 2. GT 45 plot: Works, but with whitespace in middle of plot

GT20162046_Daily=nan(30*(width(GT102100)-4),366);
for d=1:366% cycle through each of the months 
indicestoget=find(GT102100(:,1) >= 2016 & GT102100(:,1) <= 2046-1 & GT102100(:,width(GT102100))==d); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=GT102100(indicestoget,4:end-1); % extract specific rows
dimens=size(presentday(:,1:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,1:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
GT20162046_Daily(1:length(dataout),d)=dataout; % store in new variable
end

GTmedian1 = median(GT20162046_Daily);
GTmedian1depth_P(l,:)=GTmedian1;
end
% subplot(2,2,3)
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
xlim([0 300])
ylim([-11 0])

clim([min(GTmedian1depth_P1(:)) max(GTmedian1depth_P1(:))]);
xlabel('Julian Day')

%% Sturm rcp85 future
clearvars -except GTmedian1depth_P1
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/sturm/'q10 1.5 psimin -2'/h1
% cd D:/MATLAB/TVCdaily/h1
% cd E:/MATLAB/TVCdaily/sturm/h1
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

% 1. Assign each month/day a julian day
juliandays=[];
for i=1:length(GT102100)
d=datetime(GT102100(i,1),GT102100(i,2),GT102100(i,3));
doy = day(d,'dayofyear');
juliandays=vertcat(juliandays,doy);
end
%paste the juliandays onto the end of GT102100 variable
GT102100=[GT102100,juliandays];
% 2. GT 45 plot: Works, but with whitespace in middle of plot

GT20662096_Daily=nan(30*(width(GT102100)-4),366);
for d=1:366% cycle through each of the months 
indicestoget=find(GT102100(:,1) >= 2066 & GT102100(:,1) <= 2096-1 & GT102100(:,width(GT102100))==d); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=GT102100(indicestoget,4:end-1); % extract specific rows
dimens=size(presentday(:,1:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,1:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
GT20662096_Daily(1:length(dataout),d)=dataout; % store in new variable
end

GTmedian2 = median(GT20662096_Daily);
GTmedian1depth_F(l,:)=GTmedian2;
end

% subplot(2,2,4)
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
xlim([0 300])
ylim([-11 0])

clim([min(GTmedian1depth_P1(:)) max(GTmedian1depth_P1(:))]);
xlabel('Julian Day')
sgtitle('Jordan', 'FontWeight', 'bold');
%% further plot options
c = colorbar('Position', [0.93 0.1 0.02 0.8]);
ylabel(c, 'Soil Temperature ({^o}C)', 'FontSize',10 , 'Rotation', 90)
set(gcf, 'Position', [118,102,965,513])
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

%% letters
annotation('textbox', [0.105958549222797 0.577189427606042 0.0329015544041451 0.0536062378167641], 'String', 'a', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'bold')
annotation('textbox', [0.318393782383419 0.574074993634601 0.033419689119171 0.0536062378167641], 'String', 'b', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'bold')
annotation('textbox', [0.528756476683937 0.5740749936346 0.0329015544041451 0.0536062378167641], 'String', 'c', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'bold')
annotation('textbox', [0.741227871329879 0.574074993634601 0.0334196891191709 0.0536062378167641], 'String', 'd', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'bold')
annotation('textbox', [0.105958549222798 0.103157894736842 0.0329015544041451 0.0536062378167641], 'String', 'e', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'bold')
annotation('textbox', [0.318429943868739 0.101208576998051 0.0292746113989638 0.0536062378167641], 'String', 'f', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'bold')
annotation('textbox', [0.528756476683937 0.101208576998051 0.0292746113989638 0.0536062378167641], 'String', 'g', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'bold')
annotation('textbox', [0.741227871329879 0.101208576998051 0.0292746113989638 0.0536062378167641], 'String', 'h', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'bold')

%% export
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/Figures/'CLM STURM'/
exportgraphics(gcf, "heat_map.jpg", "Resolution",300)
