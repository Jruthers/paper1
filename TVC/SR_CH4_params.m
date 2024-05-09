%% SR Jordan 4.5
% RCP4.5 q10 1.5 psi min -2
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
close all
clear all
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/'q10 1.5 psimin -2'/h0

% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp45*');
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

% Snow logic
SWEnew=SWE2100(:,4:9);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% SR rcp4.5 psimin -20
% create a variable containing SR data to 2100 and apply snow logic to get
% SR only when snow is on the ground
clearvars -except SWEnew1
cd ../h2
CaseList=dir('CORDEX*rcp45*');
internalfilestruct='/lnd/hist/'; 
variable=nan(31025,length(CaseList));
for i=1:length(CaseList) 
filepath=strcat(CaseList(i).name,internalfilestruct); 
ncname=dir(strcat(filepath,"*h2.2016-0*.nc"));
variable=ncread(strcat(filepath,ncname.name),'SR');
variable=variable(1,:);
SR(:,i)=variable;
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
SR2100=[TIME_YM 24*3600*SR];
SRwithsnow = SWEnew1.*SR2100(:,4:9);
SRwithsnow = [TIME_YM SRwithsnow];

% Isolate the winter period SR, here sept(9) to july(7) covers the winter
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
winterSR(y,:)=mean(SRwithsnow(rows,4:9),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE = median(winterSR,2, 'omitnan');
SWEperc25 = prctile(winterSR, 25,2);
SWEperc75 = prctile(winterSR, 75,2);

tiledlayout(2,2, "TileSpacing","compact")
nexttile
% hold on
% SWEX = [1:length(SWEperc25'), length(SWEperc75'):-1:1];
% SWEY = [SWEperc25', fliplr(SWEperc75')];
% f = fill(SWEX, SWEY, 'blue', "FaceAlpha", 0.2, "LineStyle", "none");
% hold on
default = plot(medianSWE,'blue');
%% RCP4.5 q10 7.5 psimin -2
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clearvars -except medianSWE
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/'q10 7.5 psimin -2'/h0

% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp45*');
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

% Snow logic
SWEnew=SWE2100(:,4:9);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% SR rcp4.5
% create a variable containing SR data to 2100 and apply snow logic to get
% SR only when snow is on the ground
clearvars -except SWEnew1 medianSWE
cd ../h2
CaseList=dir('CORDEX*rcp45*');
internalfilestruct='/lnd/hist/'; 
variable=nan(31025,length(CaseList));
for i=1:length(CaseList) 
filepath=strcat(CaseList(i).name,internalfilestruct); 
ncname=dir(strcat(filepath,"*h2.2016-0*.nc"));
variable=ncread(strcat(filepath,ncname.name),'SR');
variable=variable(1,:);
SR(:,i)=variable;
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
SR2100=[TIME_YM 24*3600*SR];
SRwithsnow = SWEnew1.*SR2100(:,4:9);
SRwithsnow = [TIME_YM SRwithsnow];

% Isolate the winter period SR, here sept(9) to july(7) covers the winter
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
winterSR(y,:)=mean(SRwithsnow(rows,4:9),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE1 = median(winterSR,2, 'omitnan');
SWEperc25 = prctile(winterSR, 25,2);
SWEperc75 = prctile(winterSR, 75,2);

% optional interpolation
% m12=[1:0.1:84];
% SWEinterp=interp1([1:84],medianSWE,m12,'cubic');
% SWEinterp25 = interp1([1:84], SWEperc25,m12,'cubic');
% SWEinterp75 = interp1([1:84], SWEperc75,m12,'cubic');
% plot(medianSWE1, 'blue');
hold on
SWEX = [1:length(medianSWE1'), length(medianSWE'):-1:1];
SWEY = [medianSWE1', fliplr(medianSWE')];
f = fill(SWEX, SWEY, 'blue', "FaceAlpha", 0.2, "LineStyle", "none");
%% RCP4.5 q10 1.5 psimin -20
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clear all
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/'q10 1.5 psimin -20'/h0
% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp45*');
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

% Snow logic
SWEnew=SWE2100(:,4:9);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% SR rcp4.5
% create a variable containing SR data to 2100 and apply snow logic to get
% SR only when snow is on the ground
clearvars -except SWEnew1
cd ../h2
CaseList=dir('CORDEX*rcp45*');
internalfilestruct='/lnd/hist/'; 
variable=nan(31025,length(CaseList));
for i=1:length(CaseList) 
filepath=strcat(CaseList(i).name,internalfilestruct); 
ncname=dir(strcat(filepath,"*h2.2016-0*.nc"));
variable=ncread(strcat(filepath,ncname.name),'SR');
variable=variable(1,:);
SR(:,i)=variable;
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
SR2100=[TIME_YM 24*3600*SR];
SRwithsnow = SWEnew1.*SR2100(:,4:9);
SRwithsnow = [TIME_YM SRwithsnow];

