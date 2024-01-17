%% Default Snowdown SR RCP 4.5

% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clear all
% cd D:\MATLAB\TVCdaily\h0
cd /Volumes/'JR SSD'/MATLAB/TVCdaily/h0
% SWE2100 = extractvar('H2OSNO','rcp45');
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

% Snow logic: create a SWE variable of 1s and 0s that can be applied to
% other variables
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

% Extract SR and apply snow logic to get SR only when snow is above the 5mm
% threshold
clearvars -except SWEnew1
cd ../h2
CaseList=dir('CORDEX_Default*rcp45*');
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
%% Default RCP 4.5 cumulative
% Extract SR data for our two 30 year time periods and assemble the data
% from sept to june in order to cover the snow down period, and accumulate.

indicestoget=find(SRwithsnow(:,1) >= 2016 & SRwithsnow(:,1) <= 2046);
SR20162046=SRwithsnow(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(SR20162046(:,2)==m & SR20162046(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
SRmedian1(c,1)=m;
SRmedian1(c,2)=d;
SRmedian1(c,3) = nanmedian(SR20162046(rows,4:end),'all');
        end
    end
end
indicestoget=find(SRwithsnow(:,1) >= 2066 & SRwithsnow(:,1) <= 2096);
SR20662096=SRwithsnow(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(SR20662096(:,2)==m & SR20662096(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
SRmedian2(c,1)=m;
SRmedian2(c,2)=d;
SRmedian2(c,3) = nanmedian(SR20662096(rows,4:end),'all');
        end
    end
end

%cumulative
NeworderSRMedian1=[];
NeworderSRMedian1=SRmedian1(find(SRmedian1(:,1)==9),:);
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==10),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==11),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==12),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==1),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==2),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==3),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==4),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==5),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==6),:));
d183=[1:183];
NeworderSRMedian1cumu=cumsum(NeworderSRMedian1(:,3), 'omitnan');

NeworderSRMedian2=[];
NeworderSRMedian2=SRmedian2(find(SRmedian2(:,1)==9),:);
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==10),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==11),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==12),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==1),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==2),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==3),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==4),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==5),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==6),:));
NeworderSRMedian2cumu=cumsum(NeworderSRMedian2(:,3), 'omitnan');
SRi_2046sum=NeworderSRMedian1cumu(:,1);   %interp1([1:12],SRmedian1,m12,'cubic');
SRi_2096sum=NeworderSRMedian2cumu(:,1); 

figure('Position', [100, 100, 600, 400]);
subplot(2,2,1)
p1 = plot([1:304], (SRi_2046sum), 'black');
hold on
p2 = plot([1:304], (SRi_2096sum), 'red');
set(gca, 'xtick' ,[0:20:304]);
hold on
xlim([0 304])
%% Sturm Snowdown SR RCP 4.5
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clearvars -except p1 p2
cd ../sturm/h0
% SWE2100 = extractvar('H2OSNO','rcp45');
CaseList=dir('CORDEX_*rcp45*');
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

% Snow logic: create a SWE variable of 1s and 0s that can be applied to
% other variables
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

% Extract SR and apply snow logic to get SR only when snow is above the 5mm
% threshold
clearvars -except SWEnew1 p1 p2
cd ../h2
CaseList=dir('CORDEX_*rcp45*');
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
%% Sturm RCP 4.5 cumulative
indicestoget=find(SRwithsnow(:,1) >= 2016 & SRwithsnow(:,1) <= 2046);
SR20162046=SRwithsnow(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(SR20162046(:,2)==m & SR20162046(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
SRmedian1(c,1)=m;
SRmedian1(c,2)=d;
SRmedian1(c,3) = nanmedian(SR20162046(rows,4:end),'all');
        end
    end
end
indicestoget=find(SRwithsnow(:,1) >= 2066 & SRwithsnow(:,1) <= 2096);
SR20662096=SRwithsnow(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(SR20662096(:,2)==m & SR20662096(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
SRmedian2(c,1)=m;
SRmedian2(c,2)=d;
SRmedian2(c,3) = nanmedian(SR20662096(rows,4:end),'all');
        end
    end
end

NeworderSRMedian1=[];
NeworderSRMedian1=SRmedian1(find(SRmedian1(:,1)==9),:);
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==10),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==11),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==12),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==1),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==2),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==3),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==4),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==5),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==6),:));
d183=[1:183];
NeworderSRMedian1cumu=cumsum(NeworderSRMedian1(:,3), 'omitnan');

