function [myBayesianAnalysis_surrogateModel] = BayesianAnalysis(myData,myPCE, myInput, myDiscrepancyOpt)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% The options of the Bayesian analysis are specified with the following
% structure:
BayesOpts.Type = 'Inversion';
BayesOpts.Data = myData;
%
% Run the Bayesian inversion analysis using the surrogate:
BayesOpts.ForwardModel.Model = myPCE;
%BayesOpts.Prior = myInput;
%BayesOpts.Discrepancy = DiscrepancyOpts;

% % Prior distribution used in the MCMC surrogate analysis.
% UpdatedPrior_mean = [60 700]*1e4;
% UpdatedPrior_std = [4.5 50]*1e4;
% UpdatedPrior_name = {'Clay', 'SubBase Layer'}; %Line not necessary but kept
% % % run_number still kept at zero but probably not correct.
% % 
% BayesOpts.Prior =  DataInput(UpdatedPrior_mean,UpdatedPrior_std,UpdatedPrior_name);

% % If a specific type of MCMC estimation is required. See manual. 
% BayesOpts.Solver.Type = 'MCMC';
% BayesOpts.Solver.MCMC.Sampler = 'AIES';
% BayesOpts.Solver.MCMC.Steps = 25;   % Standard ~500
% BayesOpts.Solver.MCMC.a = 3;

% % Bayesian Inference Visualization. 
% Looking at the trace of the MCMC
%BayesOpts.Solver.MCMC.Visualize.Parameters = [1 2];
%BayesOpts.Solver.MCMC.Visualize.Interval = 100;

myBayesianAnalysis_surrogateModel = uq_createAnalysis(BayesOpts);

uq_print(myBayesianAnalysis_surrogateModel)

end

