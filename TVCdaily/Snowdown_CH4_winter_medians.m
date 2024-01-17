%% SWE RCP4.5 only
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clear all
% cd /Volumes/'JR SSD'/MATLAB/TVCdaily/h0
cd h0
CaseList=dir('CORDEX_Default_CORDEX*rcp45*');
internalfilestruct='/lnd/hist/'; 
variable=nan(1020,length(CaseList));
for i=1:length(CaseList)
filepath=strcat(CaseList(i).name,internalfilestruct);
ncname=dir(strcat(filepath,"/*2016-01-01*.nc"));
variable=ncread(strcat(filepath,ncname.name),'H2OSNO');
SWE(:,i)=(variable);
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
SWE2100=[TIME_YM, SWE];
%% Snow logic
SWEnew=SWE2100(:,4:9);
SWEnew(SWEnew<0.01)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];
%% FCH4 rcp4.5
% create a variable containing FCH4 data to 2100 and apply snow logic to get
% FCH4 only when snow is on the ground
% clearvars -except SWEnew1
cd ../h2
CaseList=dir('CORDEX_Default*rcp45*');
internalfilestruct='/lnd/hist/'; 
variable=nan(31025,length(CaseList));
for i=1:length(CaseList) 
filepath=strcat(CaseList(i).name,internalfilestruct); 
ncname=dir(strcat(filepath,"*h2.2016-0*.nc"));
variable=ncread(strcat(filepath,ncname.name),'FCH4');
variable=variable(1,:);
FCH4(:,i)=variable;
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
FCH42100=[TIME_YM 24*3600*1000*FCH4];
FCH4withsnow = SWEnew1.*FCH42100(:,4:9);
FCH4withsnow = [TIME_YM FCH4withsnow];

% Isolate the winter period FCH4, here sept(9) to july(7) covers the winter
% period. There will be some overlap but values will just be NANs and so will be excluded.
UNIQUE_YR=unique(TIME_YM(:,1));
for y=1:length(UNIQUE_YR)-1
rows=find(TIME_YM(:,1)==UNIQUE_YR(y,1) & TIME_YM(:,2)==9 ...
    |TIME_YM(:,1)==UNIQUE_YR(y,1) & TIME_YM(:,2)==10 ...
    | TIME_YM(:,1)==UNIQUE_YR(y,1) & TIME_YM(:,2)==11 ...
    | TIME_YM(:,1)==UNIQUE_YR(y,1) & TIME_YM(:,2)==12 ...
    | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==1 ...
    | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==2 ...
    | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==3 ...
    | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==4 ...
    | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==5 ...
    | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==6 ...
    | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==7   );
winterFCH4(y,:)=mean(FCH4withsnow(rows,4:9),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE = median(winterFCH4,2, 'omitnan');
SWEperc25 = prctile(winterFCH4, 25,2);
SWEperc75 = prctile(winterFCH4, 75,2);

% optional interpolation
% m12=[1:0.1:84];
% SWEinterp=interp1([1:84],medianSWE,m12,'cubic');
% SWEinterp25 = interp1([1:84], SWEperc25,m12,'cubic');
% SWEinterp75 = interp1([1:84], SWEperc75,m12,'cubic');
% SWEplot2 = plot(SWEinterp, 'blue');

% plot options
% winter85 = figure()
% winter85.Position=[100 20 800 400]
% tiledlayout(1,2, "TileSpacing","compact")
nexttile
hold on
SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'blue', "FaceAlpha", 0.2, "LineStyle", "none");
hold on
default = plot(medianSWE,'blue');
xticks(1:10:85)
xticklabels(UNIQUE_YR(1:10:85,1))
xlim([0 84])
ylim([0 0.015])
% title('RCP8.5')
ylabeltext = ({'Methane flux', 'to atmosphere (gC/m^2/day)'});
ylabel(ylabeltext)
fontsize(15,'points')
%% SWE RCP4.5 only
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clearvars -except default
cd ../sturm/h0
CaseList=dir('CORDEX_STURM_CORDEX*rcp45*');
internalfilestruct='/lnd/hist/'; 
variable=nan(1020,length(CaseList));
for i=1:length(CaseList)
filepath=strcat(CaseList(i).name,internalfilestruct);
ncname=dir(strcat(filepath,"/*2016-01-01*.nc"));
variable=ncread(strcat(filepath,ncname.name),'H2OSNO');
SWE(:,i)=(variable);
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
SWE2100=[TIME_YM, SWE];
%% Snow logic
SWEnew=SWE2100(:,4:9);
SWEnew(SWEnew<0.01)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];
%% FCH4 rcp4.5
% create a variable containing FCH4 data to 2100 and apply snow logic to get
% FCH4 only when snow is on the ground
clearvars -except SWEnew1 default
cd ../h2
CaseList=dir('CORDEX_STURM*rcp45*');
internalfilestruct='/lnd/hist/'; 
variable=nan(31025,length(CaseList));
for i=1:length(CaseList) 
filepath=strcat(CaseList(i).name,internalfilestruct); 
ncname=dir(strcat(filepath,"*h2.2016-0*.nc"));
variable=ncread(strcat(filepath,ncname.name),'FCH4');
variable=variable(1,:);
FCH4(:,i)=variable;
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
FCH42100=[TIME_YM 24*3600*1000*FCH4];
FCH4withsnow = SWEnew1.*FCH42100(:,4:9);
FCH4withsnow = [TIME_YM FCH4withsnow];

