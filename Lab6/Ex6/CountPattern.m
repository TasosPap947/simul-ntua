function [counts] = CountPattern(target,pattern)
counts = count(lower(target), lower(pattern));
end

