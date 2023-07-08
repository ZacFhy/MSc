function myUQLinkModel = Initialize(name)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% Model type:
ModelOpts.Type = 'UQLink';
ModelOpts.Name = name;


% Provide mandatory options - the command line, i.e.,
% a sample of the command line that will be run on the shell:
ModelOpts.Command = 'icfep E:\tl\RUN\RUN7\footing.t 24.0';

% Provide the template file, i.e., a copy of the original input files
% where the inputs of interest are replaced by markers:
ModelOpts.Template = 'footing.t.tpl';

% Provide the MATLAB file that is used to retrieve the quantity of interest
% from the code output file:
% The output file it will check is simply list.t. As ICFEP writes to the 
% the zeroth output file (pushing the earlier files down), iteration is 
% not required. 
ModelOpts.Output.FileName = 'list.t';
ModelOpts.Output.Parser = 'readfootingoutput';

% Provide additional non-mandatory options -
% Execution path (where ICFEP will be run):
ModelOpts.ExecutionPath = fullfile('E:\tl\RUN\RUN7');

ModelOpts.Counter.Digits = 3;

% Specify the format of the variables written in the ICFEP input file:
% This is formatted as scientific notation.
ModelOpts.Format = {'%1.3E'};

% Set the display to quiet:
ModelOpts.Display = 'quiet';

%ModelOpts.Archiving.Action = 'delete';

% Create the UQLink wrapper:
myUQLinkModel = uq_createModel(ModelOpts);
% uq_listModels
end

