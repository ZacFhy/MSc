%% close all figures
close all

%%
%%%

%   RUN 6

%%% 

% %
% % TITLE: Axi-symmetric analysis using ICFEP
% This example showcases how to link UQLab with ICFEP. 
%
% This example creates a UQLink model object that links UQlab to
% an ICFEP model.

% Various analyses are carried out with the created UQLink MODEL object.

%% 1 - INITIALIZE UQLAB
%
% Clear all variables from the workspace, set the random number generator
% for reproducible results, add the necessary file paths and initialize UQLAB:
clc
clearvars
addpath('E:\tl\UQLab_Rel2.0.0\core')
addpath('E:\tl\DATA\MatlabCode\Probablistic-model-calibration')
rng(1,'twister')
uqlab

%% 2 - COMPUTATIONAL MODEL WITH UQLINK (WRAPPER OF ICFEP)
%
% Initialize UQLink:
name = 'footing';
myUQLinkModel = Initialize(name);


%% 3 - PROBABILISTIC INPUT MODEL
% 
% 3.1 Initial input parameters (First Prior distribution)
Initial_name    =   {    'G_{01}' , 'b_{01}'  , 'G_{02}' , 'b_{02}'};
Initial_mean    =   [      55000      1.5         85000     1.5 ];
Initial_std     =   [      10000      0.3         15000     0.3 ];
numberofVariables = length(Initial_name);

% Indepentant decrepancies (no correlation)
copulamatrix = eye(numberofVariables);
% copulamatrix = [1 0.8; 0.8 1];
% copulamatrix = [1 -0.8; -0.8 1];

%This is a counter which indicates how many complete loops the model has
%run. As this is part of the first initialization loop, counter = 1. 
run_number = 1; %Matlab indexing starts at 1.

% Create the INPUT object
myInput = DataInput(Initial_mean, Initial_std, Initial_name, copulamatrix);

uq_display(myInput)
set(gcf,'name','Input_figure');

%% 4 - SAMPLING FROM PDF AND EVALUATE MODEL 
%
% Evaluate the ICFEP model for the experimental design for a number 
% of samples via Latin Hypercube sampling:

% Number of samples to be evaluated
NumberofSamples = 20;

% Empty variables
% Performance can be improved with Preallocation "zeros(rows,columns)"
Data_samples=[];
numerical_output=[];

% Evaluation step
% The input model is implied. 

% Best to change to a batch system (say 10 batches of 10 for 100 total simulations). 
% This will work better.
[numerical_output, Data_samples] = Evaluatemodel(NumberofSamples, ...
                                                Data_samples, ...
                                                numerical_output, ...
                                                myUQLinkModel);

% ################# End of ICFEP interaction ###########################

%% 5 - POLYNOMIAL CHAOS EXPANSION (PCE) 
% A.K.A Surrogate model
%

% % % TEMP: 
% % %This is a counter which indicates how many complete loops the model has
% % %run. As this is part of the first initialization loop, counter = 1. 
run_number = 1; % Matlab indexing starts at 1. 

Results.Posterior=[]; % First row is filled with prior values.
Results.corr = copulamatrix (1,:); % First row of a eye vector.
Results.Posterior.name = Initial_name;
Results.Posterior.mean(run_number, :)=Initial_mean;
Results.Posterior.var(run_number, :) =Initial_std.^2; 
run_number = run_number+1; 
% % %-----

myPCE = SurrogateModel(numerical_output(:,1), Data_samples);

%% 6 - MEASUREMENT DATA
%
% Real values used to generate data
real_val = [63085	1.31	98595	1.12]; 

% Variance 0.03, 0.005, 0.1

% Numerical output/measured data
myDataComplete = [  10.18	15.24	26.13	39.93	192.82	304.98	312.42;
10.47	15.08	27.01	39.29	187.20	307.34	323.29;
10.65	15.18	25.90	39.45	192.40	299.94	330.39];

readvalues = [-0.001, -0.002, -0.005, -0.01, -0.1, -0.2, -0.3];  % This still needs to be updated in 'readfooting.m'

myData.Name = 'DATA';
myData.y = myDataComplete (:,1);

%% 7 - BAYESIAN ANALYSIS
%  Comment: It is not currently possible to perform Bayesian Inference
%  using the UQLink forward model directly. The program requires that a
%  lighter weight forward model (in the form of a surrogate model) be
%  provided in order to carry out the inversion. 

myBayesianAnalysis_surrogateModel = BayesianAnalysis(myData, myPCE);

%% 8 - POSTPROCESSING
%
[Results, copulamatrix] = PostProcessing(Results, ...
                        myBayesianAnalysis_surrogateModel, ...
                        numberofVariables, ...
                        Initial_name, ...
                        run_number);

%% 9 - Further Bayesian inference 
%

% Iterate variables
stage = 1+1; 
tolerance = 0.05 ;  % See the LOO loop in UQLAB

for ii = 1:(size(myDataComplete,2)-1)
    error = 1; % reset error.
    while tolerance < error 
        run_number = run_number + 1;
        Results = Iteration(Data_samples, ...
                            numerical_output, ...
                            numberofVariables, ...
                            myDataComplete, ...
                            Results, ...
                            stage, ...
                            myUQLinkModel, ...
                            Initial_name, ...
                            run_number, ...
                            copulamatrix);
        error = 0;  % This will need to be updated to real error down the line.
    end
stage = stage + 1;
end

disp('Analysis complete.')

%% 10 - Visualization

% Display output 1
plot = Visualization(numerical_output, myDataComplete, readvalues);

%%
% Display output 2
plot = Visualization_results(Results, real_val);
% 
% %% EXPORT
% figures = sort(findobj('MenuBar','figure'));
% for ii = 1:length(figures)
%     f = figure(ii);
%     exportgraphics(f,['Figures/',num2str(ii),'.pdf'],'ContentType','vector',...
%                'BackgroundColor','none');
% end
% 
% % 
%%
% 
% f = figure(23);
% exportgraphics(f,['Figures/',num2str(23),'.pdf'],'ContentType','vector',...
%            'BackgroundColor','none');