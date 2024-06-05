%% Load data for RCP 4.5
load("T_P_45.mat");
%% Frequency April
Precip_scalefactor = 0.5; % Scale factor for precipitation
standardP = 50; % Standard precipitation value
clear h1 h2

% Create figure and adjust its position
Fig1 = figure(1);
p = get(0, "MonitorPositions");
Fig1.Position = p(1,:);
hold on

gap = 0.09;
sub1 = subplot('Position', [0.2 0.7 0.2 0.26 - gap]);

% Filter data for April in the periods 2016-2045 and 2066-2095
filtert1 = HPCmonthlyTmean(HPCmonthlyTime(:,1) >= 2016 & HPCmonthlyTime(:,1) < 2046 & HPCmonthlyTime(:,2) == 4,:);
filterp1 = HPCmonthlyPtot(HPCmonthlyTime(:,1) >= 2016 & HPCmonthlyTime(:,1) < 2046 & HPCmonthlyTime(:,2) == 4,:);

filtert2 = HPCmonthlyTmean(HPCmonthlyTime(:,1) >= 2066 & HPCmonthlyTime(:,1) < 2096 & HPCmonthlyTime(:,2) == 4,:);
filterp2 = HPCmonthlyPtot(HPCmonthlyTime(:,1) >= 2066 & HPCmonthlyTime(:,1) < 2096 & HPCmonthlyTime(:,2) == 4,:);

% Combine the temperature and precipitation data from both periods
filtertall = [reshape(filtert1, numel(filtert1), 1); reshape(filtert2, numel(filtert2), 1)];
filterpall = [reshape(filterp1, numel(filterp1), 1); reshape(filterp2, numel(filterp2), 1)];

% Replace zero precipitation values with NaN
filterp1(filterp1 == 0) = NaN;
filterp2(filterp2 == 0) = NaN;

% Reshape the filtered data
Treshape1 = reshape(filtert1, numel(filtert1), 1);
Treshape2 = reshape(filtert2, numel(filtert2), 1);
Preshape1 = Precip_scalefactor * reshape(filterp1, numel(filterp1), 1);
Preshape2 = Precip_scalefactor * reshape(filterp2, numel(filterp2), 1);

% Create raincloud plots for the two periods
h1 = raincloud_plot(Treshape1, Preshape1, 'color', [1 1 1], 'alpha', 0.5, 'box_dodge', 1, 'box_dodge_amount', 0.15, 'dot_dodge_amount', 0.6, 'box_col_match', 0);
h2 = raincloud_plot(Treshape2, Preshape2, 'color', [1 0 0], 'alpha', 0.5, 'box_dodge', 1, 'box_dodge_amount', 0.55, 'dot_dodge_amount', 1.6, 'box_col_match', 1);

% Configure the plot
ylocations = [-0.4:0.05:0.25];
xline(0, '-', 'LineWidth', 1, 'Alpha', 1)
xline(2, '--', 'LineWidth', 1)
title("RCP 4.5", "April")
set(gca, 'YLim', [0 0.25]);
set(gca, 'Ytick', [0, 0.05, 0.1, 0.15, 0.2, 0.25])
set(gca, 'XLim', [-25 25]);
set(gca, 'Xtick', [])
hold on

% Adjust the position of the y-axis label
Aprlab = ylabel('Precipitation Frequency');
Aprlab.Position(2) = -0.3; % Change vertical position of ylabel
Aprlab.Position(1) = -32;

% Set line width for the raincloud plots
set(h1{1}, 'LineWidth', 1)
set(h2{1}, 'LineWidth', 1)

%% Apr Total precip inset
% This section creates boxplots of total precipitation for April across two periods (2016-2046 and 2066-2096)

clear Preciptot20162046 % Clear the variable if it exists

% Loop through each month to gather precipitation data for 2016-2046
for m = 1:12
    % Filter for data within the specified date range and for the current month
    indicestoget = find(HPCmonthlyTime(:,1) >= 2016 & HPCmonthlyTime(:,1) <= 2046 & HPCmonthlyTime(:,2) == m);
    % Extract the relevant rows
    presentday = HPCMonthlyPtot2090(indicestoget,:);
    % Reshape the data into a single column
    dimens = size(presentday(:,3:end));
    dataout = reshape(presentday(:,3:end), dimens(1,1) * dimens(1,2), 1);
    % Store the reshaped data
    Preciptot20162046(:,m) = dataout;
end

clear Preciptot20662096 % Clear the variable if it exists

