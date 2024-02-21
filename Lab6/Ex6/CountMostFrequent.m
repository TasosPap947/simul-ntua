function [mostFreq, occurs] = CountMostFrequent(target,ngramLen)
%cell input
ngrams = {};
for i = 1:(length(target) - ngramLen)
ngrams{i} = char(target(i:(i + ngramLen)));
end
ngrams = cellfun(@(x) char(x'), ngrams, 'UniformOutput', false)';
unqNgrams = unique(ngrams,'stable');
counts = cellfun(@(x) sum(ismember(ngrams,x)),unqNgrams, 'UniformOutput', false);
freqTable = table( unqNgrams, counts ,'VariableNames', {'Pattern', 'Frequency'});
freqTable = sortrows(freqTable,{'Frequency'},{'descend'});
head(freqTable, 10)
mostFreq = freqTable.Pattern(1);
occurs =freqTable.Frequency(1);
end