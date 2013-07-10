function [ds dn dd D S G N] = Condense(data)
L =  size(data, 1);
dim = size(data, 2);
ds = zeros(L, L);
dd = zeros(L, L, L);
dn = zeros(L, L);
N = zeros(L, L);
D = zeros(L, L);
G = 99999999*ones(L,L);
for ti = 1:L
    for ni = 0:L-ti
        if ni==0
            ds(ti,ni+1) = 0;
        else
            ds(ti,ni+1) = trace(cov(data(ti:ti+ni,:)).^0.5)/dim;
        end
        dn(ti,ni+1) = 0/double(ni+1);
        tj = ti+1;
        for nj = 0:L-tj
            d = mean(data(ti:ti+ni,:))-mean(data(tj:tj+nj,:));
            dd(ti,ni+1,nj+1) = sqrt(d*d');
        end
        if ti==1
            D(ti,ni+1) = ds(ti,ni+1)+1;%dn(ti,ni+1);
            G(ti,ni+1) = D(ti,ni+1);
            S(ti,ni+1).t = -1;
            S(ti,ni+1).n = -1;
            N(ti,ni+1) = 1;
        end
    end
end
for ti = 1:L
    for ni = 0:L-ti
        tj = ti + ni + 1;
        for nj = 0:L-tj
            local_cost = ds(tj,nj+1);%dn(tj,nj+1);%-dd(ti,ni+1,nj+1);
            tmp_global_cost = (D(ti,ni+1)+local_cost)/(N(ti,ni+1)+1)+0.01*(N(ti,ni+1)+1);
            if G(tj,nj+1)>tmp_global_cost
                S(tj,nj+1).t = ti;
                S(tj,nj+1).n = ni+1;
                D(tj,nj+1) = D(ti,ni+1)+local_cost;
                G(tj,nj+1) = tmp_global_cost;
                N(tj,nj+1) = N(ti,ni+1)+1;
            end
        end
    end
end