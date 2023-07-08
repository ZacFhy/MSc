clear

%% 
% addpath('\\icnas3.cc.ic.ac.uk\zyf22\Desktop\32\gramm-master')
addpath('D:\Github\MSc\gramm-master\gramm')

%%
fn='03_SAA8003 data.xlsx';        % using a fully-qualified filename here would be good practice
opt=detectImportOptions(fn);
% wanted/need options code/fixup here...
shts=sheetnames(fn);
data={}
date = {}
for i=1:length(shts)
  data{i} = readtable(fn,opt,'sheet',shts(i))
  date{i} = readcell(fn,opt,'sheet',shts(i))
  data{i}(1:3,:) = []
  date{i}=date{i}(2,:)
end
%% testing
ha = data{1}(:,2)
a = data{1}(:,1)
 g=gramm('x',ha,'y',a);
% ,'color',date{1}(2),'subset','subset',cars.Cylinders~=3 & cars.Cylinders~=5
g.set_names('x','shit','y','on9')
g.geom_line();
g.draw()
%% test

