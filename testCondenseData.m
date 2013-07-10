data = randi([5 10], 50, 1);
dim = 1;
for i=1:dim
    data(:,i) = 50*(data(:,i)-min(data(:,i)))/(max(data(:,i)-min(data(:,i))));
end
data = load('frames.txt');
[G P] = Condense(data, 1, 0.2, 0);
durs = TracePath(G, P)