% Isolate the winter period FCH4, here sept(9) to july(7) covers the winter
% period. There will be some overlap but values will just be NANs and so will be excluded.
UNIQUE_YR=unique(TIME_YM(:,1));
for y=1:length(UNIQUE_YR)-1
rows=find(TIME_YM(:,1)==UNIQUE_YR(y,1) & TIME_YM(:,2)==9 ...
    |TIME_YM(:,1)==UNIQUE_YR(y,1) & TIME_YM(:,2)==10 ...
    | TIME_YM(:,1)==UNIQUE_YR(y,1) & TIME_YM(:,2)==11 ...
    | TIME_YM(:,1)==UNIQUE_YR(y,1) & TIME_YM(:,2)==12 ...
    | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==1 ...
    | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==2 ...
    | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==3 ...
    | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==4 ...
    | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==5 ...
    | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==6 ...
    | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==7   );
winterFCH4(y,:)=mean(FCH4withsnow(rows,4:9),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE = median(winterFCH4,2, 'omitnan');
SWEperc25 = prctile(winterFCH4, 25,2);
SWEperc75 = prctile(winterFCH4, 75,2);

% optional interpolation
% m12=[1:0.1:84];
% SWEinterp=interp1([1:84],medianSWE,m12,'cubic');
% SWEinterp25 = interp1([1:84], SWEperc25,m12,'cubic');
% SWEinterp75 = interp1([1:84], SWEperc75,m12,'cubic');
% SWEplot2 = plot(SWEinterp, 'blue');

% plot
hold on
SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'red', "FaceAlpha", 0.2, "LineStyle", "none");
hold on
sturm = plot(medianSWE,'red');
% plot options
% legend([default, sturm],"Default", "Sturm", Location="northeast", FontSize=7)
xticks(1:10:85)
xticklabels(UNIQUE_YR(1:10:85,1))
% title('RCP4.5')
fontsize(15,'points')
%% SWE RCP8.5 only
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clear all
cd ../../h0
CaseList=dir('CORDEX_Default_CORDEX*rcp85*');
internalfilestruct='/lnd/hist/'; 
variable=nan(1020,length(CaseList));
for i=1:length(CaseList)
filepath=strcat(CaseList(i).name,internalfilestruct);
ncname=dir(strcat(filepath,"/*2016-01-01*.nc"));
variable=ncread(strcat(filepath,ncname.name),'H2OSNO');
SWE(:,i)=(variable);
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
SWE2100=[TIME_YM, SWE];
%% Snow logic
SWEnew=SWE2100(:,4:30);
SWEnew(SWEnew<0.01)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];
%% FCH4 rcp8.5
% create a variable containing FCH4 data to 2100 and apply snow logic to get
% FCH4 only when snow is on the ground
clearvars -except SWEnew1
cd ../h2
CaseList=dir('CORDEX_Default*rcp85*');
internalfilestruct='/lnd/hist/'; 
variable=nan(31025,length(CaseList));
for i=1:length(CaseList) 
filepath=strcat(CaseList(i).name,internalfilestruct); 
ncname=dir(strcat(filepath,"*h2.2016-0*.nc"));
variable=ncread(strcat(filepath,ncname.name),'FCH4');
variable=variable(1,:);
FCH4(:,i)=variable;
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
FCH42100=[TIME_YM 24*3600*1000*FCH4];
FCH4withsnow = SWEnew1.*FCH42100(:,4:30);
FCH4withsnow = [TIME_YM FCH4withsnow];

% Isolate the winter period FCH4, here sept(9) to july(7) covers the winter
% period. There will be some overlap but values will just be NANs and so will be excluded.
UNIQUE_YR=unique(TIME_YM(:,1));
for y=1:length(UNIQUE_YR)-1
rows=find(TIME_YM(:,1)==UNIQUE_YR(y,1) & TIME_YM(:,2)==10) ...
    % |TIME_YM(:,1)==UNIQUE_YR(y,1) & TIME_YM(:,2)==10 ...
    % | TIME_YM(:,1)==UNIQUE_YR(y,1) & TIME_YM(:,2)==11 ...
    % | TIME_YM(:,1)==UNIQUE_YR(y,1) & TIME_YM(:,2)==12 ...
    % | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==1 ...
    % | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==2 ...
    % | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==3 ...
    % | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==4 ...
    % | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==5 ...
    % | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==6 ...
    % | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==7   );
