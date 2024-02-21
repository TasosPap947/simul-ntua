function [counts] = FindPattern(target,pattern)
counts = count(lower(target), lower(pattern));
end