% Loop through each month to gather precipitation data for 2066-2096
for m = 1:12
    % Filter for data within the specified date range and for the current month
    indicestoget = find(HPCmonthlyTime(:,1) >= 2066 & HPCmonthlyTime(:,1) <= 2096 & HPCmonthlyTime(:,2) == m);
    % Extract the relevant rows
    presentday = HPCMonthlyPtot2090(indicestoget,:);
    % Reshape the data into a single column
    dimens = size(presentday(:,3:end));
    dataout = reshape(presentday(:,3:end), dimens(1,1) * dimens(1,2), 1);
    % Store the reshaped data
    Preciptot20662096(:,m) = dataout;
end

% Initialize variables for combining data across the two periods
clear Months_new Year_new Alldata_new
Year_new = [];
Apr = [];
Months_new = [];

% Combine data for April (month 4) from both periods into a single dataset
for m = 4 % Change this for the required month
    Apr = vertcat(Apr, [Preciptot20162046(:,m); Preciptot20662096(:,m)]);
    Year_new = vertcat(Year_new, [repmat([2016], length(Preciptot20162046(:,m)), 1); repmat([2066], length(Preciptot20662096(:,m)), 1)]);
    Months_new = vertcat(Months_new, repmat([m], length(Preciptot20162046) * 2, 1));
end

% Create inset boxplot for April precipitation data
hold on
insetPosition = [.34 .72 .05 .1];
insetAxis1 = axes('Position', insetPosition);
box on
boxplot(Apr, {Months_new, Year_new}, "Symbol", '', "ColorGroup", Months_new)
ylabel("mm w.e", "FontSize", 10)
set(gca, 'xticklabel', [])
ylim([0 60])

% Customize boxplot colors and line widths
clear out1 out2 out3 out4 out5
out1 = findobj(gca, 'tag', 'Outliers');
out2 = findobj(gca, 'tag', 'Box');
out3 = findobj(gca, 'tag', 'Box');
out4 = findobj(gca, 'tag', 'Median');
out5 = findobj(gca, 'tag', 'Median');

% Adjust colors and line widths for the boxes and medians
for i = 1:numel(out2)
    if rem(i, 1) == 0
        out2(i).Color = "red";
        out2(i).LineWidth = 1;
    end
end

for i = 1:numel(out3)
    if rem(i, 2) == 0
        out3(i).Color = "black";
        out3(i).LineWidth = 1;
    end
end

for i = 1:numel(out4)
    if rem(i, 2) == 0
        out4(i).Color = "black";
        out4(i).LineWidth = 1;
    end
end

for i = 1:numel(out5)
    if rem(i, 2) == 0
        out5(i).Color = "black";
        out5(i).LineWidth = 1;
    end
end

% Adjust colors for outliers
for i = 1:numel(out1)
    if rem(i, 1) == 0
        out1(i).MarkerEdgeColor = "red";
    end
end

out = findobj(gcf, 'tag', 'Outliers');

for i = 1:numel(out)
    if rem(i, 2) == 0
        out(i).MarkerEdgeColor = "black";
    end
end

hold off
grid

% Uncomment and adjust the following lines if needed:
% h = findobj('LineStyle', '--')
% set(h, 'LineStyle', '-');

%% Lines 1:219 are then repeated for May, Sep, and Oct for RCP 4.5 and then again for RCP 8.5 as follows.
%% Raincloud May
filtert1=HPCmonthlyTmean(HPCmonthlyTime(:,1)>=2016 & HPCmonthlyTime(:,1)<2046 & HPCmonthlyTime(:,2)==5,:);
filterp1=HPCmonthlyPtot(HPCmonthlyTime(:,1)>=2016 & HPCmonthlyTime(:,1)<2046 & HPCmonthlyTime(:,2)==5,:);
 
filtert2=HPCmonthlyTmean(HPCmonthlyTime(:,1)>=2066 & HPCmonthlyTime(:,1)<2096 & HPCmonthlyTime(:,2)==5,:);
filterp2=HPCmonthlyPtot(HPCmonthlyTime(:,1)>=2066 & HPCmonthlyTime(:,1)<2096 & HPCmonthlyTime(:,2)==5,:);
 
filtertall=[reshape(filtert1,height(filtert1)*width(filtert1),1); reshape(filtert2,height(filtert2)*width(filtert2),1)];
filterpall=[reshape(filterp1,height(filterp1)*width(filterp1),1); reshape(filterp2,height(filterp2)*width(filterp2),1)];

hold on

