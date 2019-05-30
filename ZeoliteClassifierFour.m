function [Cycles, Adjacency] = ZeoliteClassifierFour(Source, CurrentPath,...
    UsedNodes, Adjacency, LengthOfCycle, iteration, CurrentVertex)
%%%Function for zeolite classification written by Justin Crum.  Work
%%%finished on 4/30/19.  This is a function made for use for a term project
%%%in SIE 546, Network Flows and Graph Algorithms, at University of
%%%Arizona.  The function, along
%%%with ZeroOutStuff.m is made to be used by chemical engineering
%%%researchers at Notre Dame University.


%Usage of this function is as follows:
%Source should be the desired source node.
%CurrentPath should just initially be set to an empty list or 0.
%UsedNodes should just be initially set to an empty list or 0.
%Adjacency should be the adjacency matrix to input.  Between cycles, you %should use the zero out function to make sure that the Adjacency structure 
%correctly identifies cycles.
%The LengthOfCycle should be the length of the actual cycle defining a
%zeolite ring.
%iteration should start as 0.
%CurrentVertex should start as 0.



global CycleList


if(iteration == 0)
    CurrentVertex = Source;
    UsedNodes = [Source];
    CurrentPath = [Source];
    iteration = iteration + 1;
    ZeoliteClassifierFour(Source, CurrentPath, UsedNodes, Adjacency, LengthOfCycle, iteration, CurrentVertex);
else
    if(iteration == 1)
        UsedNodes(1) = [];
    end
    iteration = iteration + 1;
    if(length(CurrentPath) == LengthOfCycle && CurrentPath(end) == Source)
        CycleList = [CycleList, CurrentPath];
        Cycle = CurrentPath;
        Adjacency = ZeroOut(CurrentPath, Adjacency);
    elseif(length(CurrentPath) < LengthOfCycle)
        CurrentNeighbors = find(Adjacency(CurrentVertex,:));
        for i = 1:length(CurrentNeighbors)
            Used = false;
            CurrentVertex = CurrentNeighbors(i);
            for j = 1:length(UsedNodes)
                if(CurrentNeighbors(i) == UsedNodes(j))
                    Used = true;
                end
            end
            
            if(~Used)
                CurrentPath = [CurrentPath; CurrentVertex];
                UsedNodes = [UsedNodes; CurrentVertex];
                NodeIndex = length(UsedNodes);
                [Cycles, Adjacency] = ZeoliteClassifierFour(Source, CurrentPath, UsedNodes, Adjacency, LengthOfCycle, iteration, CurrentVertex);
                UsedNodes(NodeIndex) = [];
                CurrentPath(end) = [];
            end
        end
        mmm = 0;
    else
        UsedNodes(end) = [];
        CurrentPath(end) = [];
    end 
end

Cycles = CycleList; 
end

function [NewAdjacency] = ZeroOut(CurrentPath, Adjacency)

NewAdjacency = Adjacency;
CurrentPath(1) = [];
CurrentPath(1) = [];
CurrentPath(end) = [];
CurrentPath(end) = [];
GraphSize = max(size(Adjacency));

Z = zeros(GraphSize, 1);
for i = 1:length(CurrentPath)
    NewAdjacency(CurrentPath(i),:) = Z;
    NewAdjacency(:,CurrentPath(i)) = Z;
end
end

