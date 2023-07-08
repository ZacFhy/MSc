function [Numerical_output,Data_samples] = Evaluatemodel(NumberofSamples, Data_samples, Numerical_output, myUQLinkModel)
%EVALUATEMODEL Summary

% Generate an experimental design (ED)
% using Latin Hypercube Sampling:
Data_samples_current = uq_getSample(NumberofSamples,'LHS');

% Carries out model evaluation

if isempty(Data_samples) == 0 
    Numerical_output_current = uq_evalModel(myUQLinkModel, Data_samples_current); 
    
    %Combining previous results with new iteration
    Data_samples = vertcat(Data_samples_current,Data_samples);
    Numerical_output = vertcat(Numerical_output_current,Numerical_output);
else
    Data_samples = vertcat(Data_samples_current,Data_samples);
    Numerical_output = uq_evalModel(myUQLinkModel, Data_samples);   
end

end    