sub2 = subplot('Position', [0.2 0.5 0.2 0.26 - gap])
h1=raincloud_plot(reshape(filtert1,height(filtert1)*width(filtert1),1),Precip_scalefactor*reshape(filterp1,height(filterp1)*width(filterp1),1),'color',[1 1 1],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .15, 'dot_dodge_amount', .6, 'box_col_match', 0);       
h2=raincloud_plot(reshape(filtert2,height(filtert2)*width(filtert2),1),Precip_scalefactor*reshape(filterp2,height(filterp2)*width(filterp2),1),'color',[1 0 0],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .55, 'dot_dodge_amount', 1.6, 'box_col_match', 1);

ylocations=[-0.4:0.05:0.25];

xline(0, '-', LineWidth=1, Alpha=1)
xline(2, '--', LineWidth=1)
set(gca,'Ytick',[0,0.05,0.1,0.15,0.2,0.25,0.3])
title("May", "FontWeight", "normal")
set(gca, 'XLim', [-25 25]);
set(gca,'Xtick',[])
set(h1{1}, 'LineWidth', 1)
set(h2{1}, 'LineWidth', 1)
ylim([0 0.25])

%% total precip inset may
clear Months_new
clear Year_new
clear Alldata_new

Year_new=[];
May=[];
Months_new=[];
for m=5 % change this for the required month 4=april etc
May=vertcat(May,[Preciptot20162046(:,m);Preciptot20662096(:,m)]);
Year_new=vertcat(Year_new,[repmat([1990],length(Preciptot20162046(:,m)),1); repmat([2070],length(Preciptot20662096(:,m)),1)]);   
Months_new=vertcat(Months_new,repmat([m],length(Preciptot20162046)*2,1));
end

%inset
hold on
insetPosition = [.34 .54 .05 .1];
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

%% Raincloud sept
filtert1=HPCmonthlyTmean(HPCmonthlyTime(:,1)>=2016 & HPCmonthlyTime(:,1)<2046 & HPCmonthlyTime(:,2)==9,:);
filterp1=HPCmonthlyPtot(HPCmonthlyTime(:,1)>=2016 & HPCmonthlyTime(:,1)<2046 & HPCmonthlyTime(:,2)==9,:);
 
filtert2=HPCmonthlyTmean(HPCmonthlyTime(:,1)>=2066 & HPCmonthlyTime(:,1)<2096 & HPCmonthlyTime(:,2)==9,:);
filterp2=HPCmonthlyPtot(HPCmonthlyTime(:,1)>=2066 & HPCmonthlyTime(:,1)<2096 & HPCmonthlyTime(:,2)==9,:);
 
filtertall=[reshape(filtert1,height(filtert1)*width(filtert1),1); reshape(filtert2,height(filtert2)*width(filtert2),1)];
filterpall=[reshape(filterp1,height(filterp1)*width(filterp1),1); reshape(filterp2,height(filterp2)*width(filterp2),1)];


sub3 = subplot('Position', [0.2 0.3 0.2 0.26 - gap])
h1=raincloud_plot(reshape(filtert1,height(filtert1)*width(filtert1),1),Precip_scalefactor*reshape(filterp1,height(filterp1)*width(filterp1),1),'color',[1 1 1],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .15, 'dot_dodge_amount', .6, 'box_col_match', 0);       
h2=raincloud_plot(reshape(filtert2,height(filtert2)*width(filtert2),1),Precip_scalefactor*reshape(filterp2,height(filterp2)*width(filterp2),1),'color',[1 0 0],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .55, 'dot_dodge_amount', 1.6,'box_col_match', 1);
hold on
ylocations=[-0.4:0.05:0.25];
xline(0, '-', LineWidth=1, Alpha=1)
xline(2, '--', LineWidth=1)
set(gca,'Ytick',[0,0.05,0.1,0.15,0.2,0.25,0.3])
title("September", "FontWeight", "normal")
set(gca, 'XLim', [-25 25]);
set(gca,'Xtick',[])
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
%% Raincloud Oct
filtert1=HPCmonthlyTmean(HPCmonthlyTime(:,1)>=2016 & HPCmonthlyTime(:,1)<2046 & HPCmonthlyTime(:,2)==10,:);
filterp1=HPCmonthlyPtot(HPCmonthlyTime(:,1)>=2016 & HPCmonthlyTime(:,1)<2046 & HPCmonthlyTime(:,2)==10,:);
 