NeworderSRMedian2=[];
NeworderSRMedian2=SRmedian2(find(SRmedian2(:,1)==9),:);
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==10),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==11),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==12),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==1),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==2),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==3),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==4),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==5),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==6),:));
NeworderSRMedian2cumu=cumsum(NeworderSRMedian2(:,3), 'omitnan');
SRi_2046sum=NeworderSRMedian1cumu(:,1);   %interp1([1:12],SRmedian1,m12,'cubic');
SRi_2096sum=NeworderSRMedian2cumu(:,1); 

hold on
p3 = plot([1:304], (SRi_2046sum), 'k--');
hold on
p4 = plot([1:304], (SRi_2096sum), 'r--');
set(gca, 'xtick' ,[0:20:304]);
hold on
xlim([0 304])
ylim([0 40])
ylabeltext = ({"Cumulative CO_2 flux", "to the atmosphere (gC/m^2/day)"});
ylabel(ylabeltext)
% ylabel('Cumulative Soil Respiration (gC/m^2/day)')
% xlabel('Days since 1^{st} Sep')
title('RCP 4.5')
legend([p1 p2 p3 p4], {'Default 2016-2046', 'Default 2066-2096', 'Sturm 2016-2046', 'Sturm 2066-2096'}, "Location", "southeast", 'FontSize', 7);
%% Default Snowdown SR RCP 8.5

% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clear all
% cd D:\MATLAB\TVCdaily\h0
cd /Volumes/'JR SSD'/MATLAB/TVCdaily/h0
% SWE2100 = extractvar('H2OSNO','rcp85');
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

% Snow logic: create a SWE variable of 1s and 0s that can be applied to
% other variables
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

% Extract SR and apply snow logic to get SR only when snow is above the 5mm
% threshold
clearvars -except SWEnew1
cd ../h2
CaseList=dir('CORDEX_Default*rcp85*');
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
%% Default RCP 8.5 cumulative
% Extract SR data for our two 30 year time periods and assemble the data
% from sept to june in order to cover the snow down period, and accumulate.

indicestoget=find(SRwithsnow(:,1) >= 2016 & SRwithsnow(:,1) <= 2046);
SR20162046=SRwithsnow(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(SR20162046(:,2)==m & SR20162046(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
SRmedian1(c,1)=m;
SRmedian1(c,2)=d;
SRmedian1(c,3) = nanmedian(SR20162046(rows,4:end),'all');
        end
    end
end
indicestoget=find(SRwithsnow(:,1) >= 2066 & SRwithsnow(:,1) <= 2096);
SR20662096=SRwithsnow(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(SR20662096(:,2)==m & SR20662096(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
SRmedian2(c,1)=m;
SRmedian2(c,2)=d;
SRmedian2(c,3) = nanmedian(SR20662096(rows,4:end),'all');
        end
    end
end

%cumulative
NeworderSRMedian1=[];
NeworderSRMedian1=SRmedian1(find(SRmedian1(:,1)==9),:);
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==10),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==11),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==12),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==1),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==2),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==3),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==4),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==5),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==6),:));
d183=[1:183];
NeworderSRMedian1cumu=cumsum(NeworderSRMedian1(:,3), 'omitnan');

NeworderSRMedian2=[];
NeworderSRMedian2=SRmedian2(find(SRmedian2(:,1)==9),:);
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==10),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==11),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==12),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==1),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==2),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==3),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==4),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==5),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==6),:));
NeworderSRMedian2cumu=cumsum(NeworderSRMedian2(:,3), 'omitnan');
SRi_2046sum=NeworderSRMedian1cumu(:,1);   %interp1([1:12],SRmedian1,m12,'cubic');
SRi_2096sum=NeworderSRMedian2cumu(:,1); 

subplot(2,2,2)
p1 = plot([1:304], (SRi_2046sum), 'black');
hold on
p2 = plot([1:304], (SRi_2096sum), 'red');
set(gca, 'xtick' ,[0:20:304]);
hold on
xlim([0 304])
%% Sturm Snowdown SR RCP 8.5
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clearvars -except p1 p2
cd ../sturm/h0
% SWE2100 = extractvar('H2OSNO','rcp85');
CaseList=dir('CORDEX_*rcp85*');
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

% Snow logic: create a SWE variable of 1s and 0s that can be applied to
% other variables
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

