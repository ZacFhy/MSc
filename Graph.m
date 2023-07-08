clear


%% 
addpath('\\icnas3.cc.ic.ac.uk\zyf22\Desktop\32\gramm-master')

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
%% 

g=gramm('x',cars.Model_Year,'y',cars.MPG,'color',cars.Cylinders,'subset',cars.Cylinders~=3 & cars.Cylinders~=5);
