function plot_handle = Visualization(Y, x_val, readvalues)
% Visualisation plot function
    
    Ysize = size(Y);
    
    myColors = uq_colorOrder(Ysize(1));
    % Displacements matching Y(~;ii). 
   li = [0 readvalues];
    
    figure;
    
    % Loop over the realizations and plot with a different color
    for ii =  1:Ysize(1)
        uq_plot(-(li), [0 Y(ii,:)], 'x-', 'Color', myColors(ii,:));
        hold on;
    end
    hold off;
    %legend
    xlabel('$\mathrm{Disp}$ (m)')
    ylabel('$\mathrm{Load}$ (kN)')
    %grid on;
    
    plot_handle = gcf;
    
    for i = 1:size(Y, 2)
        % Create a new figure
        figure;
        
        % Get the column data
        columnData = Y(:, i);
        
        % Plot the histogram
        %histogram(columnData,[], 'FaceColor', 'none', 'EdgeColor', 'black'); % 10 bins
    
        % Fit Gaussian distribution
        h=histfit(columnData,[], 'normal','FaceColor', 'none');
        h(1).FaceColor = [.8 .8 .8];

        xline(x_val(:,i), 'k--', 'LineWidth', 2.0); % add a black dashed vertical line at x_val
        disp(x_val(:,i))
        % Set title and labels
        title(['Stage ' num2str(i)]);
        xlabel('Load [kN]');
        ylabel('Frequency/Probability');
    end

end