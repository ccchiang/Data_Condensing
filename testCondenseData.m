format long;
dim = 1;
[frames cutpos] = GenFrames(50, dim, 0.1);
for i=1:dim
    frames(:,i) = 50*(frames(:,i)-min(frames(:,i)))/(max(frames(:,i)-min(frames(:,i))));
end
%data = load('frames.txt');
[G P] = Condense(frames, 1.5, 0.2, 0.02);
durs = TracePath(G, P)