% Extract SR and apply snow logic to get SR only when snow is above the 5mm
% threshold
clearvars -except SWEnew1 p1 p2
cd ../h2
CaseList=dir('CORDEX_*rcp85*');
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
%% Sturm RCP 8.5 cumulative
indicestoget=find(SRwithsnow(:,1) >= 2016 & SRwithsnow(:,1) <= 2046);
SR20162046=SRwithsnow(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(SR20162046(:,2)==m & SR20162046(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
SRmedian1(c,1)=m;
SRmedian1(c,2)=d;
SRmedian1(c,3) = nanmedian(SR20162046(rows,4:end),'all');
        end
    end
end
indicestoget=find(SRwithsnow(:,1) >= 2066 & SRwithsnow(:,1) <= 2096);
SR20662096=SRwithsnow(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(SR20662096(:,2)==m & SR20662096(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
SRmedian2(c,1)=m;
SRmedian2(c,2)=d;
SRmedian2(c,3) = nanmedian(SR20662096(rows,4:end),'all');
        end
    end
end

NeworderSRMedian1=[];
NeworderSRMedian1=SRmedian1(find(SRmedian1(:,1)==9),:);
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==10),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==11),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==12),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==1),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==2),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==3),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==4),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==5),:));
NeworderSRMedian1=cat(1,NeworderSRMedian1,SRmedian1(find(SRmedian1(:,1)==6),:));
d183=[1:183];
NeworderSRMedian1cumu=cumsum(NeworderSRMedian1(:,3), 'omitnan');

NeworderSRMedian2=[];
NeworderSRMedian2=SRmedian2(find(SRmedian2(:,1)==9),:);
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==10),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==11),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==12),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==1),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==2),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==3),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==4),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==5),:));
NeworderSRMedian2=cat(1,NeworderSRMedian2,SRmedian2(find(SRmedian2(:,1)==6),:));
NeworderSRMedian2cumu=cumsum(NeworderSRMedian2(:,3), 'omitnan');
SRi_2046sum=NeworderSRMedian1cumu(:,1);   %interp1([1:12],SRmedian1,m12,'cubic');
SRi_2096sum=NeworderSRMedian2cumu(:,1); 

hold on
p3 = plot([1:304], (SRi_2046sum), 'k--');
hold on
p4 = plot([1:304], (SRi_2096sum), 'r--');
set(gca, 'xtick' ,[0:20:304]);
hold on
ylim([0 40])
xlim([0 304])
% xlabel('Days since 1^{st} Sep')
title('RCP 8.5')
%% Default Snowdown FCH4 RCP 4.5
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clear all
% cd D:\MATLAB\TVCdaily\h0
cd /Volumes/'JR SSD'/MATLAB/TVCdaily/h0
% SWE2100 = extractvar('H2OSNO','rcp45');
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

% Snow logic: create a SWE variable of 1s and 0s that can be applied to
% other variables
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

% Extract FCH4 and apply snow logic to get FCH4 only when snow is above the 5mm
% threshold
clearvars -except SWEnew1
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
%% Default RCP 4.5 cumulative
% Extract FCH4 data for our two 30 year time periods and assemble the data
% from sept to june in order to cover the snow down period, and accumulate.

indicestoget=find(FCH4withsnow(:,1) >= 2016 & FCH4withsnow(:,1) <= 2046);
FCH420162046=FCH4withsnow(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(FCH420162046(:,2)==m & FCH420162046(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
FCH4median1(c,1)=m;
FCH4median1(c,2)=d;
FCH4median1(c,3) = nanmedian(FCH420162046(rows,4:end),'all');
        end
    end
end
indicestoget=find(FCH4withsnow(:,1) >= 2066 & FCH4withsnow(:,1) <= 2096);
FCH420662096=FCH4withsnow(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(FCH420662096(:,2)==m & FCH420662096(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
FCH4median2(c,1)=m;
FCH4median2(c,2)=d;
FCH4median2(c,3) = nanmedian(FCH420662096(rows,4:end),'all');
        end
    end
end

%cumulative
NeworderFCH4Median1=[];
NeworderFCH4Median1=FCH4median1(find(FCH4median1(:,1)==9),:);
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==10),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==11),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==12),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==1),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==2),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==3),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==4),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==5),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==6),:));
d183=[1:183];
NeworderFCH4Median1cumu=cumsum(NeworderFCH4Median1(:,3), 'omitnan');

NeworderFCH4Median2=[];
NeworderFCH4Median2=FCH4median2(find(FCH4median2(:,1)==9),:);
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==10),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==11),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==12),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==1),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==2),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==3),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==4),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==5),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==6),:));
NeworderFCH4Median2cumu=cumsum(NeworderFCH4Median2(:,3), 'omitnan');
FCH4i_2046sum=NeworderFCH4Median1cumu(:,1);   %interp1([1:12],FCH4median1,m12,'cubic');
FCH4i_2096sum=NeworderFCH4Median2cumu(:,1); 

