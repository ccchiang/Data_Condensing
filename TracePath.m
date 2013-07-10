function durs = TracePath(G, P)
val = diag(fliplr(G));
L = length(val);
val(1) = 99999;
best_t = find(val==min(val));
best_n = L - best_t;
stop = 0;
durs = [best_t best_t+best_n];
while 1
    start = P(best_t, best_n+1).t;
    stop = start + P(best_t, best_n+1).n;
    if (start==-1)
        break;
    else
        durs = [start stop; durs];
        p = P(best_t, best_n+1);
        best_t = p.t;
        best_n = p.n;
    end
end