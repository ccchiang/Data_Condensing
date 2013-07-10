data = randi([1 10],50,1);
[S G] = Condense(data);
durs = TracePath(G, S);