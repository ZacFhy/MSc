function [Results, copulamatrix] = PostProcessing(Results, myBayesianAnalysis_surrogateModel,numberofVariables,Initial_name,run_number)
%POSTPROCESSING Summary of this function goes here
%   Detailed explanation goes here
uq_postProcessInversionMCMC(myBayesianAnalysis_surrogateModel, ...
      'pointEstimate', 'Mean')

% Print out a report of the results:
%uq_print(myBayesianAnalysis_surrogateModel)

% Create a graphical representation of the results:
% Pick one from below:
% 1.
%uq_display(myBayesianAnalysis_surrogateModel)
% or 2.
%uq_display_uq_inversion_MCMC(myBayesianAnalysis_surrogateModel, 'scatterplot', 1:numberofVariables)

% Extracting results from Bayesian inference
% Quirk of UQLab. Convert 1x1 cell into double. 
MAP_Posterior = [myBayesianAnalysis_surrogateModel.Results.PostProc.PointEstimate.X{:}];

Results.Posterior.MAP(run_number, :)=MAP_Posterior(1:numberofVariables);
Results.Posterior.name = Initial_name;
Results.Posterior.mean(run_number, :)=myBayesianAnalysis_surrogateModel.Results.PostProc.Percentiles.Mean(1:numberofVariables);
Results.Posterior.var(run_number, :)=myBayesianAnalysis_surrogateModel.Results.PostProc.Percentiles.Var(1:numberofVariables); 
Results.corr(run_number,:)=myBayesianAnalysis_surrogateModel.Results.PostProc.Dependence.Corr(1:numberofVariables);
copulamatrix = myBayesianAnalysis_surrogateModel.Results.PostProc.Dependence.Corr(1:numberofVariables, 1:numberofVariables);

end

