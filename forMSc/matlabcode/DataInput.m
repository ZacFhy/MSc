function myInput = DataInput(Input_mean,Input_std,Input_name, copulamatrix)
%DATAINPUT Summary of this function goes here
%   Detailed explanation goes here

if ismatrix(Input_mean)
    % tilde means this variable is deleted immediately and is therefore
    % unused. 
    [~,c] = size(Input_mean);
    for ii = 1:c
        InputOpts.Marginals(ii).Name = Input_name{ii};
        InputOpts.Marginals(ii).Type = 'Gaussian';
        InputOpts.Marginals(ii).Moments = [Input_mean(ii) Input_std(ii)];
        InputOpts.Marginals(ii).Bounds = [1e-7 inf];
        
    end
end

InputOpts.Copula = uq_GaussianCopula(copulamatrix);
% InputOpts.Copula.Type = 'Gaussian';
% InputOpts.Copula.RankCorr = couplamatrix;  % the Spearman corr. matrix

% Create the INPUT object
myInput = uq_createInput(InputOpts);



end

