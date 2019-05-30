import numpy as np

def zerout(CurrentPath, Adjacency):
    NewAdjacency = Adjacency
    CurrentPath[0] = []
    CurrentPath[0] = []
    CurrentPath[-1] = []
    CurrentPath[-1] = []
    GraphSize = max(size(Adjacency))
    Z = np.zeros([GraphSize, 1])
    for i in range(len(CurrentPath)):
        NewAdjacency[CurrentPath[i],:] = Z
        NewAdjacency[:,CurrentPath[i]] = Z
    return NewAdjacency


def zeoc(Adjacency, Source, LengthOfCycle, CurrentPath=0, UsedNodes=0, iteration=0, CurrentVertex=0):
    global CycleList
    CycleList = []
    if iteration == 0:
        CurrentVertex = Source
        UsedNodes = [Source]
        CurrentPath = [Source]
        iteration += 1
        zeoc(Adjacency, Source,  LengthOfCycle, CurrentPath, UsedNodes, iteration, CurrentVertex)
    else:
        print(CurrentPath)
        if iteration == 1:
            del UsedNodes[0]
        iteration += 1
        if len(CurrentPath) == LengthOfCycle and CurrentPath[-1] == Source:
            CycleList.append(CurrentPath)
            Cycle = CurrentPath
            Adjacency = ZeroOut(CurrentPath, Adjacency)
        elif len(CurrentPath) < LengthOfCycle:
            CurrentNeighbors = Adjacency[int(CurrentVertex),:]
            print(CurrentNeighbors) # need to fix this line
            for i in range(len(CurrentNeighbors)):
                Used = False
                CurrentVertex = CurrentNeighbors[i]
                for j in range(len(UsedNodes)):
                    if CurrentNeighbors[i] == UsedNodes[j]:
                        Used = True
                if not Used:
                    CurrentPath.append(int(CurrentVertex))
                    UsedNodes.append(int(CurrentVertex))
                    NodeIndex = len(UsedNodes)
                    Cycles, Adjacency = zeoc(Adjacency, Source, LengthOfCycle, CurrentPath, UsedNodes, iteration, CurrentVertex)
                    del UsedNodes[NodeIndex-1]
                    del CurrentPath[-1]
            mmm = 0
        else:
            del UsedNodes[-1]
            del CurrentPath[-1]
    Cycles = CycleList
    return Cycles, Adjacency



m = np.loadtxt('largecell.csv', delimiter=',')
source = 45
ring, m = zeoc(m, source, 9)
print(ring)
