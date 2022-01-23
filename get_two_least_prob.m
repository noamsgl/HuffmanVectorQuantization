function [first, second, rest] = get_two_least_prob(vec)
% Gets a vector of structs with 'probability'
% Returns the first and second least probable, and the rest untouched.

% get first least frequent
min_idx = 1;
for i = 2:length(vec)
    if vec(i).probability < vec(min_idx).probability
        min_idx = i;
    end
end

% bring min_idx to top
temp = vec(1);
vec(1) = vec(min_idx);
vec(min_idx) = temp;

% get second least frequent
min_idx = 2;
for i = 3:length(vec)
    if vec(i).probability < vec(min_idx).probability
        min_idx = i;
    end
end

% bring min_idx to top
temp = vec(2);
vec(2) = vec(min_idx);
vec(min_idx) = temp;

% return values
first = vec(1);
second = vec(2);
rest = vec(3:end);
end
