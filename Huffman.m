function codebook = Huffman(probabilities_table)
%Huffman coding
%   accepts a table with variables "edge_lower" and "probability"
%   return a Huffman codebook
if ~isa(probabilities_table,'table')
    error('input is not a table')
end

% Sort probabilities_table by probability, ascending
probabilities_table = sortrows(probabilities_table, 'probability');

% Initialize queue (cell array of structs)
% queue = {};
for i = 1:height(probabilities_table)
    node = table2struct(probabilities_table(i,:));
    node.left = [];
    node.right = [];
    queue(i) = node;
end

% Build Huffman codebook as tree
while numel(queue) > 1
    queue = sort_by_probability(queue);
    % get two smallest probabilities
    least_freq = queue(1:2);
    % remove them from queue
    queue = queue(3:end);
    
    % construct pair node
    node = struct();
    node.edge_lower = [];  % inner nodes dont have values
    node.left = least_freq(1);
    node.right = least_freq(2);
    node.probability = least_freq(1).probability + least_freq(2).probability;
    
    %append node to queue
    queue = [queue node];
end
codebook = queue;
end

 
% Get length of signal
% n = width(symbols);
% % Initialize the PriorityQueue
% prob_queue = probabilities;  
% symbol_queue = symbols;  
% 

% Iterate over queue
% while length(prob_queue) > 1
%     [prob_queue, indices] = sort(prob_queue, 'ascending');
%     symbol_queue = symbol_queue(indices)
%     first_prob = prob_queue(1);
%     second_prob = prob_queue(2);
%     first_symbol = symbol_queue(1);
%     second_symbol = symbol_queue(2);
% end
% codebook = 5
