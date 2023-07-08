function [Results, copulamatrix] = Iteration(Data_samples, numerical_output, numberofVariables, myDataComplete, Results, stage, myUQLinkModel, Initial_name, run_number, copulamatrix)
% Iteration function
       
    % Input 
    %copulamatrix (copulamatrix<0) = 0;  % Zeros any negatively correlated
    
    % The copula is not getting transferred corrected to the Bayesian
    % Analysis.
    % Needs more investigation. Removing functionality for now.

    copulamatrix = eye(numberofVariables); 

    myInput = DataInput(Results.Posterior.mean(run_number-1,:),sqrt(Results.Posterior.var(run_number-1,:)),Results.Posterior.name, copulamatrix);
    
    % there needs to be an if statement on whether more evaluations are
    % needed.
    %     while surrogatetolerance < surrogateerror
    %             surrogateconvergence = true; % Active learning will go in here.
    
    % Commented out to avoid more analysis.
    % [numerical_output, Data_samples] = Evaluatemodel(NumberofSamples,Data_samples,numerical_output, myUQLinkModel);
    
    numerical_output_stage = numerical_output(:,stage);
    myPCE = SurrogateModel(numerical_output_stage, Data_samples);
    %     end

    myData.y = myDataComplete (:,stage);
    myBayesianAnalysis_surrogateModel = BayesianAnalysis(myData, myPCE);
    
    [Results, copulamatrix] = PostProcessing(Results, ...
                            myBayesianAnalysis_surrogateModel, ...
                            numberofVariables, ...
                            Initial_name, ...
                            run_number);
end

