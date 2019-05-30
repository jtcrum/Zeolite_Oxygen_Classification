clear all
close all
clc

source = 45;
m = csvread('largecell.csv');
Class = [];

% 4 member rings
[ring, m] = ZeoliteClassifierFour(source,0,0,m,9,0,0);
if isempty(ring)==0
    [n,q] = size(ring);
    ring(n,:)=[];
    ring(n-1,:)=[];
    ring(1,:)=[];
    ring(1,:)=[];

    for i = 1:q
        Class = [Class,(n-1)/2];
        m = ZeroOutStuff(m,ring(:,i));
    end
end
clear global CycleList

% 6 member rings
[ring, m] = ZeoliteClassifierFour(source,0,0,m,13,0,0);
if isempty(ring)==0
    [n,q] = size(ring);
    ring(n,:)=[];
    ring(n-1,:)=[];
    ring(1,:)=[];
    ring(1,:)=[];
    for i = 1:q
        Class = [Class,(n-1)/2];
        m = ZeroOutStuff(m,ring(:,i));
    end
end
m = ZeroOutStuff(m,ring);
clear global CycleList

% 8 member rings
[ring, m] = ZeoliteClassifierFour(source,0,0,m,17,0,0);
[n,q] = size(ring);
for i = 1:q
    Class = [Class,(n-1)/2];
end
Class = sort(Class,'descend')