% concatone.m
% Noam Siegel
% January 24, 2022
function varargout = concatone(varargin)
    % Append a 1 to beginning of every element in varargin
    if numel(varargin) == 1
        varargout = {strcat('1', varargin{1})};
    % vectorized version
    else
        for i = 1:length(varargin)
            varargout{i} = concatone(varargin{i});
        end
    end
end