subplot(2,2,3)
p1 = plot([1:304], (FCH4i_2046sum), 'black');
hold on
p2 = plot([1:304], (FCH4i_2096sum), 'red');
set(gca, 'xtick' ,[0:20:304]);
hold on
xlim([0 304])
%% Sturm Snowdown FCH4 RCP 4.5
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clearvars -except p1 p2
cd ../sturm/h0
% SWE2100 = extractvar('H2OSNO','rcp45');
CaseList=dir('CORDEX_*rcp45*');
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

% Snow logic: create a SWE variable of 1s and 0s that can be applied to
% other variables
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

% Extract FCH4 and apply snow logic to get FCH4 only when snow is above the 5mm
% threshold
clearvars -except SWEnew1 p1 p2
cd ../h2
CaseList=dir('CORDEX_*rcp45*');
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
%% Sturm RCP 4.5 cumulative
indicestoget=find(FCH4withsnow(:,1) >= 2016 & FCH4withsnow(:,1) <= 2046);
FCH420162046=FCH4withsnow(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(FCH420162046(:,2)==m & FCH420162046(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
FCH4median1(c,1)=m;
FCH4median1(c,2)=d;
FCH4median1(c,3) = nanmedian(FCH420162046(rows,4:end),'all');
        end
    end
end
indicestoget=find(FCH4withsnow(:,1) >= 2066 & FCH4withsnow(:,1) <= 2096);
FCH420662096=FCH4withsnow(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(FCH420662096(:,2)==m & FCH420662096(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
FCH4median2(c,1)=m;
FCH4median2(c,2)=d;
FCH4median2(c,3) = nanmedian(FCH420662096(rows,4:end),'all');
        end
    end
end

NeworderFCH4Median1=[];
NeworderFCH4Median1=FCH4median1(find(FCH4median1(:,1)==9),:);
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==10),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==11),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==12),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==1),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==2),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==3),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==4),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==5),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==6),:));
d183=[1:183];
NeworderFCH4Median1cumu=cumsum(NeworderFCH4Median1(:,3), 'omitnan');

NeworderFCH4Median2=[];
NeworderFCH4Median2=FCH4median2(find(FCH4median2(:,1)==9),:);
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==10),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==11),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==12),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==1),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==2),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==3),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==4),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==5),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==6),:));
NeworderFCH4Median2cumu=cumsum(NeworderFCH4Median2(:,3), 'omitnan');
FCH4i_2046sum=NeworderFCH4Median1cumu(:,1);   %interp1([1:12],FCH4median1,m12,'cubic');
FCH4i_2096sum=NeworderFCH4Median2cumu(:,1); 

hold on
p3 = plot([1:304], (FCH4i_2046sum), 'k--');
hold on
p4 = plot([1:304], (FCH4i_2096sum), 'r--');
set(gca, 'xtick' ,[0:20:304]);
hold on
xlim([0 304])
ylim([0 1])
ylabeltext = ({"Cumulative CH_4 flux", "to the atmosphere (gC/m^2/day)"});
ylabel(ylabeltext)
% ylabel('Cumulative Soil Respiration (gC/m^2/day)')
xlabel('Days since 1^{st} Sep')
% legend([p1 p2 p3 p4], {'Default 2016-2046', 'Default 2066-2096', 'Sturm 2016-2046', 'Sturm 2066-2096'}, Location="southeast");
%% Default Snowdown FCH4 RCP 8.5
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clear all
% cd D:\MATLAB\TVCdaily\h0
cd /Volumes/'JR SSD'/MATLAB/TVCdaily/h0
% SWE2100 = extractvar('H2OSNO','rcp85');
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

% Snow logic: create a SWE variable of 1s and 0s that can be applied to
% other variables
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

% Extract FCH4 and apply snow logic to get FCH4 only when snow is above the 5mm
% threshold
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
%% Default RCP 8.5 cumulative
% Extract FCH4 data for our two 30 year time periods and assemble the data
% from sept to june in order to cover the snow down period, and accumulate.

indicestoget=find(FCH4withsnow(:,1) >= 2016 & FCH4withsnow(:,1) <= 2046);
FCH420162046=FCH4withsnow(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(FCH420162046(:,2)==m & FCH420162046(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
FCH4median1(c,1)=m;
FCH4median1(c,2)=d;
FCH4median1(c,3) = nanmedian(FCH420162046(rows,4:end),'all');
        end
    end
end
indicestoget=find(FCH4withsnow(:,1) >= 2066 & FCH4withsnow(:,1) <= 2096);
FCH420662096=FCH4withsnow(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(FCH420662096(:,2)==m & FCH420662096(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
FCH4median2(c,1)=m;
FCH4median2(c,2)=d;
FCH4median2(c,3) = nanmedian(FCH420662096(rows,4:end),'all');
        end
    end
end

%cumulative
NeworderFCH4Median1=[];
NeworderFCH4Median1=FCH4median1(find(FCH4median1(:,1)==9),:);
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==10),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==11),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==12),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==1),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==2),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==3),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==4),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==5),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==6),:));
d183=[1:183];
NeworderFCH4Median1cumu=cumsum(NeworderFCH4Median1(:,3), 'omitnan');

