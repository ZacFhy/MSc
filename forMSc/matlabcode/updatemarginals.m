function updatedprior = updatemarginals(results)

% % This is the current method of prior update
% % Option 1 : Get the postprocessing results, ie mean and standard deviation
% dist_post_pro.Name = 'distribution inversion postpro';
% dist_post_pro.Marginals(1).Name = 'E';
% dist_post_pro.Marginals(1).Type = 'Gaussian';
% dist_post_pro.Marginals(1).Moments = [myBayes.Results.PostProc.Percentiles.Mean(1) sqrt(myBayes.Results.PostProc.Percentiles.Var(1))];
% mydist_post_pro = uq_createInput(dist_post_pro); %the distribution based on mean and std


% It is might be better to use this method for prior update. 
% Inference of the samples created in MCMC
PostSample3D = myBayesianAnalysis_surrogateModel.Results.PostProc.PostSample ; 
PostSample2D = reshape(permute(PostSample3D, [2 1 3]), size(PostSample3D, 2), [])';
iOpts.Inference(1).Data = PostSample2D(:,2) ; 
%iOpts.Marginals(1).Type = {'Gaussian', 'Exponential', 'Weibull'}; % works
%iOpts.Marginals(1).Type = 'ks'; % works
iOpts.Marginals(1).Type = {'Gaussian', 'LogNormal'}; % works. 
iOpts.Copula(1).Type = 'Independent';
iOpts.Inference(1).Criterion = 'KS';
mydist_infer = uq_createInput(iOpts);
uq_print(mydist_infer)

%Creation of samples from the two post-inputs 
Xtest_inf= uq_getSample(mydist_infer , 15000, 'LHS');

% % hold on to the existing plot and add a histogram of the second dataset
figure
histogram(Xtest_inf,55)
%histfit(PostSample2D(:,2),55,'loglogistic') %Checking matlab's default
hold on
histogram(PostSample2D(:,2),55)

xlabel('\theta_1')
ylabel('Count')
% 
% figure
% x=min(PostSample2D(:,2)):0.01:max(PostSample2D(:,2));
% % values Parameter values  from output of uq_print(mydist_infer)
% y = lognpdf(x,4.531e+00, 8.173e-02 );
% plot (x,y)
% 
% figure 
% histogram(log(PostSample2D(:,2)),55)
% 
% xlabel('log(\theta_1)')
% ylabel('Count')
% 
% figure 
% histogram(log(log(PostSample2D(:,2))),55)
% 
% xlabel('log(log(\theta_1))')
% ylabel('Count')
