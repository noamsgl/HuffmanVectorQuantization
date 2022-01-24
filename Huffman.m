% Huffman.m
% Noam Siegel
% January 24, 2022
function codetree = Huffman(probabilities_table)
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
    % pop two smallest probability structs from queue
    [first, second, queue] = get_two_least_prob(queue);

    % construct pair node
    node = struct();
    node.lower_edge = [];  % inner nodes dont have values
    node.left = first;
    node.right = second;
    node.probability = first.probability + second.probability;
    
    %append node to queue
    queue = [queue node];
end
codetree = queue;
end