winterFCH4(y,:)=mean(FCH4withsnow(rows,4:30),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE = median(winterFCH4,2, 'omitnan');
SWEperc25 = prctile(winterFCH4, 25,2);
SWEperc75 = prctile(winterFCH4, 75,2);

% optional interpolation
% m12=[1:0.1:84];
% SWEinterp=interp1([1:84],medianSWE,m12,'cubic');
% SWEinterp25 = interp1([1:84], SWEperc25,m12,'cubic');
% SWEinterp75 = interp1([1:84], SWEperc75,m12,'cubic');
% SWEplot2 = plot(SWEinterp, 'blue');

% plot options
nexttile
% winter85 = figure()
% winter85.Position=[100 20 800 400]
hold on
SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'blue', "FaceAlpha", 0.2, "LineStyle", "none");
hold on
plot(medianSWE,'blue')
xticks([1:10:85])
xticklabels(UNIQUE_YR([1:10:85],1))
fontsize(15,'points')
%% SWE RCP8.5 only
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clear all
cd ../sturm/h0
CaseList=dir('CORDEX_STURM_CORDEX*rcp85*');
internalfilestruct='/lnd/hist/'; 
variable=nan(1020,length(CaseList));
for i=1:length(CaseList)
filepath=strcat(CaseList(i).name,internalfilestruct);
ncname=dir(strcat(filepath,"/*2016-01-01*.nc"));
variable=ncread(strcat(filepath,ncname.name),'H2OSNO');
SWE(:,i)=(variable);
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
SWE2100=[TIME_YM, SWE];
%% Snow logic
SWEnew=SWE2100(:,4:30);
SWEnew(SWEnew<0.01)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];
%% FCH4 rcp8.5
% create a variable containing FCH4 data to 2100 and apply snow logic to get
% FCH4 only when snow is on the ground
clearvars -except SWEnew1
cd ../h2
CaseList=dir('CORDEX_STURM*rcp85*');
internalfilestruct='/lnd/hist/'; 
variable=nan(31025,length(CaseList));
for i=1:length(CaseList) 
filepath=strcat(CaseList(i).name,internalfilestruct); 
ncname=dir(strcat(filepath,"*h2.2016-0*.nc"));
variable=ncread(strcat(filepath,ncname.name),'FCH4');
variable=variable(1,:);
FCH4(:,i)=variable;
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
FCH42100=[TIME_YM 24*3600*1000*FCH4];
FCH4withsnow = SWEnew1.*FCH42100(:,4:30);
FCH4withsnow = [TIME_YM FCH4withsnow];

% Isolate the winter period FCH4, here sept(9) to july(7) covers the winter
% period. There will be some overlap but values will just be NANs and so will be excluded.
UNIQUE_YR=unique(TIME_YM(:,1));
for y=1:length(UNIQUE_YR)-1
rows=find(TIME_YM(:,1)==UNIQUE_YR(y,1) & TIME_YM(:,2)==10) ...
    % |TIME_YM(:,1)==UNIQUE_YR(y,1) & TIME_YM(:,2)==10) ...
    % | TIME_YM(:,1)==UNIQUE_YR(y,1) & TIME_YM(:,2)==11 ...
    % | TIME_YM(:,1)==UNIQUE_YR(y,1) & TIME_YM(:,2)==12 ...
    % | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==1 ...
    % | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==2 ...
    % | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==3 ...
    % | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==4 ...
    % | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==5 ...
    % | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==6 ...
    % | TIME_YM(:,1)==UNIQUE_YR(y+1,1) & TIME_YM(:,2)==7);
winterFCH4(y,:)=mean(FCH4withsnow(rows,4:30),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE = median(winterFCH4,2, 'omitnan');
SWEperc25 = prctile(winterFCH4, 25,2);
SWEperc75 = prctile(winterFCH4, 75,2);

% optional interpolation
% m12=[1:0.1:84];
% SWEinterp=interp1([1:84],medianSWE,m12,'cubic');
% SWEinterp25 = interp1([1:84], SWEperc25,m12,'cubic');
% SWEinterp75 = interp1([1:84], SWEperc75,m12,'cubic');
% SWEplot2 = plot(SWEinterp, 'blue');

% plot options
hold on
SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
SWEY = [SWEperc25', fliplr(SWEperc75')];
f = fill(SWEX, SWEY, 'red', "FaceAlpha", 0.2, "LineStyle", "none");
hold on
plot(medianSWE,'red')
xticks([1:10:85])
xticklabels(UNIQUE_YR([1:10:85],1))
xlim([0 84])
ylim([0 0.015])
title('RCP8.5')
ylabeltext = ({'Methane flux', 'to atmosphere (gC/m^2/day)'});
ylabel(ylabeltext)
fontsize(15,'points')

%% save plot
set(gcf, 'Position', [100 200 1200 400]);
% % cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/Figures/CLMdefaultTVC/
% cd C:/Users/jadru/'OneDrive - Northumbria University - Production Azure AD'/Documents/Figures/CLMdefaultTVC/proposal
% exportgraphics(gcf, "sturm_vs_default_ch4_rcp85.jpg", "Resolution",300)
