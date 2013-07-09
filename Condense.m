function out = Condense(data)
L =  size(data, 1);
dim = size(data, 2);
ds = zeros(L, L);
dd = zeros(L, L, L);
dn = zeros(L, L);
D = zeros(L,L);
for ti = 1:L
    for ni = 0:L-ti
        if ni==0
            ds(ti,ni+1) = 0;
        else
            ds(ti,ni+1) = trace(cov(data(ti:ti+ni,:)).^0.5);
        end
        dn(ti,ni+1) = 1/double(ni+1);
        tj = ti+1;
        for nj = 0:L-tj
            d = mean(data(ti:ti+ni,:))-mean(data(tj:tj+nj,:));
            dd(ti,ni,nj) = sqrt(d*d');
        end
    end
end
for ti = 2:L-1
    for ni = 0:L-ti
        for tj = 1:ti-1
            nj = ti-tj-1;
            
            
        end
    end
end