filtert2=HPCmonthlyTmean(HPCmonthlyTime(:,1)>=2066 & HPCmonthlyTime(:,1)<2096 & HPCmonthlyTime(:,2)==10,:);
filterp2=HPCmonthlyPtot(HPCmonthlyTime(:,1)>=2066 & HPCmonthlyTime(:,1)<2096 & HPCmonthlyTime(:,2)==10,:);
 
filtertall=[reshape(filtert1,height(filtert1)*width(filtert1),1); reshape(filtert2,height(filtert2)*width(filtert2),1)];
filterpall=[reshape(filterp1,height(filterp1)*width(filterp1),1); reshape(filterp2,height(filterp2)*width(filterp2),1)];

sub4 = subplot('Position', [0.2 0.1 0.2 0.26 - gap])
h1=raincloud_plot(reshape(filtert1,height(filtert1)*width(filtert1),1),Precip_scalefactor*reshape(filterp1,height(filterp1)*width(filterp1),1),'color',[1 1 1],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .15, 'dot_dodge_amount', .6, 'box_col_match', 0);       
h2=raincloud_plot(reshape(filtert2,height(filtert2)*width(filtert2),1),Precip_scalefactor*reshape(filterp2,height(filterp2)*width(filterp2),1),'color',[1 0 0],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .55, 'dot_dodge_amount', 1.6,'box_col_match', 1);

ylocations=[-0.4:0.05:0.25];
xline(0, '-', LineWidth=1, Alpha=1)
xline(2, '--', LineWidth=1)
set(gca,'Ytick',[0,0.05,0.1,0.15,0.2,0.25,0.3])
title("October", "FontWeight", "normal")
set(gca, 'XLim', [-25 25]);
set(gca,'Xtick',[-25, -10, 0, 10, 25])
set(h1{1}, 'LineWidth', 1)
set(h2{1}, 'LineWidth', 1)
ylim([0 0.25])
rcp4 = gcf;
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
%% Load data for RC 8.5
load("T_P_85.mat")
%% Raincloud April
hold on
Precip_scalefactor=0.5;
standardP=50;
clear h1
clear h2
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
xline(0, '-', LineWidth=1, Alpha=1)
xline(2, '--', LineWidth=1)
title("RCP 8.5", "April")
set(gca,'Ytick',[0,0.05,0.1,0.15,0.2,0.25])
set(gca, 'XLim', [-25 25]);
set(gca,'Xtick',[])
hold on
set(h1{1}, 'LineWidth', 1)
set(h2{1}, 'LineWidth', 1)
ylim([0 0.25])
l1=legend('2016-2046','','2066-2096', 'box', 'off', Location='northwest');
l1.FontSize=9;
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

Precip_scalefactor=0.5;
gap = 0.09;
sub6 = subplot('Position', [0.44 0.5 0.2 0.26 - gap])
h1=raincloud_plot(reshape(filtert1,height(filtert1)*width(filtert1),1),Precip_scalefactor*reshape(filterp1,height(filterp1)*width(filterp1),1),'color',[1 1 1],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .15, 'dot_dodge_amount', .6, 'box_col_match', 0);       
h2=raincloud_plot(reshape(filtert2,height(filtert2)*width(filtert2),1),Precip_scalefactor*reshape(filterp2,height(filterp2)*width(filterp2),1),'color',[1 0 0],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .55, 'dot_dodge_amount', 1.6, 'box_col_match', 1);

ylocations=[-0.4:0.05:0.25];
xline(0, '-', LineWidth=1, Alpha=1)
xline(2, '--', LineWidth=1)
set(gca,'Ytick',[0,0.05,0.1,0.15,0.2,0.25,0.3])
title("May", "FontWeight", "normal")
set(gca, 'XLim', [-25 25]);
set(gca,'Xtick',[])
set(h1{1}, 'LineWidth', 1)
set(h2{1}, 'LineWidth', 1)
ylim([0 0.25])

%% Calculate percentage area of the plot which falls within a certain temperature

% h{1}, on line 54, contains the information to make plot the area of the graph.
temperatures=h2{1}. XData; %  temperature values
freq=h2{1}. YData;                % frequency
areatotal=trapz(temperatures,freq); % This is equal to 1
temperature_range=[0,20]; % over which range do you want to calculate probability?
xindex=find(temperatures > temperature_range(1) &  temperatures < temperature_range(2)); % find indices in the dataset
areatotal_specific=trapz(temperatures(xindex),freq(xindex)); % This is the area under the graph encapusalted by this range.
% So, we can say that in April, the probabilty of a temperature between -12
% and -8 degrees is 0.21. 
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

