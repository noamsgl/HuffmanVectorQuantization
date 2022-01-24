% PRD.m
% Noam Siegel
% January 24, 2022
function prd = PRD(original, reconstructed)
% percentage root-mean-square difference (PRD)
top = sum((original - reconstructed).^2, 'all');
bottom = sum(original.^2, 'all');
prd = sqrt(top/bottom) * 100;

end

