% PRD.m
% Noam Siegel
% January 24, 2022
function prd = PRD(original, reconstructed)
% percentage root-mean-square difference (PRD)
top = sum((original - reconstructed).^2);
bottom = sum(original.^2);
prd = sqrt(top/bottom) * 100;

end

