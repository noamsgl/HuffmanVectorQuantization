function prd = PRD(original,reconstructed)
% percentage root-mean-square difference (PRD)
% as requested in question 2.3 1)

top = sum((original - reconstruced).^2);
bottom = sum(original.^2);
prd = sqrt(top/bottom) * 100;
end

