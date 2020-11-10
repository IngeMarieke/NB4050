function [matrix] = segs2mat(segments)
% input: a cell of segments, that are vectors: [a;b]
% output: a matrix sixed 2 x #vectors 
nseg = length(segments);
matrix = [segments{1:nseg}];
end