% Isolate the winter period SR, here sept(9) to july(7) covers the winter
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
winterSR(y,:)=mean(SRwithsnow(rows,4:9),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE1 = median(winterSR,2, 'omitnan');
SWEperc25 = prctile(winterSR, 25,2);
SWEperc75 = prctile(winterSR, 75,2);

hold on
default = plot(medianSWE1,'blue');
%% RCP4.5 q10 7.5 psimin -20
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clearvars -except medianSWE1
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/'q10 7.5 psimin -20'/h0
% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp45*');
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

% Snow logic
SWEnew=SWE2100(:,4:9);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% SR rcp4.5
% create a variable containing SR data to 2100 and apply snow logic to get
% SR only when snow is on the ground
clearvars -except SWEnew1 medianSWE1
cd ../h2
CaseList=dir('CORDEX*rcp45*');
internalfilestruct='/lnd/hist/'; 
variable=nan(31025,length(CaseList));
for i=1:length(CaseList) 
filepath=strcat(CaseList(i).name,internalfilestruct); 
ncname=dir(strcat(filepath,"*h2.2016-0*.nc"));
variable=ncread(strcat(filepath,ncname.name),'SR');
variable=variable(1,:);
SR(:,i)=variable;
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
SR2100=[TIME_YM 24*3600*SR];
SRwithsnow = SWEnew1.*SR2100(:,4:9);
SRwithsnow = [TIME_YM SRwithsnow];

% Isolate the winter period SR, here sept(9) to july(7) covers the winter
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
winterSR(y,:)=mean(SRwithsnow(rows,4:9),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE = median(winterSR,2, 'omitnan');
SWEperc25 = prctile(winterSR, 25,2);
SWEperc75 = prctile(winterSR, 75,2);
% plot options
hold on
SWEX = [1:length(medianSWE1'), length(medianSWE'):-1:1];
SWEY = [medianSWE1', fliplr(medianSWE')];
f = fill(SWEX, SWEY, 'blue', "FaceAlpha", 0.2, "LineStyle", "none");
%% SR Sturm 4.5
%% RCP4.5 q10 1.5 psi min -2
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clear all
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/sturm/'q10 1.5 psimin -2'/h0
% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp45*');
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

% Snow logic
SWEnew=SWE2100(:,4:9);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% SR rcp4.5 psimin -20
% create a variable containing SR data to 2100 and apply snow logic to get
% SR only when snow is on the ground
clearvars -except SWEnew1
cd ../h2
CaseList=dir('CORDEX*rcp45*');
internalfilestruct='/lnd/hist/'; 
variable=nan(31025,length(CaseList));
for i=1:length(CaseList) 
filepath=strcat(CaseList(i).name,internalfilestruct); 
ncname=dir(strcat(filepath,"*h2.2016-0*.nc"));
variable=ncread(strcat(filepath,ncname.name),'SR');
variable=variable(1,:);
SR(:,i)=variable;
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
SR2100=[TIME_YM 24*3600*SR];
SRwithsnow = SWEnew1.*SR2100(:,4:9);
SRwithsnow = [TIME_YM SRwithsnow];

% Isolate the winter period SR, here sept(9) to july(7) covers the winter
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
winterSR(y,:)=mean(SRwithsnow(rows,4:9),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE1 = median(winterSR,2, 'omitnan');
SWEperc25 = prctile(winterSR, 25,2);
SWEperc75 = prctile(winterSR, 75,2);

hold on
default = plot(medianSWE1,'r');
%% RCP4.5 q10 7.5 psimin -2
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clearvars -except medianSWE1
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/sturm/'q10 7.5 psimin -2'/h0/
% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp45*');
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

% Snow logic
SWEnew=SWE2100(:,4:9);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% SR rcp4.5
% create a variable containing SR data to 2100 and apply snow logic to get
% SR only when snow is on the ground
clearvars -except SWEnew1 medianSWE1
cd ../h2
CaseList=dir('CORDEX*rcp45*');
internalfilestruct='/lnd/hist/'; 
variable=nan(31025,length(CaseList));
for i=1:length(CaseList) 
filepath=strcat(CaseList(i).name,internalfilestruct); 
ncname=dir(strcat(filepath,"*h2.2016-0*.nc"));
variable=ncread(strcat(filepath,ncname.name),'SR');
variable=variable(1,:);
SR(:,i)=variable;
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
SR2100=[TIME_YM 24*3600*SR];
SRwithsnow = SWEnew1.*SR2100(:,4:9);
SRwithsnow = [TIME_YM SRwithsnow];

% Isolate the winter period SR, here sept(9) to july(7) covers the winter
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
winterSR(y,:)=mean(SRwithsnow(rows,4:9),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE = median(winterSR,2, 'omitnan');
SWEperc25 = prctile(winterSR, 25,2);
SWEperc75 = prctile(winterSR, 75,2);

hold on
SWEX = [1:length(medianSWE1'), length(medianSWE'):-1:1];
SWEY = [medianSWE1', fliplr(medianSWE')];
f = fill(SWEX, SWEY, 'r', "FaceAlpha", 0.2, "LineStyle", "none");
%% RCP4.5 q10 1.5 psimin -20
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clear all
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/sturm/'q10 1.5 psimin -20'/h0
% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp45*');
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

% Snow logic
SWEnew=SWE2100(:,4:9);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% SR rcp4.5
% create a variable containing SR data to 2100 and apply snow logic to get
% SR only when snow is on the ground
clearvars -except SWEnew1
cd ../h2
CaseList=dir('CORDEX*rcp45*');
internalfilestruct='/lnd/hist/'; 
variable=nan(31025,length(CaseList));
for i=1:length(CaseList) 
filepath=strcat(CaseList(i).name,internalfilestruct); 
ncname=dir(strcat(filepath,"*h2.2016-0*.nc"));
variable=ncread(strcat(filepath,ncname.name),'SR');
variable=variable(1,:);
SR(:,i)=variable;
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
SR2100=[TIME_YM 24*3600*SR];
SRwithsnow = SWEnew1.*SR2100(:,4:9);
SRwithsnow = [TIME_YM SRwithsnow];

% Isolate the winter period SR, here sept(9) to july(7) covers the winter
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
winterSR(y,:)=mean(SRwithsnow(rows,4:9),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE1 = median(winterSR,2, 'omitnan');
SWEperc25 = prctile(winterSR, 25,2);
SWEperc75 = prctile(winterSR, 75,2);

hold on

% hold on
default = plot(medianSWE1,'red');
%% RCP4.5 q10 7.5 psimin -20
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clearvars -except medianSWE1
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/sturm/'q10 7.5 psimin -20'/h0
% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp45*');
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

% Snow logic
SWEnew=SWE2100(:,4:9);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% SR rcp4.5
% create a variable containing SR data to 2100 and apply snow logic to get
% SR only when snow is on the ground
clearvars -except SWEnew1 medianSWE1
cd ../h2
CaseList=dir('CORDEX*rcp45*');
internalfilestruct='/lnd/hist/'; 
variable=nan(31025,length(CaseList));
for i=1:length(CaseList) 
filepath=strcat(CaseList(i).name,internalfilestruct); 
ncname=dir(strcat(filepath,"*h2.2016-0*.nc"));
variable=ncread(strcat(filepath,ncname.name),'SR');
variable=variable(1,:);
SR(:,i)=variable;
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
SR2100=[TIME_YM 24*3600*SR];
SRwithsnow = SWEnew1.*SR2100(:,4:9);
SRwithsnow = [TIME_YM SRwithsnow];

% Isolate the winter period SR, here sept(9) to july(7) covers the winter
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
winterSR(y,:)=mean(SRwithsnow(rows,4:9),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE = median(winterSR,2, 'omitnan');
SWEperc25 = prctile(winterSR, 25,2);
SWEperc75 = prctile(winterSR, 75,2);

hold on
% default = plot(medianSWE,'green');
SWEX = [1:length(medianSWE1'), length(medianSWE'):-1:1];
SWEY = [medianSWE1', fliplr(medianSWE')];
f = fill(SWEX, SWEY, 'r', "FaceAlpha", 0.2, "LineStyle", "none");
hold on
title("RCP 4.5")
xticks(1:10:85)
xticklabels([])
% xticklabels(UNIQUE_YR(1:10:85,1))
xlim([0 84])
ylim([0 1.2])
yticks(0:0.4:1.2)
ylabeltext = ({'CO_2 flux', 'to atmosphere (gC/m^2/day)'});
ylabel(ylabeltext)
fontsize(15,'points')
fprintf("fig1 finished")
%% SR Jordan 8.5
%% RCP8.5 q10 1.5 psi min -2
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clear all
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/'q10 1.5 psimin -2'/h0

% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp85*');
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

% Snow logic
SWEnew=SWE2100(:,4:30);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% SR rcp4.5 psimin -20
% create a variable containing SR data to 2100 and apply snow logic to get
% SR only when snow is on the ground
clearvars -except SWEnew1
cd ../h2
CaseList=dir('CORDEX*rcp85*');
internalfilestruct='/lnd/hist/'; 
variable=nan(31025,length(CaseList));
for i=1:length(CaseList) 
filepath=strcat(CaseList(i).name,internalfilestruct); 
ncname=dir(strcat(filepath,"*h2.2016-0*.nc"));
variable=ncread(strcat(filepath,ncname.name),'SR');
variable=variable(1,:);
SR(:,i)=variable;
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
SR2100=[TIME_YM 24*3600*SR];
SRwithsnow = SWEnew1.*SR2100(:,4:30);
SRwithsnow = [TIME_YM SRwithsnow];

% Isolate the winter period SR, here sept(9) to july(7) covers the winter
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
winterSR(y,:)=mean(SRwithsnow(rows,4:30),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE = median(winterSR,2, 'omitnan');
SWEperc25 = prctile(winterSR, 25,2);
SWEperc75 = prctile(winterSR, 75,2);

nexttile
default = plot(medianSWE,'blue');
%% RCP8.5 q10 7.5 psimin -2
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clearvars -except medianSWE
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/'q10 7.5 psimin -2'/h0

% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp85*');
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

% Snow logic
SWEnew=SWE2100(:,4:30);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% SR rcp4.5
% create a variable containing SR data to 2100 and apply snow logic to get
% SR only when snow is on the ground
clearvars -except SWEnew1 medianSWE
cd ../h2
CaseList=dir('CORDEX*rcp85*');
internalfilestruct='/lnd/hist/'; 
variable=nan(31025,length(CaseList));
for i=1:length(CaseList) 
filepath=strcat(CaseList(i).name,internalfilestruct); 
ncname=dir(strcat(filepath,"*h2.2016-0*.nc"));
variable=ncread(strcat(filepath,ncname.name),'SR');
variable=variable(1,:);
SR(:,i)=variable;
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
SR2100=[TIME_YM 24*3600*SR];
SRwithsnow = SWEnew1.*SR2100(:,4:30);
SRwithsnow = [TIME_YM SRwithsnow];

% Isolate the winter period SR, here sept(9) to july(7) covers the winter
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
winterSR(y,:)=mean(SRwithsnow(rows,4:30),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE1 = median(winterSR,2, 'omitnan');
SWEperc25 = prctile(winterSR, 25,2);
SWEperc75 = prctile(winterSR, 75,2);

hold on
% default = plot(medianSWE1,'r', 'LineWidth', 1);
% hold on
SWEX = [1:length(medianSWE1'), length(medianSWE'):-1:1];
SWEY = [medianSWE1', fliplr(medianSWE')];
f = fill(SWEX, SWEY, 'blue', "FaceAlpha", 0.2, "LineStyle", "none");
%% RCP8.5 q10 1.5 psimin -20
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clear all
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/'q10 1.5 psimin -20'/h0
% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp85*');
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

% Snow logic
SWEnew=SWE2100(:,4:30);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% SR rcp4.5
% create a variable containing SR data to 2100 and apply snow logic to get
% SR only when snow is on the ground
clearvars -except SWEnew1
cd ../h2
CaseList=dir('CORDEX*rcp85*');
internalfilestruct='/lnd/hist/'; 
variable=nan(31025,length(CaseList));
for i=1:length(CaseList) 
filepath=strcat(CaseList(i).name,internalfilestruct); 
ncname=dir(strcat(filepath,"*h2.2016-0*.nc"));
variable=ncread(strcat(filepath,ncname.name),'SR');
variable=variable(1,:);
SR(:,i)=variable;
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
SR2100=[TIME_YM 24*3600*SR];
SRwithsnow = SWEnew1.*SR2100(:,4:30);
SRwithsnow = [TIME_YM SRwithsnow];

% Isolate the winter period SR, here sept(9) to july(7) covers the winter
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
winterSR(y,:)=mean(SRwithsnow(rows,4:30),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE1 = median(winterSR,2, 'omitnan');
SWEperc25 = prctile(winterSR, 25,2);
SWEperc75 = prctile(winterSR, 75,2);

hold on

default = plot(medianSWE1,'blue');
%% RCP8.5 q10 7.5 psimin -20
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clearvars -except medianSWE1
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/'q10 7.5 psimin -20'/h0
% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp85*');
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

% Snow logic
SWEnew=SWE2100(:,4:30);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% SR rcp4.5
% create a variable containing SR data to 2100 and apply snow logic to get
% SR only when snow is on the ground
clearvars -except SWEnew1 medianSWE1
cd ../h2
CaseList=dir('CORDEX*rcp85*');
internalfilestruct='/lnd/hist/'; 
variable=nan(31025,length(CaseList));
for i=1:length(CaseList) 
filepath=strcat(CaseList(i).name,internalfilestruct); 
ncname=dir(strcat(filepath,"*h2.2016-0*.nc"));
variable=ncread(strcat(filepath,ncname.name),'SR');
variable=variable(1,:);
SR(:,i)=variable;
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
SR2100=[TIME_YM 24*3600*SR];
SRwithsnow = SWEnew1.*SR2100(:,4:30);
SRwithsnow = [TIME_YM SRwithsnow];

% Isolate the winter period SR, here sept(9) to july(7) covers the winter
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
winterSR(y,:)=mean(SRwithsnow(rows,4:30),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE = median(winterSR,2, 'omitnan');
SWEperc25 = prctile(winterSR, 25,2);
SWEperc75 = prctile(winterSR, 75,2);

% plot options

hold on
SWEX = [1:length(medianSWE1'), length(medianSWE'):-1:1];
SWEY = [medianSWE1', fliplr(medianSWE')];
f = fill(SWEX, SWEY, 'blue', "FaceAlpha", 0.2, "LineStyle", "none");
%% SR Sturm 8.5
%% RCP8.5 q10 1.5 psi min -2
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clear all
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/sturm/'q10 1.5 psimin -2'/h0
% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp85*');
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

% Snow logic
SWEnew=SWE2100(:,4:30);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% SR rcp4.5 psimin -20
% create a variable containing SR data to 2100 and apply snow logic to get
% SR only when snow is on the ground
clearvars -except SWEnew1
cd ../h2
CaseList=dir('CORDEX*rcp85*');
internalfilestruct='/lnd/hist/'; 
variable=nan(31025,length(CaseList));
for i=1:length(CaseList) 
filepath=strcat(CaseList(i).name,internalfilestruct); 
ncname=dir(strcat(filepath,"*h2.2016-0*.nc"));
variable=ncread(strcat(filepath,ncname.name),'SR');
variable=variable(1,:);
SR(:,i)=variable;
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
SR2100=[TIME_YM 24*3600*SR];
SRwithsnow = SWEnew1.*SR2100(:,4:30);
SRwithsnow = [TIME_YM SRwithsnow];

% Isolate the winter period SR, here sept(9) to july(7) covers the winter
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
winterSR(y,:)=mean(SRwithsnow(rows,4:30),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE1 = median(winterSR,2, 'omitnan');
SWEperc25 = prctile(winterSR, 25,2);
SWEperc75 = prctile(winterSR, 75,2);

hold on
default = plot(medianSWE1,'r');
%% RCP8.5 q10 7.5 psimin -2
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clearvars -except medianSWE1
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/sturm/'q10 7.5 psimin -2'/h0/
% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp85*');
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

% Snow logic
SWEnew=SWE2100(:,4:30);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% SR rcp4.5
% create a variable containing SR data to 2100 and apply snow logic to get
% SR only when snow is on the ground
clearvars -except SWEnew1 medianSWE1
cd ../h2
CaseList=dir('CORDEX*rcp85*');
internalfilestruct='/lnd/hist/'; 
variable=nan(31025,length(CaseList));
for i=1:length(CaseList) 
filepath=strcat(CaseList(i).name,internalfilestruct); 
ncname=dir(strcat(filepath,"*h2.2016-0*.nc"));
variable=ncread(strcat(filepath,ncname.name),'SR');
variable=variable(1,:);
SR(:,i)=variable;
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
SR2100=[TIME_YM 24*3600*SR];
SRwithsnow = SWEnew1.*SR2100(:,4:30);
SRwithsnow = [TIME_YM SRwithsnow];

% Isolate the winter period SR, here sept(9) to july(7) covers the winter
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
winterSR(y,:)=mean(SRwithsnow(rows,4:30),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE = median(winterSR,2, 'omitnan');
SWEperc25 = prctile(winterSR, 25,2);
SWEperc75 = prctile(winterSR, 75,2);

hold on
SWEX = [1:length(medianSWE1'), length(medianSWE'):-1:1];
SWEY = [medianSWE1', fliplr(medianSWE')];
f = fill(SWEX, SWEY, 'r', "FaceAlpha", 0.2, "LineStyle", "none");
%% RCP8.5 q10 1.5 psimin -20
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clear all
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/sturm/'q10 1.5 psimin -20'/h0
% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp85*');
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

% Snow logic
SWEnew=SWE2100(:,4:30);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% SR rcp4.5
% create a variable containing SR data to 2100 and apply snow logic to get
% SR only when snow is on the ground
clearvars -except SWEnew1
cd ../h2
CaseList=dir('CORDEX*rcp85*');
internalfilestruct='/lnd/hist/'; 
variable=nan(31025,length(CaseList));
for i=1:length(CaseList) 
filepath=strcat(CaseList(i).name,internalfilestruct); 
ncname=dir(strcat(filepath,"*h2.2016-0*.nc"));
variable=ncread(strcat(filepath,ncname.name),'SR');
variable=variable(1,:);
SR(:,i)=variable;
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
SR2100=[TIME_YM 24*3600*SR];
SRwithsnow = SWEnew1.*SR2100(:,4:30);
SRwithsnow = [TIME_YM SRwithsnow];

% Isolate the winter period SR, here sept(9) to july(7) covers the winter
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
winterSR(y,:)=mean(SRwithsnow(rows,4:30),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE1 = median(winterSR,2, 'omitnan');
SWEperc25 = prctile(winterSR, 25,2);
SWEperc75 = prctile(winterSR, 75,2);

hold on

% hold on
default = plot(medianSWE1,'red');
%% RCP8.5 q10 7.5 psimin -20
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clearvars -except medianSWE1
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/sturm/'q10 7.5 psimin -20'/h0
% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp85*');
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

% Snow logic
SWEnew=SWE2100(:,4:30);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% SR rcp4.5
% create a variable containing SR data to 2100 and apply snow logic to get
% SR only when snow is on the ground
clearvars -except SWEnew1 medianSWE1
cd ../h2
CaseList=dir('CORDEX*rcp85*');
internalfilestruct='/lnd/hist/'; 
variable=nan(31025,length(CaseList));
for i=1:length(CaseList) 
filepath=strcat(CaseList(i).name,internalfilestruct); 
ncname=dir(strcat(filepath,"*h2.2016-0*.nc"));
variable=ncread(strcat(filepath,ncname.name),'SR');
variable=variable(1,:);
SR(:,i)=variable;
end
variabletime=ncread(strcat(filepath,ncname.name),'time');
TIME=double(variabletime+datenum('2016-01-01','yyyy-mm-dd'));
TIME_YM=str2num(datestr(TIME,'yyyy mm dd'));
SR2100=[TIME_YM 24*3600*SR];
SRwithsnow = SWEnew1.*SR2100(:,4:30);
SRwithsnow = [TIME_YM SRwithsnow];

% Isolate the winter period SR, here sept(9) to july(7) covers the winter
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
winterSR(y,:)=mean(SRwithsnow(rows,4:30),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE = median(winterSR,2, 'omitnan');
SWEperc25 = prctile(winterSR, 25,2);
SWEperc75 = prctile(winterSR, 75,2);

hold on
% default = plot(medianSWE,'green');
SWEX = [1:length(medianSWE1'), length(medianSWE'):-1:1];
SWEY = [medianSWE1', fliplr(medianSWE')];
f = fill(SWEX, SWEY, 'r', "FaceAlpha", 0.2, "LineStyle", "none");
hold on
title("RCP 8.5")
xticks(1:10:85)
xlim([0 84])
ylim([0 1.2])
yticks(0:0.4:1.2)
xticklabels([])
fontsize(15,'points')
fprintf("fig 2 finished")
%% FCH4 Jordan 4.5
%% RCP4.5 q10 1.5 psi min -2
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clear all
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/'q10 1.5 psimin -2'/h0

% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp45*');
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

% Snow logic
SWEnew=SWE2100(:,4:9);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% FCH4 rcp4.5 psimin -20
% create a variable containing FCH4 data to 2100 and apply snow logic to get
% FCH4 only when snow is on the ground
clearvars -except SWEnew1
cd ../h2
CaseList=dir('CORDEX*rcp45*');
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

nexttile

default = plot(medianSWE,'blue');
xticks(1:10:45)
xticklabels(UNIQUE_YR(1:10:45,1))
xlim([0 84])
ylim([0 0.015])
ylabeltext = ({'CO_2 flux', 'to atmosphere (gC/m^2/day)'});
ylabel(ylabeltext)
fontsize(15,'points')
%% RCP4.5 q10 7.5 psimin -2
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clearvars -except medianSWE
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/'q10 7.5 psimin -2'/h0

% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp45*');
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

% Snow logic
SWEnew=SWE2100(:,4:9);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% FCH4 rcp4.5
% create a variable containing FCH4 data to 2100 and apply snow logic to get
% FCH4 only when snow is on the ground
clearvars -except SWEnew1 medianSWE
cd ../h2
CaseList=dir('CORDEX*rcp45*');
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
medianSWE1 = median(winterFCH4,2, 'omitnan');
SWEperc25 = prctile(winterFCH4, 25,2);
SWEperc75 = prctile(winterFCH4, 75,2);

hold on
% default = plot(medianSWE1,'r', 'LineWidth', 1);
% hold on
SWEX = [1:length(medianSWE1'), length(medianSWE'):-1:1];
SWEY = [medianSWE1', fliplr(medianSWE')];
f = fill(SWEX, SWEY, 'blue', "FaceAlpha", 0.2, "LineStyle", "none");
% hold on

xticks(1:10:45)
xticklabels(UNIQUE_YR(1:10:45,1))
xlim([0 84])
ylim([0 0.6])
ylabeltext = ({'CO_2 flux', 'to atmosphere (gC/m^2/day)'});
ylabel(ylabeltext)
fontsize(15,'points')
%% RCP4.5 q10 1.5 psimin -20
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clear all
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/'q10 1.5 psimin -20'/h0
% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp45*');
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

% Snow logic
SWEnew=SWE2100(:,4:9);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% FCH4 rcp4.5
% create a variable containing FCH4 data to 2100 and apply snow logic to get
% FCH4 only when snow is on the ground
clearvars -except SWEnew1
cd ../h2
CaseList=dir('CORDEX*rcp45*');
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
medianSWE1 = median(winterFCH4,2, 'omitnan');
SWEperc25 = prctile(winterFCH4, 25,2);
SWEperc75 = prctile(winterFCH4, 75,2);

hold on

% hold on
default = plot(medianSWE1,'blue');
xticks(1:10:45)
xticklabels(UNIQUE_YR(1:10:45,1))
xlim([0 84])
ylim([0 0.6])
ylabeltext = ({'CO_2 flux', 'to atmosphere (gC/m^2/day)'});
ylabel(ylabeltext)
fontsize(15,'points')
%% RCP4.5 q10 7.5 psimin -20
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clearvars -except medianSWE1
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/'q10 7.5 psimin -20'/h0
% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp45*');
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

% Snow logic
SWEnew=SWE2100(:,4:9);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% FCH4 rcp4.5
% create a variable containing FCH4 data to 2100 and apply snow logic to get
% FCH4 only when snow is on the ground
clearvars -except SWEnew1 medianSWE1
cd ../h2
CaseList=dir('CORDEX*rcp45*');
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

% plot options

hold on
SWEX = [1:length(medianSWE1'), length(medianSWE'):-1:1];
SWEY = [medianSWE1', fliplr(medianSWE')];
f = fill(SWEX, SWEY, 'blue', "FaceAlpha", 0.2, "LineStyle", "none");
hold on
% default = plot(medianSWE,'green');
xticks(1:10:45)
xticklabels(UNIQUE_YR(1:10:45,1))
xlim([0 84])
ylim([0 0.6])
ylabeltext = ({'CO_2 flux', 'to atmosphere (gC/m^2/day)'});
ylabel(ylabeltext)
fontsize(15,'points')
%% FCH4 Sturm 4.5
%% RCP4.5 q10 1.5 psi min -2
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clear all
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/sturm/'q10 1.5 psimin -2'/h0
% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp45*');
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

% Snow logic
SWEnew=SWE2100(:,4:9);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% FCH4 rcp4.5 psimin -20
% create a variable containing FCH4 data to 2100 and apply snow logic to get
% FCH4 only when snow is on the ground
clearvars -except SWEnew1
cd ../h2
CaseList=dir('CORDEX*rcp45*');
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
medianSWE1 = median(winterFCH4,2, 'omitnan');
SWEperc25 = prctile(winterFCH4, 25,2);
SWEperc75 = prctile(winterFCH4, 75,2);

hold on
default = plot(medianSWE1,'r');
xticks(1:10:85)
xticklabels(UNIQUE_YR(1:10:85,1))
ylabeltext = ({'CO_2 flux', 'to atmosphere (gC/m^2/day)'});
ylabel(ylabeltext)
fontsize(15,'points')
%% RCP4.5 q10 7.5 psimin -2
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clearvars -except medianSWE1
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/sturm/'q10 7.5 psimin -2'/h0/
% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp45*');
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

% Snow logic
SWEnew=SWE2100(:,4:9);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% FCH4 rcp4.5
% create a variable containing FCH4 data to 2100 and apply snow logic to get
% FCH4 only when snow is on the ground
clearvars -except SWEnew1 medianSWE1
cd ../h2
CaseList=dir('CORDEX*rcp45*');
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

hold on
SWEX = [1:length(medianSWE1'), length(medianSWE'):-1:1];
SWEY = [medianSWE1', fliplr(medianSWE')];
f = fill(SWEX, SWEY, 'r', "FaceAlpha", 0.2, "LineStyle", "none");
% hold on
% default = plot(medianSWE,'k');
xticks(1:10:85)
xticklabels(UNIQUE_YR(1:10:85,1))
ylabeltext = ({'CO_2 flux', 'to atmosphere (gC/m^2/day)'});
ylabel(ylabeltext)
fontsize(15,'points')
%% RCP4.5 q10 1.5 psimin -20
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clear all
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/sturm/'q10 1.5 psimin -20'/h0
% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp45*');
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

% Snow logic
SWEnew=SWE2100(:,4:9);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% FCH4 rcp4.5
% create a variable containing FCH4 data to 2100 and apply snow logic to get
% FCH4 only when snow is on the ground
clearvars -except SWEnew1
cd ../h2
CaseList=dir('CORDEX*rcp45*');
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
medianSWE1 = median(winterFCH4,2, 'omitnan');
SWEperc25 = prctile(winterFCH4, 25,2);
SWEperc75 = prctile(winterFCH4, 75,2);

hold on

% hold on
default = plot(medianSWE1,'red');
xticks(1:10:85)
xticklabels(UNIQUE_YR(1:10:85,1))
ylabeltext = ({'CO_2 flux', 'to atmosphere (gC/m^2/day)'});
ylabel(ylabeltext)
fontsize(15,'points')
%% RCP4.5 q10 7.5 psimin -20
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clearvars -except medianSWE1
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/sturm/'q10 7.5 psimin -20'/h0
% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp45*');
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

% Snow logic
SWEnew=SWE2100(:,4:9);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% FCH4 rcp4.5
% create a variable containing FCH4 data to 2100 and apply snow logic to get
% FCH4 only when snow is on the ground
clearvars -except SWEnew1 medianSWE1
cd ../h2
CaseList=dir('CORDEX*rcp45*');
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

hold on
% default = plot(medianSWE,'green');
SWEX = [1:length(medianSWE1'), length(medianSWE'):-1:1];
SWEY = [medianSWE1', fliplr(medianSWE')];
f = fill(SWEX, SWEY, 'r', "FaceAlpha", 0.2, "LineStyle", "none");
hold on

xticks(1:10:85)
xticklabels(UNIQUE_YR(1:10:85,1))
xlim([0 84])
ylim([0 0.015])
ylabeltext = ({'CH_4 flux', 'to atmosphere (gC/m^2/day)'});
ylabel(ylabeltext)
fontsize(15,'points')
%% FCH4 Jordan 8.5
%% RCP4.5 q10 1.5 psi min -2
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clear all
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/'q10 1.5 psimin -2'/h0

% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp85*');
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

% Snow logic
SWEnew=SWE2100(:,4:30);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% FCH4 rcp4.5 psimin -20
% create a variable containing FCH4 data to 2100 and apply snow logic to get
% FCH4 only when snow is on the ground
clearvars -except SWEnew1
cd ../h2
CaseList=dir('CORDEX*rcp85*');
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
winterFCH4(y,:)=mean(FCH4withsnow(rows,4:30),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE = median(winterFCH4,2, 'omitnan');
SWEperc25 = prctile(winterFCH4, 25,2);
SWEperc75 = prctile(winterFCH4, 75,2);

nexttile

default = plot(medianSWE,'blue');
xticks(1:10:45)
xticklabels(UNIQUE_YR(1:10:45,1))
fontsize(15,'points')
%% RCP4.5 q10 7.5 psimin -2
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clearvars -except medianSWE
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/'q10 7.5 psimin -2'/h0

% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp85*');
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

% Snow logic
SWEnew=SWE2100(:,4:30);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% FCH4 rcp4.5
% create a variable containing FCH4 data to 2100 and apply snow logic to get
% FCH4 only when snow is on the ground
clearvars -except SWEnew1 medianSWE
cd ../h2
CaseList=dir('CORDEX*rcp85*');
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
winterFCH4(y,:)=mean(FCH4withsnow(rows,4:30),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE1 = median(winterFCH4,2, 'omitnan');
SWEperc25 = prctile(winterFCH4, 25,2);
SWEperc75 = prctile(winterFCH4, 75,2);

hold on
% default = plot(medianSWE1,'r', 'LineWidth', 1);
% hold on
SWEX = [1:length(medianSWE1'), length(medianSWE'):-1:1];
SWEY = [medianSWE1', fliplr(medianSWE')];
f = fill(SWEX, SWEY, 'blue', "FaceAlpha", 0.2, "LineStyle", "none");
% hold on

xticks(1:10:45)
xticklabels(UNIQUE_YR(1:10:45,1))
fontsize(15,'points')
%% RCP4.5 q10 1.5 psimin -20
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clear all
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/'q10 1.5 psimin -20'/h0
% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp85*');
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

% Snow logic
SWEnew=SWE2100(:,4:30);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% FCH4 rcp4.5
% create a variable containing FCH4 data to 2100 and apply snow logic to get
% FCH4 only when snow is on the ground
clearvars -except SWEnew1
cd ../h2
CaseList=dir('CORDEX*rcp85*');
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
winterFCH4(y,:)=mean(FCH4withsnow(rows,4:30),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE1 = median(winterFCH4,2, 'omitnan');
SWEperc25 = prctile(winterFCH4, 25,2);
SWEperc75 = prctile(winterFCH4, 75,2);

hold on

default = plot(medianSWE1,'blue');
xticks(1:10:45)
xticklabels(UNIQUE_YR(1:10:45,1))
fontsize(15,'points')
%% RCP4.5 q10 7.5 psimin -20
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clearvars -except medianSWE1
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/'q10 7.5 psimin -20'/h0
% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp85*');
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

% Snow logic
SWEnew=SWE2100(:,4:30);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% FCH4 rcp4.5
% create a variable containing FCH4 data to 2100 and apply snow logic to get
% FCH4 only when snow is on the ground
clearvars -except SWEnew1 medianSWE1
cd ../h2
CaseList=dir('CORDEX*rcp85*');
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
winterFCH4(y,:)=mean(FCH4withsnow(rows,4:30),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE = median(winterFCH4,2, 'omitnan');
SWEperc25 = prctile(winterFCH4, 25,2);
SWEperc75 = prctile(winterFCH4, 75,2);

% plot options

hold on
SWEX = [1:length(medianSWE1'), length(medianSWE'):-1:1];
SWEY = [medianSWE1', fliplr(medianSWE')];
f = fill(SWEX, SWEY, 'blue', "FaceAlpha", 0.2, "LineStyle", "none");
hold on
% default = plot(medianSWE,'green');
xticks(1:10:45)
xticklabels(UNIQUE_YR(1:10:45,1))
fontsize(15,'points')
%% FCH4 Sturm 8.5
%% RCP4.5 q10 1.5 psi min -2
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clear all
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/sturm/'q10 1.5 psimin -2'/h0
% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp85*');
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

% Snow logic
SWEnew=SWE2100(:,4:30);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% FCH4 rcp4.5 psimin -20
% create a variable containing FCH4 data to 2100 and apply snow logic to get
% FCH4 only when snow is on the ground
clearvars -except SWEnew1
cd ../h2
CaseList=dir('CORDEX*rcp85*');
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
winterFCH4(y,:)=mean(FCH4withsnow(rows,4:30),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE1 = median(winterFCH4,2, 'omitnan');
SWEperc25 = prctile(winterFCH4, 25,2);
SWEperc75 = prctile(winterFCH4, 75,2);

hold on
default = plot(medianSWE1,'r');
xticks(1:10:85)
xticklabels(UNIQUE_YR(1:10:85,1))
fontsize(15,'points')
%% RCP4.5 q10 7.5 psimin -2
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clearvars -except medianSWE1
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/sturm/'q10 7.5 psimin -2'/h0/
% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp85*');
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

% Snow logic
SWEnew=SWE2100(:,4:30);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% FCH4 rcp4.5
% create a variable containing FCH4 data to 2100 and apply snow logic to get
% FCH4 only when snow is on the ground
clearvars -except SWEnew1 medianSWE1
cd ../h2
CaseList=dir('CORDEX*rcp85*');
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
winterFCH4(y,:)=mean(FCH4withsnow(rows,4:30),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE = median(winterFCH4,2, 'omitnan');
SWEperc25 = prctile(winterFCH4, 25,2);
SWEperc75 = prctile(winterFCH4, 75,2);

hold on
SWEX = [1:length(medianSWE1'), length(medianSWE'):-1:1];
SWEY = [medianSWE1', fliplr(medianSWE')];
f = fill(SWEX, SWEY, 'r', "FaceAlpha", 0.2, "LineStyle", "none");
% hold on
% default = plot(medianSWE,'k');
xticks(1:10:85)
xticklabels(UNIQUE_YR(1:10:85,1))
fontsize(15,'points')
%% RCP4.5 q10 1.5 psimin -20
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clear all
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/sturm/'q10 1.5 psimin -20'/h0
% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp85*');
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

% Snow logic
SWEnew=SWE2100(:,4:30);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% FCH4 rcp4.5
% create a variable containing FCH4 data to 2100 and apply snow logic to get
% FCH4 only when snow is on the ground
clearvars -except SWEnew1
cd ../h2
CaseList=dir('CORDEX*rcp85*');
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
winterFCH4(y,:)=mean(FCH4withsnow(rows,4:30),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE1 = median(winterFCH4,2, 'omitnan');
SWEperc25 = prctile(winterFCH4, 25,2);
SWEperc75 = prctile(winterFCH4, 75,2);

hold on

% hold on
default = plot(medianSWE1,'red');
xticks(1:10:85)
xticklabels(UNIQUE_YR(1:10:85,1))
fontsize(15,'points')
%% RCP4.5 q10 7.5 psimin -20
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clearvars -except medianSWE1
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/MATLAB/TVCdaily/sturm/'q10 7.5 psimin -20'/h0
% cd D:\MATLAB\TVCdaily\h0
CaseList=dir('CORDEX*rcp85*');
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

% Snow logic
SWEnew=SWE2100(:,4:30);
SWEnew(SWEnew<5)=NaN;
SWEnew(SWEnew>0)=1;
totsnowon = nansum(SWEnew,2);
% new variable showing only where all members show snow on
logical_index = all(SWEnew == 1, 2);
SWEnew1 = SWEnew;
% Replace the values in between these occurrences with NaN
SWEnew1(~logical_index, :) = NaN;
totsnowon2100=[TIME_YM totsnowon];

% FCH4 rcp4.5
% create a variable containing FCH4 data to 2100 and apply snow logic to get
% FCH4 only when snow is on the ground
clearvars -except SWEnew1 medianSWE1
cd ../h2
CaseList=dir('CORDEX*rcp85*');
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
winterFCH4(y,:)=mean(FCH4withsnow(rows,4:30),'omitnan');
end

% calculate medians and percentiles and plot
medianSWE = median(winterFCH4,2, 'omitnan');
SWEperc25 = prctile(winterFCH4, 25,2);
SWEperc75 = prctile(winterFCH4, 75,2);

hold on
% default = plot(medianSWE,'green');
SWEX = [1:length(medianSWE1'), length(medianSWE'):-1:1];
SWEY = [medianSWE1', fliplr(medianSWE')];
f = fill(SWEX, SWEY, 'r', "FaceAlpha", 0.2, "LineStyle", "none");
hold on

xticks(1:10:85)
xticklabels(UNIQUE_YR(1:10:85,1))
xlim([0 84])
ylim([0 0.015])
fontsize(15,'points')
%% letters
annotation('textbox', [0.452392115656364 0.862744983161598 0.0329015544041452 0.0536062378167641], 'String', 'a', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'bold')
annotation('textbox', [0.88895322294286 0.862744983161598 0.0334196891191709 0.0536062378167641], 'String', 'b', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'bold')
annotation('textbox', [0.452392115656364 0.418963882523489 0.0329015544041451 0.053606237816764], 'String', 'c', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'bold')
annotation('textbox', [0.88895322294286 0.418963882523489 0.0334196891191711 0.053606237816764], 'String', 'd', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'bold')
%% save plot
set(gcf, 'Position', [100 200 1100 450]);
cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/Figures/CLMdefaultTVC/
% cd C:/Users/jadru/'OneDrive - Northumbria University - Production Azure AD'/Documents/Figures/CLMdefaultTVC/proposal
exportgraphics(gcf, "sturm_vs_default_2.jpg", "Resolution",300)
