function plot_handle = Visualization_results(Results, x_val)

%mu2 = Results.Posterior.mean(:,1)'; 
%sigma2 = Results.Posterior.var(:,1)';

% % Define mu and sigma values as arrays
for ii = 1:(size(Results.Posterior.var,2))
    mu = Results.Posterior.mean(:,ii)'; 
    var = Results.Posterior.var(:,ii)';
        
    % Generate x-axis values
    x = linspace(mu(1)-3*sqrt(var(1)), mu(1)+3*sqrt(var(1)), 1000); %First parameter
        
    % Generate y-axis values for normal distributions
    yresults = zeros(length(x), length(mu));
    for i = 1:length(mu)
        yresults(:, i) = normpdf(x, mu(i), sqrt(var(i)));
    end
    
    % Plot the normal distributions as curves
    figure;
    formatSpec = '%.1f';
    plot(x, yresults(:, 1), 'LineWidth', 2, 'DisplayName', ['Prior (\mu=' num2str(mu(1),formatSpec) ', \sigma=' num2str(sqrt(var(1)),formatSpec) ')']);
    hold on;
    plot(x, yresults(:, 2), 'LineWidth', 2, 'DisplayName', ['Stage 1 (\mu=' num2str(mu(2),formatSpec) ', \sigma=' num2str(sqrt(var(2)),formatSpec) ')']);
    plot(x, yresults(:, 3), 'LineWidth', 2, 'DisplayName', ['Stage 2 (\mu=' num2str(mu(3),formatSpec) ', \sigma=' num2str(sqrt(var(3)),formatSpec) ')']);
    plot(x, yresults(:, 4), 'LineWidth', 2, 'DisplayName', ['Stage 3 (\mu=' num2str(mu(4),formatSpec) ', \sigma=' num2str(sqrt(var(4)),formatSpec) ')']);
    plot(x, yresults(:, 5), 'LineWidth', 2, 'DisplayName', ['Stage 4 (\mu=' num2str(mu(5),formatSpec) ', \sigma=' num2str(sqrt(var(5)),formatSpec) ')']);
    plot(x, yresults(:, 6), 'LineWidth', 2, 'DisplayName', ['Stage 5 (\mu=' num2str(mu(6),formatSpec) ', \sigma=' num2str(sqrt(var(6)),formatSpec) ')']);
    plot(x, yresults(:, 7), 'LineWidth', 2, 'DisplayName', ['Stage 6 (\mu=' num2str(mu(7),formatSpec) ', \sigma=' num2str(sqrt(var(7)),formatSpec) ')']);
    plot(x, yresults(:, 8), 'LineWidth', 2, 'DisplayName', ['Stage 7 (\mu=' num2str(mu(8),formatSpec) ', \sigma=' num2str(sqrt(var(8)),formatSpec) ')']);
    % Add a vertical line at x_val
    xline(x_val(ii), 'k--', 'LineWidth', 1.0); % add a black dashed vertical line at x_val
    
    legend('Location', 'northwest');
    xlabel(Results.Posterior.name(:,ii));
    ylabel('Probability Density');
end

plot_handle = gcf;
%title('Four Normal Distributions');