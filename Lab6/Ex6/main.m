input_file = fopen('data.txt','r');
sequence = fscanf(input_file, '%s');
k = 9;
[seq, freq] = CountMostFrequent(cellstr(sequence'), k);
fprintf("The most frequent %d-digit sequence is [ %s ] and appears %d times in this segment.\n", k, char(seq), freq{1} );

