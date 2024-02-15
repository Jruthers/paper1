%% ISOLATE RCP4.5
clear all
FilesList=dir('mbcn.CA-TVC.NAM-*rcp45*.csv'); % makes a list of all ensemble member files

for j=1:length(FilesList)  % cycles through each  file in the filelist
Output=readtable(FilesList(j).name); % read the csv file into MATLAB
datestamp=datenum(num2str(table2array([Output(:,1),Output(:,2),Output(:,3)])));   % Get the time for the x axis
[UniqueCombos UniqueRowStart RowsofEachUniqueCombo]=unique(Output(:,1:2),'rows');
for i=1:max(RowsofEachUniqueCombo)
rowsneeded=find(RowsofEachUniqueCombo==i);
HPCmonthlyprecip(i,j)=mean(Output.pr(rowsneeded));
HPCmonthlyTime(i,1)=mean(Output.year(rowsneeded));
HPCmonthlyTime(i,2)=mean(Output.month(rowsneeded));
HPCmonthlyTmin(i,j)=mean(Output.tn(rowsneeded));
HPCmonthlyTmax(i,j)=mean(Output.tx(rowsneeded));
HPCmonthlyTmean(i,j)=0.5*(HPCmonthlyTmin(i,j)+HPCmonthlyTmax(i,j));
HPCmonthlyPtot(i,j)=sum(Output.pr(rowsneeded)*60*60*24);
end
end
HPCmonthlyprecip=HPCmonthlyprecip*60*60*24;
HPCMonthlyP2090=[HPCmonthlyTime HPCmonthlyprecip];
HPCMonthlyT2090=[HPCmonthlyTime HPCmonthlyTmean];
HPCMonthlyPtot2090=[HPCmonthlyTime HPCmonthlyPtot];
%% Raincloud April
Precip_scalefactor=0.5;
standardP=50;
clear h1
clear h2
% tiledlayout(4,2, "TileSpacing", "compact")
Fig1 = figure(1);
p = get(0, "MonitorPositions");
Fig1.Position = p(1,:);
hold on
gap = 0.09;
sub1 = subplot('Position', [0.2 0.7 0.2 0.26 - gap]);
% nexttile();
filtert1=HPCmonthlyTmean(HPCmonthlyTime(:,1)>=2016 & HPCmonthlyTime(:,1)<2046 & HPCmonthlyTime(:,2)==4,:);
filterp1=HPCmonthlyPtot(HPCmonthlyTime(:,1)>=2016 & HPCmonthlyTime(:,1)<2046 & HPCmonthlyTime(:,2)==4,:);
 
filtert2=HPCmonthlyTmean(HPCmonthlyTime(:,1)>=2066 & HPCmonthlyTime(:,1)<2096 & HPCmonthlyTime(:,2)==4,:);
filterp2=HPCmonthlyPtot(HPCmonthlyTime(:,1)>=2066 & HPCmonthlyTime(:,1)<2096 & HPCmonthlyTime(:,2)==4,:);
 
filtertall=[reshape(filtert1,height(filtert1)*width(filtert1),1); reshape(filtert2,height(filtert2)*width(filtert2),1)];
filterpall=[reshape(filterp1,height(filterp1)*width(filterp1),1); reshape(filterp2,height(filterp2)*width(filterp2),1)];

