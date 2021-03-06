% tree2book.m
% Noam Siegel
% January 24, 2022
function codebook = tree2book(root)
    % Parse a binary tree representing a huffman codebook
    if (isequal(root.left, []) && isequal(root.right, []))
       codebook = struct('lower_edge', root.lower_edge, 'code', '0');
       return
    end
    if (isequal(root.left, []))
        codebook = tree2book(root.right);
        return
    end
    if (isequal(root.right, []))
        codebook = tree2book(root.left);
        return
    end
    % recursively find left and right children codebooks
    lcodebook = tree2book(root.left);
    rcodebook = tree2book(root.right);
    
    % append 0 and 1 to codewords
    lcode = {lcodebook.code};
    rcode = {rcodebook.code};
    new_lcode = concatzero(lcode);
    [lcodebook.code] = new_lcode{:};
    new_rcode = concatone(rcode);
    [rcodebook.code] = new_rcode{:};
    
    % concat structs
    codebook = [lcodebook; rcodebook];
end




