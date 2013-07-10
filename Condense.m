function [G P] = Condense(data, alpha, beta, gamma)
L =  size(data, 1);
dim = size(data, 2);
ds = zeros(L, L);
dd = zeros(L, L, L);
N = zeros(L, L);
S = zeros(L, L);
D = zeros(L, L);
G = 99999999*ones(L,L);
for ti = 1:L
    for ni = 0:L-ti
        if ni==0
            ds(ti,ni+1) = 0;
        else
            ds(ti,ni+1) = (trace(cov(data(ti:ti+ni,:)))/dim).^0.5;
        end
%        tj = ti+ni+1;
%         for nj = 0:L-tj
%             d = max(abs(mean(data(ti:ti+ni,:))-mean(data(tj:tj+nj,:))));
%             dd(ti,ni+1,nj+1) = d;
%         end
        if ti==1
            S(ti,ni+1) = ds(ti,ni+1);%dn(ti,ni+1);
            D(ti,ni+1) = 0;
            G(ti,ni+1) = beta*S(ti,ni+1)+gamma;
            P(ti,ni+1).t = -1;
            P(ti,ni+1).n = -1;
            N(ti,ni+1) = 1;
        end
    end
end
for ti = 1:L
    for ni = 0:L-ti
        tj = ti + ni + 1;
        for nj = 0:L-tj
            local_cost1 = S(ti,ni+1)+ds(tj,nj+1);%dn(tj,nj+1);%-dd(ti,ni+1,nj+1);
            v1 = mean(data(ti:ti+ni,:));
            v2 = mean(data(tj:tj+nj,:));
            dd = max(abs(v1-v2));
            local_cost2 = D(ti,ni+1)+dd;
            n = N(ti,ni+1)+1;
            tmp_global_cost = exp(alpha*local_cost1/n)*exp(-beta*local_cost2/n) ...
                + gamma*n;
            if G(tj,nj+1)>tmp_global_cost
                P(tj,nj+1).t = ti;
                P(tj,nj+1).n = ni;
                S(tj,nj+1) = local_cost1;
                D(tj,nj+1) = local_cost2;
                G(tj,nj+1) = tmp_global_cost;
                N(tj,nj+1) = N(ti,ni+1)+1;
            end
        end
    end
end
a=1;