filterp1(filterp1==0)=NaN;
filterp2(filterp2==0)=NaN;
h1=raincloud_plot(reshape(filtert1,height(filtert1)*width(filtert1),1),Precip_scalefactor*reshape(filterp1,height(filterp1)*width(filterp1),1),'color',[1 1 1],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .15, 'dot_dodge_amount', .6, 'box_col_match', 0);       
h2=raincloud_plot(reshape(filtert2,height(filtert2)*width(filtert2),1),Precip_scalefactor*reshape(filterp2,height(filterp2)*width(filterp2),1),'color',[1 0 0],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .55, 'dot_dodge_amount', 1.6, 'box_col_match', 1);
ylocations=[-0.4:0.05:0.25];
% rainloc=0*ones(length(ylocations),1);
% snowloc=2*ones(length(ylocations),1);
xline(0, '-', LineWidth=1, Alpha=1)
xline(2, '--', LineWidth=1)
title("RCP 4.5", "April")
set(gca, 'YLim', [0 0.25]);
set(gca,'Ytick',[0,0.05,0.1,0.15,0.2,0.25])
set(gca, 'XLim', [-25 25]);
% set(gca,'Xtick',[-25, -10, 0, 10, 25])
set(gca,'Xtick',[])
hold on
Aprlab = ylabel('Precipitation Frequency');
Aprlab.Position(2) = 0.125;% change vertical position of ylabel
Aprlab.Position(1) = -32;
set(h1{1}, 'LineWidth', 1)
set(h2{1}, 'LineWidth', 1)
l1=legend('2016-2046','','2066-2096', 'box', 'off');
l1.FontSize=7;
legend('AutoUpdate','off')
% h3=scatter(8.2,0.05,standardP*Precip_scalefactor,'ro','filled','MarkerEdgeColor','k');  % Extra
% h4=text(13.2,0.05,strcat(string(standardP), 'mm'));% Extra
% h4.FontSize=6.5;
%% Apr Total precip inset
% for 1990-2020
clear Preciptot20162046 % clear the variable if it exists
for m=1:12 % cycle through each of the months 
indicestoget=find(HPCmonthlyTime(:,1) >= 2016 & HPCmonthlyTime(:,1) <= 2046 & HPCmonthlyTime(:,2)==m); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=HPCMonthlyPtot2090(indicestoget,:); % extract specific rows
dimens=size(presentday(:,3:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,3:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
Preciptot20162046(:,m)=dataout; % store in new variable
end

clear Preciptot20662096 % clear the variable if it exists
for m=1:12 % cycle through each of the months 
indicestoget=find(HPCmonthlyTime(:,1) >= 2066 & HPCmonthlyTime(:,1) <= 2096 & HPCmonthlyTime(:,2)==m); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=HPCMonthlyPtot2090(indicestoget,:); % extract specific rows
dimens=size(presentday(:,3:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,3:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
Preciptot20662096(:,m)=dataout; % store in new variable
end

clear Months_new
clear Year_new
clear Alldata_new

Year_new=[];
Apr=[];
Months_new=[];
for m=4 % change this for the required month 4=april etc etc
Apr=vertcat(Apr,[Preciptot20162046(:,m);Preciptot20662096(:,m)]);
Year_new=vertcat(Year_new,[repmat([2016],length(Preciptot20162046(:,m)),1); repmat([2066],length(Preciptot20662096(:,m)),1)]);   
Months_new=vertcat(Months_new,repmat([m],length(Preciptot20162046)*2,1));
end

%inset
hold on
insetPosition = [.34 .72 .05 .1];
insetAxis1 = axes('Position', insetPosition); 
box on
boxplot(Apr,{Months_new,Year_new}, "Symbol", '', "ColorGroup", Months_new)
ylabel("mm w.e", "FontSize",10)
set(gca,'xticklabel',{[]})
ylim([0 60])
% set(gca,'yticklabel',{[0 10 20 30 40]})
% set(gca, 'ylim', [0 40])
clear out1
clear out2
clear out3
clear out4
clear out5
out1 = findobj(gca,'tag','Outliers');
out2 = findobj(gca,'tag','Box');
out3 = findobj(gca,'tag','Box');
out4 = findobj(gca,'tag','Median');
out5 = findobj(gca,'tag','Median');
for i = 1:numel(out2)
if rem(i,1)==0
    out2(i).Color = "red";
    out2(i).LineWidth = 1;
end
end
  for  i = 1:numel(out3)
    if rem(i,2)==0    
    out3(i).Color = "black";
    out3(i).LineWidth = 1;
    end
  end
   for  i = 1:numel(out4)
if rem(i,2)==0
    out4(i).Color = "black";
    out4(i).LineWidth = 1;
end
   end

for  i = 1:numel(out5)
    if rem(i,2)==0
    out5(i).Color = "black";
    out5(i).LineWidth = 1;
    end
end
for i = 1:numel(out1)
if rem(i,1)==0
    out1(i).MarkerEdgeColor = "red";

end
end
out = findobj(gcf,'tag','Outliers');

for i = 1:numel(out)
if rem(i,2)==0
    out(i).MarkerEdgeColor = "black";

end
end
hold off
grid
% h = findobj('LineStyle','--')
% set(h, 'LineStyle','-');
%% Raincloud May
filtert1=HPCmonthlyTmean(HPCmonthlyTime(:,1)>=2016 & HPCmonthlyTime(:,1)<2046 & HPCmonthlyTime(:,2)==5,:);
filterp1=HPCmonthlyPtot(HPCmonthlyTime(:,1)>=2016 & HPCmonthlyTime(:,1)<2046 & HPCmonthlyTime(:,2)==5,:);
 
filtert2=HPCmonthlyTmean(HPCmonthlyTime(:,1)>=2066 & HPCmonthlyTime(:,1)<2096 & HPCmonthlyTime(:,2)==5,:);
filterp2=HPCmonthlyPtot(HPCmonthlyTime(:,1)>=2066 & HPCmonthlyTime(:,1)<2096 & HPCmonthlyTime(:,2)==5,:);
 
filtertall=[reshape(filtert1,height(filtert1)*width(filtert1),1); reshape(filtert2,height(filtert2)*width(filtert2),1)];
filterpall=[reshape(filterp1,height(filterp1)*width(filterp1),1); reshape(filterp2,height(filterp2)*width(filterp2),1)];

hold on
% nexttile(3)
% subplot('Position', [[0 0.75 0.1 0.1]])
sub2 = subplot('Position', [0.2 0.5 0.2 0.26 - gap])
h1=raincloud_plot(reshape(filtert1,height(filtert1)*width(filtert1),1),Precip_scalefactor*reshape(filterp1,height(filterp1)*width(filterp1),1),'color',[1 1 1],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .15, 'dot_dodge_amount', .6, 'box_col_match', 0);       
h2=raincloud_plot(reshape(filtert2,height(filtert2)*width(filtert2),1),Precip_scalefactor*reshape(filterp2,height(filterp2)*width(filterp2),1),'color',[1 0 0],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .55, 'dot_dodge_amount', 1.6, 'box_col_match', 1);

%hold on
ylocations=[-0.4:0.05:0.25];
% rainloc=0*ones(length(ylocations),1);
% snowloc=2*ones(length(ylocations),1);
% hold on
% plot(rainloc,ylocations,'k-','LineWidth',2)
% hold on
% plot(snowloc,ylocations,'k--','LineWidth',2)
xline(0, '-', LineWidth=1, Alpha=1)
xline(2, '--', LineWidth=1)
%xlabel('Mean Monthly Temperature (^{o}C)')
set(gca,'Ytick',[0,0.05,0.1,0.15,0.2,0.25,0.3])
% legend("","1990-2020 precipitation", "", "2060-2090 precipitation","FontSize", 10, Location="southeast")
title("May", "FontWeight", "normal")
%set(gca, 'YLim', [-.35 0.25]);
set(gca, 'XLim', [-25 25]);
% set(gca,'Xtick',[-25, -10, 0, 10, 25])
set(gca,'Xtick',[])
set(h1{1}, 'LineWidth', 1)
set(h2{1}, 'LineWidth', 1)
ylim([0 0.25])
% Maylab = ylabel('Precipitation Frequency');
% Maylab.Position(2) = 0.125; % change vertical position of ylabel
% Maylab.Position(1) = -32;
%% total precip inset may
clear Months_new
clear Year_new
clear Alldata_new

Year_new=[];
May=[];
Months_new=[];
for m=5 % change this for the required month 4=april etc etc
May=vertcat(May,[Preciptot20162046(:,m);Preciptot20662096(:,m)]);
Year_new=vertcat(Year_new,[repmat([1990],length(Preciptot20162046(:,m)),1); repmat([2070],length(Preciptot20662096(:,m)),1)]);   
Months_new=vertcat(Months_new,repmat([m],length(Preciptot20162046)*2,1));
end

%inset
hold on
insetPosition = [.34 .55 .05 .1];
insetAxis2 = axes('Position', insetPosition) ;
box on
boxplot(May,{Months_new,Year_new}, "Symbol", '', "ColorGroup", Months_new)

set(gca,'xticklabel',{[]})
set(gca, 'ylim', [0 60])
clear out1
clear out2
clear out3
clear out4
clear out5
out1 = findobj(gca,'tag','Outliers');
out2 = findobj(gca,'tag','Box');
out3 = findobj(gca,'tag','Box');
out4 = findobj(gca,'tag','Median');
out5 = findobj(gca,'tag','Median');
for i = 1:numel(out2)
if rem(i,1)==0
    out2(i).Color = "red";
    out2(i).LineWidth = 1;
end
end
  for  i = 1:numel(out3)
    if rem(i,2)==0    
    out3(i).Color = "black";
    out3(i).LineWidth = 1;
    end
  end
   for  i = 1:numel(out4)
if rem(i,2)==0
    out4(i).Color = "black";
    out4(i).LineWidth = 1;
end
   end

for  i = 1:numel(out5)
    if rem(i,2)==0
    out5(i).Color = "black";
    out5(i).LineWidth = 1;
    end
end
for i = 1:numel(out1)
if rem(i,1)==0
    out1(i).MarkerEdgeColor = "red";

end
end
out = findobj(gcf,'tag','Outliers');

for i = 1:numel(out)
if rem(i,2)==0
    out(i).MarkerEdgeColor = "black";

end
end
hold off
grid
% h = findobj('LineStyle','--')
% set(h, 'LineStyle','-');
%% Raincloud sept
filtert1=HPCmonthlyTmean(HPCmonthlyTime(:,1)>=2016 & HPCmonthlyTime(:,1)<2046 & HPCmonthlyTime(:,2)==9,:);
filterp1=HPCmonthlyPtot(HPCmonthlyTime(:,1)>=2016 & HPCmonthlyTime(:,1)<2046 & HPCmonthlyTime(:,2)==9,:);
 
filtert2=HPCmonthlyTmean(HPCmonthlyTime(:,1)>=2066 & HPCmonthlyTime(:,1)<2096 & HPCmonthlyTime(:,2)==9,:);
filterp2=HPCmonthlyPtot(HPCmonthlyTime(:,1)>=2066 & HPCmonthlyTime(:,1)<2096 & HPCmonthlyTime(:,2)==9,:);
 
filtertall=[reshape(filtert1,height(filtert1)*width(filtert1),1); reshape(filtert2,height(filtert2)*width(filtert2),1)];
filterpall=[reshape(filterp1,height(filterp1)*width(filterp1),1); reshape(filterp2,height(filterp2)*width(filterp2),1)];

% nexttile(5)
% subplot(4,2,5)
sub3 = subplot('Position', [0.2 0.3 0.2 0.26 - gap])
h1=raincloud_plot(reshape(filtert1,height(filtert1)*width(filtert1),1),Precip_scalefactor*reshape(filterp1,height(filterp1)*width(filterp1),1),'color',[1 1 1],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .15, 'dot_dodge_amount', .6, 'box_col_match', 0);       
h2=raincloud_plot(reshape(filtert2,height(filtert2)*width(filtert2),1),Precip_scalefactor*reshape(filterp2,height(filterp2)*width(filterp2),1),'color',[1 0 0],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .55, 'dot_dodge_amount', 1.6,'box_col_match', 1);
hold on
ylocations=[-0.4:0.05:0.25];
% rainloc=0*ones(length(ylocations),1);
% snowloc=2*ones(length(ylocations),1);
% hold on
% plot(rainloc,ylocations,'k-','LineWidth',2)
% hold on
% plot(snowloc,ylocations,'k--','LineWidth',2)
xline(0, '-', LineWidth=1, Alpha=1)
xline(2, '--', LineWidth=1)
% xlabel('Mean Monthly Temperature (^{o}C)')
set(gca,'Ytick',[0,0.05,0.1,0.15,0.2,0.25,0.3])
% legend("","1990-2020 precipitation", "", "2060-2090 precipitation","FontSize", 10, Location="southeast")
title("September", "FontWeight", "normal")
%set(gca, 'YLim', [-.5 0.25]);
set(gca, 'XLim', [-25 25]);
% set(gca,'Xtick',[-25, -10, 0, 10, 25])
set(gca,'Xtick',[])
% Septlab = ylabel('Precipitation Frequency');
% Septlab.Position(2) = 0.125;% change vertical position of ylabel
% Septlab.Position(1) = -32; 
set(h1{1}, 'LineWidth', 1)
set(h2{1}, 'LineWidth', 1)
ylim([0 0.25])
%% Sept total precip inset
clear Months_new
clear Year_new
clear Alldata_new

Year_new=[];
Sept=[];
Months_new=[];
for m=9 % change this for the required month 4=april etc etc
Sept=vertcat(Sept,[Preciptot20162046(:,m);Preciptot20662096(:,m)]);
Year_new=vertcat(Year_new,[repmat([1990],length(Preciptot20162046(:,m)),1); repmat([2070],length(Preciptot20662096(:,m)),1)]);   
Months_new=vertcat(Months_new,repmat([m],length(Preciptot20162046)*2,1));
end

%inset
hold on
insetPosition = [.23 .34 .05 .1];
insetAxis3 = axes('Position', insetPosition) ;
box on
boxplot(Sept,{Months_new,Year_new}, "Symbol", '', "ColorGroup", Months_new)

set(gca,'xticklabel',{[]})
set(gca, 'ylim', [0 130])
clear out1
clear out2
clear out3
clear out4
clear out5
out1 = findobj(gca,'tag','Outliers');
out2 = findobj(gca,'tag','Box');
out3 = findobj(gca,'tag','Box');
out4 = findobj(gca,'tag','Median');
out5 = findobj(gca,'tag','Median');
for i = 1:numel(out2)
if rem(i,1)==0
    out2(i).Color = "red";
    out2(i).LineWidth = 1;
end
end
  for  i = 1:numel(out3)
    if rem(i,2)==0    
    out3(i).Color = "black";
    out3(i).LineWidth = 1;
    end
  end
   for  i = 1:numel(out4)
if rem(i,2)==0
    out4(i).Color = "black";
    out4(i).LineWidth = 1;
end
   end

for  i = 1:numel(out5)
    if rem(i,2)==0
    out5(i).Color = "black";
    out5(i).LineWidth = 1;
    end
end
for i = 1:numel(out1)
if rem(i,1)==0
    out1(i).MarkerEdgeColor = "red";

end
end
out = findobj(gcf,'tag','Outliers');

for i = 1:numel(out)
if rem(i,2)==0
    out(i).MarkerEdgeColor = "black";

end
end
hold off
grid
% h = findobj('LineStyle','--')
% set(h, 'LineStyle','-');
%% Raincloud Oct
filtert1=HPCmonthlyTmean(HPCmonthlyTime(:,1)>=2016 & HPCmonthlyTime(:,1)<2046 & HPCmonthlyTime(:,2)==10,:);
filterp1=HPCmonthlyPtot(HPCmonthlyTime(:,1)>=2016 & HPCmonthlyTime(:,1)<2046 & HPCmonthlyTime(:,2)==10,:);
 
filtert2=HPCmonthlyTmean(HPCmonthlyTime(:,1)>=2066 & HPCmonthlyTime(:,1)<2096 & HPCmonthlyTime(:,2)==10,:);
filterp2=HPCmonthlyPtot(HPCmonthlyTime(:,1)>=2066 & HPCmonthlyTime(:,1)<2096 & HPCmonthlyTime(:,2)==10,:);
 
filtertall=[reshape(filtert1,height(filtert1)*width(filtert1),1); reshape(filtert2,height(filtert2)*width(filtert2),1)];
filterpall=[reshape(filterp1,height(filterp1)*width(filterp1),1); reshape(filterp2,height(filterp2)*width(filterp2),1)];

% nexttile(7)
% subplot(4,2,7)
sub4 = subplot('Position', [0.2 0.1 0.2 0.26 - gap])
h1=raincloud_plot(reshape(filtert1,height(filtert1)*width(filtert1),1),Precip_scalefactor*reshape(filterp1,height(filterp1)*width(filterp1),1),'color',[1 1 1],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .15, 'dot_dodge_amount', .6, 'box_col_match', 0);       
h2=raincloud_plot(reshape(filtert2,height(filtert2)*width(filtert2),1),Precip_scalefactor*reshape(filterp2,height(filterp2)*width(filterp2),1),'color',[1 0 0],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .55, 'dot_dodge_amount', 1.6,'box_col_match', 1);

%hold on
ylocations=[-0.4:0.05:0.25];
xline(0, '-', LineWidth=1, Alpha=1)
xline(2, '--', LineWidth=1)
xlabel('Mean Monthly Temperature (^{o}C)')
set(gca,'Ytick',[0,0.05,0.1,0.15,0.2,0.25,0.3])
title("October", "FontWeight", "normal")
%set(gca, 'YLim', [-.5 0.25]);
set(gca, 'XLim', [-25 25]);
set(gca,'Xtick',[-25, -10, 0, 10, 25])
set(h1{1}, 'LineWidth', 1)
set(h2{1}, 'LineWidth', 1)
ylim([0 0.25])
% Octlab = ylabel('Precipitation Frequency');
% Octlab.Position(2) = 0.125; % change vertical position of ylabel
% Octlab.Position(1) = -32;
rcp4 = gcf;
% exportgraphics(T,'Tiled2x2.jpg','Resolution',300)
%% Oct total precip inset
clear Months_new
clear Year_new
clear Alldata_new

Year_new=[];
Oct=[];
Months_new=[];
for m=10 % change this for the required month 4=april etc etc
Oct=vertcat(Oct,[Preciptot20162046(:,m);Preciptot20662096(:,m)]);
Year_new=vertcat(Year_new,[repmat([1990],length(Preciptot20162046(:,m)),1); repmat([2070],length(Preciptot20662096(:,m)),1)]);   
Months_new=vertcat(Months_new,repmat([m],length(Preciptot20162046)*2,1));
end

%inset
hold on
insetPosition = [.34 .14 .05 .1];
insetAxis4 = axes('Position', insetPosition) ;
box on
boxplot(Oct,{Months_new,Year_new}, "Symbol", '', "ColorGroup", Months_new)

set(gca,'xticklabel',{[]})
% set(gca, 'ylim', [0 60])
clear out1
clear out2
clear out3
clear out4
clear out5
out1 = findobj(gca,'tag','Outliers');
out2 = findobj(gca,'tag','Box');
out3 = findobj(gca,'tag','Box');
out4 = findobj(gca,'tag','Median');
out5 = findobj(gca,'tag','Median');
for i = 1:numel(out2)
if rem(i,1)==0
    out2(i).Color = "red";
    out2(i).LineWidth = 1;
end
end
  for  i = 1:numel(out3)
    if rem(i,2)==0    
    out3(i).Color = "black";
    out3(i).LineWidth = 1;
    end
  end
   for  i = 1:numel(out4)
if rem(i,2)==0
    out4(i).Color = "black";
    out4(i).LineWidth = 1;
end
   end

for  i = 1:numel(out5)
    if rem(i,2)==0
    out5(i).Color = "black";
    out5(i).LineWidth = 1;
    end
end
for i = 1:numel(out1)
if rem(i,1)==0
    out1(i).MarkerEdgeColor = "red";

end
end
out = findobj(gcf,'tag','Outliers');

for i = 1:numel(out)
if rem(i,2)==0
    out(i).MarkerEdgeColor = "black";

end
end
hold off
grid
% h = findobj('LineStyle','--')
% set(h, 'LineStyle','-');
%% ISOLATE RCP8.5
clearvars -except rcp4 insetAxis1 insetAxis2 insetAxis3 insetAxis4 sub1 sub2 sub3 sub4
FilesList=dir('mbcn.CA-TVC.NAM-*rcp85*.csv'); % makes a list of all ensemble member files

for j=1:length(FilesList)  % cycles through each  file in the filelist
Output=readtable(FilesList(j).name); % read the csv file into MATLAB
datestamp=datenum(num2str(table2array([Output(:,1),Output(:,2),Output(:,3)])));   % Get the time for the x axis
[UniqueCombos UniqueRowStart RowsofEachUniqueCombo]=unique(Output(:,1:2),'rows');
for i=1:max(RowsofEachUniqueCombo)
rowsneeded=find(RowsofEachUniqueCombo==i);
HPCmonthlyprecip(i,j)=mean(Output.pr(rowsneeded));
HPCmonthlyTime(i,1)=mean(Output.year(rowsneeded));
HPCmonthlyTime(i,2)=mean(Output.month(rowsneeded));
HPCmonthlyTmin(i,j)=mean(Output.tn(rowsneeded));
HPCmonthlyTmax(i,j)=mean(Output.tx(rowsneeded));
HPCmonthlyTmean(i,j)=0.5*(HPCmonthlyTmin(i,j)+HPCmonthlyTmax(i,j));
HPCmonthlyPtot(i,j)=sum(Output.pr(rowsneeded)*60*60*24);
end
end
HPCmonthlyprecip=HPCmonthlyprecip*60*60*24;
HPCMonthlyP2090=[HPCmonthlyTime HPCmonthlyprecip];
HPCMonthlyT2090=[HPCmonthlyTime HPCmonthlyTmean];
HPCMonthlyPtot2090=[HPCmonthlyTime HPCmonthlyPtot];
%% Raincloud April
hold on
Precip_scalefactor=0.5;
standardP=50;
clear h1
clear h2
% nexttile(2)
% subplot(4,2,2)
gap = 0.09;
sub5 = subplot('Position', [0.44 0.7 0.2 0.26 - gap])
filtert1=HPCmonthlyTmean(HPCmonthlyTime(:,1)>=2016 & HPCmonthlyTime(:,1)<2046 & HPCmonthlyTime(:,2)==4,:);
filterp1=HPCmonthlyPtot(HPCmonthlyTime(:,1)>=2016 & HPCmonthlyTime(:,1)<2046 & HPCmonthlyTime(:,2)==4,:);
 
filtert2=HPCmonthlyTmean(HPCmonthlyTime(:,1)>=2066 & HPCmonthlyTime(:,1)<2096 & HPCmonthlyTime(:,2)==4,:);
filterp2=HPCmonthlyPtot(HPCmonthlyTime(:,1)>=2066 & HPCmonthlyTime(:,1)<2096 & HPCmonthlyTime(:,2)==4,:);
 
filtertall=[reshape(filtert1,height(filtert1)*width(filtert1),1); reshape(filtert2,height(filtert2)*width(filtert2),1)];
filterpall=[reshape(filterp1,height(filterp1)*width(filterp1),1); reshape(filterp2,height(filterp2)*width(filterp2),1)];

filterp1(filterp1==0)=NaN;
filterp2(filterp2==0)=NaN;
h1=raincloud_plot(reshape(filtert1,height(filtert1)*width(filtert1),1),Precip_scalefactor*reshape(filterp1,height(filterp1)*width(filterp1),1),'color',[1 1 1],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .15, 'dot_dodge_amount', .6, 'box_col_match', 0);       
h2=raincloud_plot(reshape(filtert2,height(filtert2)*width(filtert2),1),Precip_scalefactor*reshape(filterp2,height(filterp2)*width(filterp2),1),'color',[1 0 0],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .55, 'dot_dodge_amount', 1.6, 'box_col_match', 1);
ylocations=[-0.4:0.05:0.25];
% rainloc=0*ones(length(ylocations),1);
% snowloc=2*ones(length(ylocations),1);
xline(0, '-', LineWidth=1, Alpha=1)
xline(2, '--', LineWidth=1)
title("RCP 8.5", "April")
%set(gca, 'YLim', [-.35 0.25]);
set(gca,'Ytick',[0,0.05,0.1,0.15,0.2,0.25])
set(gca, 'XLim', [-25 25]);
% set(gca,'Xtick',[-25, -10, 0, 10, 25])
set(gca,'Xtick',[])
hold on
% Aprlab = ylabel('Frequency');
% Aprlab.Position(2) = 0.125;% change vertical position of ylabel
% Aprlab.Position(1) = -29;
set(h1{1}, 'LineWidth', 1)
set(h2{1}, 'LineWidth', 1)
% l1=legend('2016-2046','','2066-2096', 'box', 'off');
% legend('AutoUpdate','off')
ylim([0 0.25])
% h3=scatter(8.2,0.05,standardP*Precip_scalefactor,'ro','filled','MarkerEdgeColor','k');  % Extra
% h4=text(13.2,0.05,strcat(string(standardP), 'mm'));% Extra
% h4.FontSize=6.5;
%% Apr total precip inset
clear Apr
clear May
clear Sept
clear Oct
clear Months_new
clear Year_new
clear Alldata_new
% for 1990-2020
clear Preciptot20162046 % clear the variable if it exists
for m=1:12 % cycle through each of the months 
indicestoget=find(HPCmonthlyTime(:,1) >= 2016 & HPCmonthlyTime(:,1) <= 2046 & HPCmonthlyTime(:,2)==m); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=HPCMonthlyPtot2090(indicestoget,:); % extract specific rows
dimens=size(presentday(:,3:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,3:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
Preciptot20162046(:,m)=dataout; % store in new variable
end

clear Preciptot20662096 % clear the variable if it exists
for m=1:12 % cycle through each of the months 
indicestoget=find(HPCmonthlyTime(:,1) >= 2066 & HPCmonthlyTime(:,1) <= 2096 & HPCmonthlyTime(:,2)==m); % filter out monthly data (m) where the year is greater than or equal to 1990 and less than or equal to 2020. relevant rows are stored in indicestoget
presentday=HPCMonthlyPtot2090(indicestoget,:); % extract specific rows
dimens=size(presentday(:,3:end)); % find the dimensions (rows, columns) of the variable presentday
dataout=reshape(presentday(:,3:end),dimens(1,1)*dimens(1,2),1); % reshape so that the temperature data is in one long column reflecting all daily values for this time period for each ensemble member
Preciptot20662096(:,m)=dataout; % store in new variable
end

Year_new=[];
Apr=[];
Months_new=[];
for m=4 % change this for the required month 4=april etc etc
Apr=vertcat(Apr,[Preciptot20162046(:,m);Preciptot20662096(:,m)]);
Year_new=vertcat(Year_new,[repmat([2016],length(Preciptot20162046(:,m)),1); repmat([2066],length(Preciptot20662096(:,m)),1)]);   
Months_new=vertcat(Months_new,repmat([m],length(Preciptot20162046)*2,1));
end

%inset
hold on
insetPosition = [.58 .74 .05 .1];
insetAxis5 = axes('Position', insetPosition) ;
box on
boxplot(Apr,{Months_new,Year_new}, "Symbol", '', "ColorGroup", Months_new)

set(gca,'xticklabel',{[]})
% set(gca,'yticklabel',{[0 10 20 30 40]})
set(gca, 'ylim', [0 70])
clear out1
clear out2
clear out3
clear out4
clear out5
out1 = findobj(gca,'tag','Outliers');
out2 = findobj(gca,'tag','Box');
out3 = findobj(gca,'tag','Box');
out4 = findobj(gca,'tag','Median');
out5 = findobj(gca,'tag','Median');
for i = 1:numel(out2)
if rem(i,1)==0
    out2(i).Color = "red";
    out2(i).LineWidth = 1;
end
end
  for  i = 1:numel(out3)
    if rem(i,2)==0    
    out3(i).Color = "black";
    out3(i).LineWidth = 1;
    end
  end
   for  i = 1:numel(out4)
if rem(i,2)==0
    out4(i).Color = "black";
    out4(i).LineWidth = 1;
end
   end

for  i = 1:numel(out5)
    if rem(i,2)==0
    out5(i).Color = "black";
    out5(i).LineWidth = 1;
    end
end
for i = 1:numel(out1)
if rem(i,1)==0
    out1(i).MarkerEdgeColor = "red";

end
end
out = findobj(gcf,'tag','Outliers');

for i = 1:numel(out)
if rem(i,2)==0
    out(i).MarkerEdgeColor = "black";

end
end
hold off
grid
%% Raincloud May
filtert1=HPCmonthlyTmean(HPCmonthlyTime(:,1)>=2016 & HPCmonthlyTime(:,1)<2046 & HPCmonthlyTime(:,2)==5,:);
filterp1=HPCmonthlyPtot(HPCmonthlyTime(:,1)>=2016 & HPCmonthlyTime(:,1)<2046 & HPCmonthlyTime(:,2)==5,:);
 
filtert2=HPCmonthlyTmean(HPCmonthlyTime(:,1)>=2066 & HPCmonthlyTime(:,1)<2096 & HPCmonthlyTime(:,2)==5,:);
filterp2=HPCmonthlyPtot(HPCmonthlyTime(:,1)>=2066 & HPCmonthlyTime(:,1)<2096 & HPCmonthlyTime(:,2)==5,:);
 
filtertall=[reshape(filtert1,height(filtert1)*width(filtert1),1); reshape(filtert2,height(filtert2)*width(filtert2),1)];
filterpall=[reshape(filterp1,height(filterp1)*width(filterp1),1); reshape(filterp2,height(filterp2)*width(filterp2),1)];

% nexttile(4)
% subplot(4,2,4)
Precip_scalefactor=0.5;
gap = 0.09;
% sub6 = subplot('Position', [0.44 0.5 0.2 0.26 - gap])
figure()
h1=raincloud_plot(reshape(filtert1,height(filtert1)*width(filtert1),1),Precip_scalefactor*reshape(filterp1,height(filterp1)*width(filterp1),1),'color',[1 1 1],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .15, 'dot_dodge_amount', .6, 'box_col_match', 0);       
h2=raincloud_plot(reshape(filtert2,height(filtert2)*width(filtert2),1),Precip_scalefactor*reshape(filterp2,height(filterp2)*width(filterp2),1),'color',[1 0 0],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .55, 'dot_dodge_amount', 1.6, 'box_col_match', 1);

%hold on
ylocations=[-0.4:0.05:0.25];
xline(0, '-', LineWidth=1, Alpha=1)
xline(2, '--', LineWidth=1)
%xlabel('Mean Monthly Temperature (^{o}C)')
set(gca,'Ytick',[0,0.05,0.1,0.15,0.2,0.25,0.3])
% legend("","1990-2020 precipitation", "", "2060-2090 precipitation","FontSize", 10, Location="southeast")
title("May", "FontWeight", "normal")
%set(gca, 'YLim', [-.35 0.25]);
set(gca, 'XLim', [-25 25]);
% set(gca,'Xtick',[-25, -10, 0, 10, 25])
set(gca,'Xtick',[])
set(h1{1}, 'LineWidth', 1)
set(h2{1}, 'LineWidth', 1)
ylim([0 0.25])
% Maylab = ylabel('Frequency');
% Maylab.Position(2) = 0.125; % change vertical position of ylabel
% Maylab.Position(1) = -29;
%% total precip inset may
clear Months_new
clear Year_new
clear Alldata_new

Year_new=[];
May=[];
Months_new=[];
for m=5 % change this for the required month 4=april etc etc
May=vertcat(May,[Preciptot20162046(:,m);Preciptot20662096(:,m)]);
Year_new=vertcat(Year_new,[repmat([1990],length(Preciptot20162046(:,m)),1); repmat([2070],length(Preciptot20662096(:,m)),1)]);   
Months_new=vertcat(Months_new,repmat([m],length(Preciptot20162046)*2,1));
end

%inset
hold on
insetPosition = [.46 .54 .05 .1];
insetAxis6 = axes('Position', insetPosition) ;
box on
boxplot(May,{Months_new,Year_new}, "Symbol", '', "ColorGroup", Months_new)

set(gca,'xticklabel',{[]})
set(gca, 'ylim', [0 60])
clear out1
clear out2
clear out3
clear out4
clear out5
out1 = findobj(gca,'tag','Outliers');
out2 = findobj(gca,'tag','Box');
out3 = findobj(gca,'tag','Box');
out4 = findobj(gca,'tag','Median');
out5 = findobj(gca,'tag','Median');
for i = 1:numel(out2)
if rem(i,1)==0
    out2(i).Color = "red";
    out2(i).LineWidth = 1;
end
end
  for  i = 1:numel(out3)
    if rem(i,2)==0    
    out3(i).Color = "black";
    out3(i).LineWidth = 1;
    end
  end
   for  i = 1:numel(out4)
if rem(i,2)==0
    out4(i).Color = "black";
    out4(i).LineWidth = 1;
end
   end

for  i = 1:numel(out5)
    if rem(i,2)==0
    out5(i).Color = "black";
    out5(i).LineWidth = 1;
    end
end
for i = 1:numel(out1)
if rem(i,1)==0
    out1(i).MarkerEdgeColor = "red";

end
end
out = findobj(gcf,'tag','Outliers');

for i = 1:numel(out)
if rem(i,2)==0
    out(i).MarkerEdgeColor = "black";

end
end
hold off
grid
%% Raincloud sept
filtert1=HPCmonthlyTmean(HPCmonthlyTime(:,1)>=2016 & HPCmonthlyTime(:,1)<2046 & HPCmonthlyTime(:,2)==9,:);
filterp1=HPCmonthlyPtot(HPCmonthlyTime(:,1)>=2016 & HPCmonthlyTime(:,1)<2046 & HPCmonthlyTime(:,2)==9,:);
 
filtert2=HPCmonthlyTmean(HPCmonthlyTime(:,1)>=2066 & HPCmonthlyTime(:,1)<2096 & HPCmonthlyTime(:,2)==9,:);
filterp2=HPCmonthlyPtot(HPCmonthlyTime(:,1)>=2066 & HPCmonthlyTime(:,1)<2096 & HPCmonthlyTime(:,2)==9,:);
 
filtertall=[reshape(filtert1,height(filtert1)*width(filtert1),1); reshape(filtert2,height(filtert2)*width(filtert2),1)];
filterpall=[reshape(filterp1,height(filterp1)*width(filterp1),1); reshape(filterp2,height(filterp2)*width(filterp2),1)];

% nexttile(6)
% subplot(4,2,6)
sub7 = subplot('Position', [0.44 0.3 0.2 0.26 - gap])
h1=raincloud_plot(reshape(filtert1,height(filtert1)*width(filtert1),1),Precip_scalefactor*reshape(filterp1,height(filterp1)*width(filterp1),1),'color',[1 1 1],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .15, 'dot_dodge_amount', .6, 'box_col_match', 0);       
h2=raincloud_plot(reshape(filtert2,height(filtert2)*width(filtert2),1),Precip_scalefactor*reshape(filterp2,height(filterp2)*width(filterp2),1),'color',[1 0 0],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .55, 'dot_dodge_amount', 1.6,'box_col_match', 1);
hold on
ylocations=[-0.4:0.05:0.25];
% rainloc=0*ones(length(ylocations),1);
% snowloc=2*ones(length(ylocations),1);
% hold on
% plot(rainloc,ylocations,'k-','LineWidth',2)
% hold on
% plot(snowloc,ylocations,'k--','LineWidth',2)
xline(0, '-', LineWidth=1, Alpha=1)
xline(2, '--', LineWidth=1)
% xlabel('Mean Monthly Temperature (^{o}C)')
set(gca,'Ytick',[0,0.05,0.1,0.15,0.2,0.25,0.3])
% legend("","1990-2020 precipitation", "", "2060-2090 precipitation","FontSize", 10, Location="southeast")
title("September", "FontWeight", "normal")
%set(gca, 'YLim', [-.5 0.25]);
set(gca, 'XLim', [-25 25]);
% set(gca,'Xtick',[-25, -10, 0, 10, 25])
set(gca,'Xtick',[])
% Septlab = ylabel('Frequency');
% Septlab.Position(2) = 0.125;% change vertical position of ylabel
% Septlab.Position(1) = -29; 
set(h1{1}, 'LineWidth', 1)
set(h2{1}, 'LineWidth', 1)
ylim([0 0.25])
%% Sept total precip inset
clear Months_new
clear Year_new
clear Alldata_new

Year_new=[];
Sept=[];
Months_new=[];
for m=9 % change this for the required month 4=april etc etc
Sept=vertcat(Sept,[Preciptot20162046(:,m);Preciptot20662096(:,m)]);
Year_new=vertcat(Year_new,[repmat([1990],length(Preciptot20162046(:,m)),1); repmat([2070],length(Preciptot20662096(:,m)),1)]);   
Months_new=vertcat(Months_new,repmat([m],length(Preciptot20162046)*2,1));
end

%inset
hold on
insetPosition = [.47 .34 .05 .1];
insetAxis7 = axes('Position', insetPosition);
box on
boxplot(Sept,{Months_new,Year_new}, "Symbol", '', "ColorGroup", Months_new)

set(gca,'xticklabel',{[]})
set(gca, 'ylim', [0 130])
clear out1
clear out2
clear out3
clear out4
clear out5
out1 = findobj(gca,'tag','Outliers');
out2 = findobj(gca,'tag','Box');
out3 = findobj(gca,'tag','Box');
out4 = findobj(gca,'tag','Median');
out5 = findobj(gca,'tag','Median');
for i = 1:numel(out2)
if rem(i,1)==0
    out2(i).Color = "red";
    out2(i).LineWidth = 1;
end
end
  for  i = 1:numel(out3)
    if rem(i,2)==0    
    out3(i).Color = "black";
    out3(i).LineWidth = 1;
    end
  end
   for  i = 1:numel(out4)
if rem(i,2)==0
    out4(i).Color = "black";
    out4(i).LineWidth = 1;
end
   end

for  i = 1:numel(out5)
    if rem(i,2)==0
    out5(i).Color = "black";
    out5(i).LineWidth = 1;
    end
end
for i = 1:numel(out1)
if rem(i,1)==0
    out1(i).MarkerEdgeColor = "red";

end
end
out = findobj(gcf,'tag','Outliers');

for i = 1:numel(out)
if rem(i,2)==0
    out(i).MarkerEdgeColor = "black";

end
end
hold off
grid
%% Raincloud Oct
filtert1=HPCmonthlyTmean(HPCmonthlyTime(:,1)>=2016 & HPCmonthlyTime(:,1)<2046 & HPCmonthlyTime(:,2)==10,:);
filterp1=HPCmonthlyPtot(HPCmonthlyTime(:,1)>=2016 & HPCmonthlyTime(:,1)<2046 & HPCmonthlyTime(:,2)==10,:);
 
filtert2=HPCmonthlyTmean(HPCmonthlyTime(:,1)>=2066 & HPCmonthlyTime(:,1)<2096 & HPCmonthlyTime(:,2)==10,:);
filterp2=HPCmonthlyPtot(HPCmonthlyTime(:,1)>=2066 & HPCmonthlyTime(:,1)<2096 & HPCmonthlyTime(:,2)==10,:);
 
filtertall=[reshape(filtert1,height(filtert1)*width(filtert1),1); reshape(filtert2,height(filtert2)*width(filtert2),1)];
filterpall=[reshape(filterp1,height(filterp1)*width(filterp1),1); reshape(filterp2,height(filterp2)*width(filterp2),1)];

% nexttile(8)
% subplot(4,2,8)
Precip_scalefactor=0.5;
gap = 0.09;
figure()
% sub8 = subplot('Position', [0.44 0.1 0.2 0.26 - gap])
h1=raincloud_plot(reshape(filtert1,height(filtert1)*width(filtert1),1),Precip_scalefactor*reshape(filterp1,height(filterp1)*width(filterp1),1),'color',[1 1 1],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .15, 'dot_dodge_amount', .6, 'box_col_match', 0);       
h2=raincloud_plot(reshape(filtert2,height(filtert2)*width(filtert2),1),Precip_scalefactor*reshape(filterp2,height(filterp2)*width(filterp2),1),'color',[1 0 0],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .55, 'dot_dodge_amount', 1.6,'box_col_match', 1);

%hold on
ylocations=[-0.4:0.05:0.25];
xline(0, '-', LineWidth=1, Alpha=1)
xline(2, '--', LineWidth=1)
xlabel('Mean Monthly Temperature (^{o}C)')
set(gca,'Ytick',[0,0.05,0.1,0.15,0.2,0.25,0.3])
title("October", "FontWeight", "normal")
%set(gca, 'YLim', [-.5 0.25]);
set(gca, 'XLim', [-25 25]);
set(gca,'Xtick',[-25, -10, 0, 10, 25])
set(h1{1}, 'LineWidth', 1)
set(h2{1}, 'LineWidth', 1)
ylim([0 0.25])
% Octlab = ylabel('Frequency');
% Octlab.Position(2) = 0.125; % change vertical position of ylabel
% Octlab.Position(1) = -29;
% exportgraphics(T,'Tiled2x2.jpg','Resolution',300)
%% Oct total precip inset
clear Months_new
clear Year_new
clear Alldata_new

Year_new=[];
Oct=[];
Months_new=[];
for m=10 % change this for the required month 4=april etc etc
Oct=vertcat(Oct,[Preciptot20162046(:,m);Preciptot20662096(:,m)]);
Year_new=vertcat(Year_new,[repmat([1990],length(Preciptot20162046(:,m)),1); repmat([2070],length(Preciptot20662096(:,m)),1)]);   
Months_new=vertcat(Months_new,repmat([m],length(Preciptot20162046)*2,1));
end

%inset
hold on
insetPosition = [.57 .14 .05 .1];
insetAxis8 = axes('Position', insetPosition) ;
box on
boxplot(Oct,{Months_new,Year_new}, "Symbol", '', "ColorGroup", Months_new)
set(gca,'xticklabel',{[]})
set(gca, 'ylim', [0 130])
clear out1
clear out2
clear out3
clear out4
clear out5
out1 = findobj(gca,'tag','Outliers');
out2 = findobj(gca,'tag','Box');
out3 = findobj(gca,'tag','Box');
out4 = findobj(gca,'tag','Median');
out5 = findobj(gca,'tag','Median');
for i = 1:numel(out2)
if rem(i,1)==0
    out2(i).Color = "red";
    out2(i).LineWidth = 1;
end
end
  for  i = 1:numel(out3)
    if rem(i,2)==0    
    out3(i).Color = "black";
    out3(i).LineWidth = 1;
    end
  end
   for  i = 1:numel(out4)
if rem(i,2)==0
    out4(i).Color = "black";
    out4(i).LineWidth = 1;
end
   end

for  i = 1:numel(out5)
    if rem(i,2)==0
    out5(i).Color = "black";
    out5(i).LineWidth = 1;
    end
end
for i = 1:numel(out1)
if rem(i,1)==0
    out1(i).MarkerEdgeColor = "red";

end
end
out = findobj(gcf,'tag','Outliers');

for i = 1:numel(out)
if rem(i,2)==0
    out(i).MarkerEdgeColor = "black";

end
end
hold off
grid
subs = [sub8 sub7 sub6 sub5 sub4 sub3 sub2 sub1]
insets = [insetAxis1 insetAxis2 insetAxis3 insetAxis4 insetAxis5 insetAxis6 insetAxis7 insetAxis8]
set(insets, 'ylim', [0 120])
% set(insets, 'FontSize', 11)
all_text_objects = findall(gcf, 'Type', 'text');
set(all_text_objects, 'FontSize', 13);
set(subs, 'FontSize', 12)
%% Save figure
% cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/Figures/'Alex and bo forcing data'/TVC/
% exportgraphics(gcf, "frequency_tiled.jpg", "Resolution",300)