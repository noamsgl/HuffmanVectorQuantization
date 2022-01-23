function varargout = concatzero(varargin)
    % Append a 0 to beginning of every element in varargin
    if numel(varargin) == 1
        varargout = {strcat('0', varargin{1})};
    % vectorized version
    else
        for i = 1:length(varargin)
            varargout{i} = concatzero(varargin{i});
        end
    end
end

