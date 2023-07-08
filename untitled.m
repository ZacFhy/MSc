

function findata_output_row = readfootingoutput(outputfilename)
% outputfilename is known to be superfluous. 

search_string ='      GRAPH TYPE  5231 COMMENCES.';

textinc = string(readlines('list.t'));

found = find(strcmp(textinc, search_string));

% Shorten cell array to only after the search string.
if isempty(found)
    warning(['Search string "' search_string '" not found in file: list.t']);
    return
else
    textinc_shortened = textinc(found:end);
end

% Converting cell array of strings to numerical array (matrix) for post
% processing.

j=0;
findata=zeros(0,0);
for i=1:length(textinc_shortened)
    if contains(textinc_shortened(i),'      GRAPH DATA:')
        % Find the next empty row
        next_row = i+3;
        while ~isempty(textinc_shortened) && next_row <= size(textinc_shortened, 1) ...
                && ~all(cellfun(@isempty, textinc_shortened(next_row, :)))
            next_row = next_row + 1;
        end
        j=j+1;
        t=str2double(split(textinc_shortened(i+3:next_row-1)));
        findata(:,j)=t(:,4);  % x-coordinates
        j=j+1;
        t=str2double(split(textinc_shortened(i+3:next_row-1)));
        findata(:,j)=t(:,5);  % y-coordinates
    end
end

% Filtered data for rows of interest

% Define filter values 
% It might be possible to grab these from the input data file. These are
% simply the end values of the increment stages. 
% Be careful though, this only applies if you are extracting the same
% values as what you are plotting. 
filter_values = [-0.001, -0.002, -0.005, -0.01, -0.1, -0.2, -0.3];


% Filter for columns in the first row equal to any of the filter values
idx = ismember(findata(:, 1), filter_values);
findata_output = findata(idx, :);
findata_output = transpose(findata_output);

% Return only the second row. 

row_filter = 2;
findata_output_row = -findata_output(row_filter, :);

% %% Check output with some plots
% % Check input size
% [m, n] = size(findata_output);
% if mod(m, 2) ~= 0
%     error('Input matrix must have an even number of rows');
% end
% 
% % Plot each pair of columns as x and y coordinates
% figure;
% h1=axes;
% hold on;
% for i = 1:2:n
%     x = findata_output(i, :);
%     y = findata_output(i+1, :);
%     plot(x, y, 'o');
%     set(h1, 'Ydir', 'reverse')
%     set(h1, 'Xdir', 'reverse')
% end
% hold off;

end
