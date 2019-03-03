X = table2array(E1_FVTwin(:,181:190));
y = table2array(E1_FVTwin(:,221));
c = cvpartition(y,'k',10);
opts = statset('display','iter');
fun = @(XT,yT,Xt,yt)...
      (sum(~strcmp(yt,classify(Xt,XT,yT,'diagquadratic '))));
[fs,history] = sequentialfs(fun,X,y,'cv',c,'options',opts)
save E1_RMSSFS.mat fs 