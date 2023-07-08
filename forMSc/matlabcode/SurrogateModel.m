function [myPCE] = SurrogateModel(numerical_output,Data_samples)
% SURROGATE MODEL 
%   
metaopts.Type = 'metamodel';
metaopts.MetaType = 'PCE';

% Select the sparse-favouring least-square minimization LARS for the 
% PCE coefficients calculation strategy:
metaopts.method = 'LARS';

% Select the PCE options and create the PCE model:
metaopts.Degree = 1:10;
metaopts.ExpDesign.X = Data_samples;
metaopts.ExpDesign.Y = numerical_output;
metaopts.ExpDesign.NSamples = 100;
myPCE = uq_createModel(metaopts);

% 4.3 Use the PCE model for sensitivity analysis
%
% PCESobol.Type = 'Sensitivity';
% PCESobol.Method = 'Sobol';
% PCESobol.Sobol.Order = 1;
% 
% PCESobolAnalysis = uq_createAnalysis(PCESobol);
% 
% % Display results of Sobol analysis
% uq_display(PCESobolAnalysis)
% 
% % 4.4 Reliability analysis
% % Perform a reliability analysis using Monte Carlo simulation:
% MCSopt.Type = 'Reliability';
% MCSopt.Method = 'MCS';
% 
% %
% % Define the limit-state surface:
% MCSopt.LimitState.Threshold = Threshold{1,1};   % unit: inch
% MCSopt.LimitState.CompOp = Threshold{1,2};
% 
% %
% % Run the analysis and display the results:
% myMCS = uq_createAnalysis(MCSopt);
% uq_display(myMCS)

% % Select the Orthogonal Matching Pursuit (OMP) least-square 
% % minimization to compare the results with LARS: 
% % This is least-squares error minimization. 
% MetaOpts.method = 'OMP';
% MetaOpts.ExpDesign.Sampling = 'User';
% 
% %Use the same experimental design used for LARS:
% MetaOpts.ExpDesign.X = myPCE.ExpDesign.X;
% MetaOpts.ExpDesign.Y = myPCE.ExpDesign.Y;
% 
% %Create the OMP-based PCE metamodel:
% myPCE_OMP = uq_createModel(MetaOpts);

end

