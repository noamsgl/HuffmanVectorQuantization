function varargout = concatzero(varargin)
    if numel(varargin) == 1
        varargout = strcat('0', varargin);
    % vectorized version
    else
        for i = 1:length(varargin)
            varargout{i} = concatzero(varargin{i});
        end
    end
end

