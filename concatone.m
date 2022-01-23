function varargout = concatone(varargin)
    if numel(varargin) == 1
        varargout = strcat('1', varargin);
    % vectorized version
    else
        for i = 1:length(varargin)
            varargout{i} = concatone(varargin{i});
        end
    end
end