NeworderFCH4Median2=[];
NeworderFCH4Median2=FCH4median2(find(FCH4median2(:,1)==9),:);
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==10),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==11),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==12),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==1),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==2),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==3),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==4),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==5),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==6),:));
NeworderFCH4Median2cumu=cumsum(NeworderFCH4Median2(:,3), 'omitnan');
FCH4i_2046sum=NeworderFCH4Median1cumu(:,1);   %interp1([1:12],FCH4median1,m12,'cubic');
FCH4i_2096sum=NeworderFCH4Median2cumu(:,1); 

subplot(2,2,4)
p1 = plot([1:304], (FCH4i_2046sum), 'black');
hold on
p2 = plot([1:304], (FCH4i_2096sum), 'red');
set(gca, 'xtick' ,[0:20:304]);
hold on
xlim([0 304])
%% Sturm Snowdown FCH4 RCP 8.5
% This section extacts SWE data from output files for RCP4.5 and places it
% into a new variable with matlab timestamps (SWE2100)
clearvars -except p1 p2
cd ../sturm/h0
% SWE2100 = extractvar('H2OSNO','rcp85');
CaseList=dir('CORDEX_*rcp85*');
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

% Snow logic: create a SWE variable of 1s and 0s that can be applied to
% other variables
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

% Extract FCH4 and apply snow logic to get FCH4 only when snow is above the 5mm
% threshold
clearvars -except SWEnew1 p1 p2
cd ../h2
CaseList=dir('CORDEX_*rcp85*');
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
%% Sturm RCP 8.5 cumulative
indicestoget=find(FCH4withsnow(:,1) >= 2016 & FCH4withsnow(:,1) <= 2046);
FCH420162046=FCH4withsnow(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(FCH420162046(:,2)==m & FCH420162046(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
FCH4median1(c,1)=m;
FCH4median1(c,2)=d;
FCH4median1(c,3) = nanmedian(FCH420162046(rows,4:end),'all');
        end
    end
end
indicestoget=find(FCH4withsnow(:,1) >= 2066 & FCH4withsnow(:,1) <= 2096);
FCH420662096=FCH4withsnow(indicestoget,:);
c=0;
for m=1:12
    for d=1:31
        rows=find(FCH420662096(:,2)==m & FCH420662096(:,3)==d);
        if isempty(rows)==1
        else
            c=c+1;
FCH4median2(c,1)=m;
FCH4median2(c,2)=d;
FCH4median2(c,3) = nanmedian(FCH420662096(rows,4:end),'all');
        end
    end
end

NeworderFCH4Median1=[];
NeworderFCH4Median1=FCH4median1(find(FCH4median1(:,1)==9),:);
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==10),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==11),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==12),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==1),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==2),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==3),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==4),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==5),:));
NeworderFCH4Median1=cat(1,NeworderFCH4Median1,FCH4median1(find(FCH4median1(:,1)==6),:));
d183=[1:183];
NeworderFCH4Median1cumu=cumsum(NeworderFCH4Median1(:,3), 'omitnan');

NeworderFCH4Median2=[];
NeworderFCH4Median2=FCH4median2(find(FCH4median2(:,1)==9),:);
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==10),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==11),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==12),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==1),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==2),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==3),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==4),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==5),:));
NeworderFCH4Median2=cat(1,NeworderFCH4Median2,FCH4median2(find(FCH4median2(:,1)==6),:));
NeworderFCH4Median2cumu=cumsum(NeworderFCH4Median2(:,3), 'omitnan');
FCH4i_2046sum=NeworderFCH4Median1cumu(:,1);   %interp1([1:12],FCH4median1,m12,'cubic');
FCH4i_2096sum=NeworderFCH4Median2cumu(:,1); 

hold on
p3 = plot([1:304], (FCH4i_2046sum), 'k--');
hold on
p4 = plot([1:304], (FCH4i_2096sum), 'r--');
set(gca, 'xtick' ,[0:20:304]);
hold on
ylim([0 1])
xlim([0 304])
xlabel('Days since 1^{st} Sep')