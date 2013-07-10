function durs = TracePath(G, S)
val = diag(fliplr(G));
L = length(val);
best_t = find(val==min(val));
best_n = L - best_t;
stop = 0;
durs = [best_t best_t+best_n];
while 1
    start = S(best_t, best_n+1).t;
    stop = start + S(best_t, best_n+1).n;
    if (start==-1)
        break;
    else
        durs = [start stop; durs];
        s = S(best_t, best_n+1);
        best_t = s.t;
        best_n = s.n;
    end
end