clear

  search_string ='      GRAPH TYPE  5231 GENERATED';

% search_string ='      GRAPH TYPE  5231 COMMENCES.';

textinc = string(readlines('list.t'));

found = find(strcmp(textinc, search_string));

% Shorten cell array to only after the search string.
if isempty(found)
    warning(['Search string "' search_string '" not found in file: list.t']);
    return
else
    textinc_shortened = textinc(found:end);
end

j=0;
findata=zeros(0,0);
for i=1:length(textinc_shortened)
    if contains(textinc_shortened(i),'      GRAPH TYPE  5231 COMMENCES.')
        % Find the next empty row
        next_row = i-17;
        while ~isempty(textinc_shortened) && next_row <= size(textinc_shortened, 1) ...
                && ~all(cellfun(@isempty, textinc_shortened(next_row, :)))
            next_row = next_row - 1;
        end
%         i = i+17?
        j=j+1;
        t=str2double(split(textinc_shortened(i+3:next_row-1)));
        findata(:,j)=t(:,4);  % x-coordinates
        j=j+1;
        t=str2double(split(textinc_shortened(i+3:next_row-1)));
        findata(:,j)=t(:,5);  % y-coordinates
    end
end