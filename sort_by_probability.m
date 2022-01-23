function sorted_vec = sort_by_probability(vec)
% Sort a vector of structs on 'probability' using selection sort
% Implemented with help from https://www.corsi.univr.it/documenti/OccorrenzaIns/matdid/matdid380839.pdf

for i = 1:length(vec) - 1
    indlow = i;
    for j = i + 1:length(vec)
        % Compare probability
        if vec(j).probability < vec(indlow).probability
            indlow = j;
        end
    end
    % Exchange elements
    temp = vec(i);
    vec(i) = vec(indlow);
    vec(indlow) = temp;
end
sorted_vec = vec;
end
