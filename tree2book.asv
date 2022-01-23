function codebook = tree2book(root)
    if (isequal(root.left, []) && isequal(root.right, []))
       codebook = struct('lower_edge', root.edge_lower, 'code', '0');
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
    lcodebook.code = concatzero(lcodebook.code);
    rcodebook.code = concatone(rcodebook.code);
    
    % concat structs
    codebook = [lcodebook; rcodebook];
end