sub7 = subplot('Position', [0.44 0.3 0.2 0.26 - gap])
h1=raincloud_plot(reshape(filtert1,height(filtert1)*width(filtert1),1),Precip_scalefactor*reshape(filterp1,height(filterp1)*width(filterp1),1),'color',[1 1 1],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .15, 'dot_dodge_amount', .6, 'box_col_match', 0);       
h2=raincloud_plot(reshape(filtert2,height(filtert2)*width(filtert2),1),Precip_scalefactor*reshape(filterp2,height(filterp2)*width(filterp2),1),'color',[1 0 0],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .55, 'dot_dodge_amount', 1.6,'box_col_match', 1);
hold on
ylocations=[-0.4:0.05:0.25];
xline(0, '-', LineWidth=1, Alpha=1)
xline(2, '--', LineWidth=1)
set(gca,'Ytick',[0,0.05,0.1,0.15,0.2,0.25,0.3])
title("September", "FontWeight", "normal")
set(gca, 'XLim', [-25 25]);
set(gca,'Xtick',[])
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

Precip_scalefactor=0.5;
gap = 0.09;
sub8 = subplot('Position', [0.44 0.1 0.2 0.26 - gap])
h1=raincloud_plot(reshape(filtert1,height(filtert1)*width(filtert1),1),Precip_scalefactor*reshape(filterp1,height(filterp1)*width(filterp1),1),'color',[1 1 1],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .15, 'dot_dodge_amount', .6, 'box_col_match', 0);       
h2=raincloud_plot(reshape(filtert2,height(filtert2)*width(filtert2),1),Precip_scalefactor*reshape(filterp2,height(filterp2)*width(filterp2),1),'color',[1 0 0],'alpha',0.5,'box_dodge', 1, 'box_dodge_amount', .55, 'dot_dodge_amount', 1.6,'box_col_match', 1);

%hold on
ylocations=[-0.4:0.05:0.25];
xline(0, '-', LineWidth=1, Alpha=1)
xline(2, '--', LineWidth=1)
set(gca,'Ytick',[0,0.05,0.1,0.15,0.2,0.25,0.3])
title("October", "FontWeight", "normal")
%set(gca, 'YLim', [-.5 0.25]);
set(gca, 'XLim', [-25 25]);
set(gca,'Xtick',[-25, -10, 0, 10, 25])
set(h1{1}, 'LineWidth', 1)
set(h2{1}, 'LineWidth', 1)
ylim([0 0.25])
Octlab = xlabel('Mean Monthly Temperature (^{o}C)');
Octlab.Position(2) = -0.05; % change vertical position of ylabel
Octlab.Position(1) = -29;

%% Area under graph
% h{1}, onl line 54, contains the information to make plot the area of the graph.
temperatures=h2{1}. XData; %  temperature values
freq=h2{1}. YData;                % frequency
areatotal=trapz(temperatures,freq); % This is equal to 1
temperature_range=[0,20]; % over which range do you want to calculate probability?
xindex=find(temperatures > temperature_range(1) &  temperatures < temperature_range(2)); % find indices in the dataset
areatotal_specific=trapz(temperatures(xindex),freq(xindex)); % This is the area under the graph encapusalted by this range.
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
set(subs, 'FontSize', 12);

%% Plot options
annotation('textbox', [0.382375 0.77381231451366 0.1 0.1], 'String', '(a)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')
annotation('textbox', [0.382375 0.57081231451366, 0.1, 0.1], 'String', '(c)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')
annotation('textbox', [0.382375, 0.37, 0.1, 0.1], 'String', '(e)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')
annotation('textbox', [0.382375, 0.174, 0.1, 0.1], 'String', '(g)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')

annotation('textbox', [0.622479166666667 0.77381231451366 0.1 0.1], 'String', '(b)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')
annotation('textbox', [0.622479166666667 0.57081231451366, 0.1, 0.1], 'String', '(d)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')
annotation('textbox', [0.622479166666667, 0.37, 0.1, 0.1], 'String', '(f)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')
annotation('textbox', [0.622479166666667, 0.174, 0.1, 0.1], 'String', '(h)', 'EdgeColor', 'none', 'FontSize', 14, 'FontWeight', 'normal')
%% Save figure
% cd /Users/johnnyrutherford/'OneDrive - Northumbria University - Production Azure AD'/Documents/Figures/'Alex and bo forcing data'/TVC/
cd C:\Users\w22026593\'OneDrive - Northumbria University - Production Azure AD'\Documents\Figures\'Alex and bo forcing data'\TVC
exportgraphics(gcf, "frequency_tiled.jpg", "Resolution",300)