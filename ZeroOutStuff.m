function [Adjacency] = ZeroOutStuff(Adjacency, MidCycle)
GraphSize = max(size(Adjacency));

Z = zeros(GraphSize,1);
for i = 1:length(MidCycle)
    Adjacency(MidCycle(i),:) = Z;
    Adjacency(:,MidCycle(i)) = Z;
end


end

