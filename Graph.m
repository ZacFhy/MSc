clear

%% 
% addpath('\\icnas3.cc.ic.ac.uk\zyf22\Desktop\32\gramm-master')
addpath('D:\Github\MSc\gramm-master')

%%
fn='03_SAA8003 data.xlsx';        % using a fully-qualified filename here would be good practice
opt = detectImportOptions(fn);
% wanted/need options code/fixup here...
shts=sheetnames(fn);
data={}
date = {}
for i=1:length(shts)
  data{i} = readmatrix(fn,opt,'sheet',shts(i))
  date{i} = readcell(fn,opt,'sheet',shts(i))
  data{i}(1:3,:) = []
  date{i}=date{i}(1,:)
  
end

% for i=1:length(data{1}(:,1))
%     for j=1:length(data{1}(1,:))
% date{1}(i,j)=date{1}(1,j)
%     end
% end
%% testing
ha = data{1}(:,2:24)
a = data{1}(:,1)
c = date{1}(:,2:24)
plot(ha,a)

% for i=1:length(date{1}(2:24))
%   g{i}=sprintf('%d',date{1}(i));
% end
legend(c)

 % LegendsStrings{i} = ['variance_a = ',num2str(variance_a(i))];
%% test

