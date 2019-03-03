vnarc1= vecnorm(arc1);
vnarc2=vecnorm(arc2);
vnarc3=vecnorm(arc3);
vnarc4=vecnorm(arc4);
vnarc5=vecnorm(arc5);
vnarc6=vecnorm(arc6);
vnarc7=vecnorm(arc7);
vnarc8=vecnorm(arc8);
vnarc9=vecnorm(arc9);
vnarc10= vecnorm(arc10);
vnarc11= vecnorm(arc11);
vnarc12= vecnorm(arc12);%
% GETARFEAT Gets the AR feature (autoregressive).
%
% feat = getarfeat(x,order,winsize,wininc,datawin,dispstatus)
%
% Author Adrian Chan
%
% This function computes the AR feature of the signals in x,
% which are stored in columns.
%
% The signals in x are divided into multiple windows of size
% winsize and the windows are space wininc apart.
%
% AR model determined using the Levinson-Durbin algorithm.
%
% Inputs
%    x: 		columns of signals
%    order:     order of AR model
%    winsize:	window size (length of x)
%    wininc:	spacing of the windows (winsize)
%    datawin:   window for data (e.g. Hamming, default rectangular)
%               must have dimensions of (winsize,1)
%    dispstatus:zero for no waitbar (default)
%
% Outputs
%    feat:     AR value in a 2 dimensional matrix
%              dim1 window
%              dim2 feature
%                   (AR coefficients from the next signal is to the right of the previous signal)
%
% Modifications
% 05/01/14 AC Change feat output so that dim1 is window and dim2 is feature
% 06/06/23 AC First created.

function feat = getarfeat(x,order,winsize,wininc,datawin,dispstatus)

if nargin < 6
    if nargin < 5
        if nargin < 4
            if nargin < 3
                winsize = size(x,1);
            end
            wininc = winsize;
        end
        datawin = ones(winsize,1);
    end
    dispstatus = 0;
end

datasize = size(x,1);
Nsignals = size(x,2);
numwin = floor((datasize - winsize)/wininc)+1;

% allocate memory
feat = zeros(numwin,Nsignals*order);

if dispstatus
    h = waitbar(0,'Computing AR features...');
end

st = 1;
en = winsize;

for i = 1:numwin
   if dispstatus
       waitbar(i/numwin);
   end
   curwin = x(st:en,:).*repmat(datawin,1,Nsignals);

   cur_xlpc = real(lpc(curwin,order)');
   cur_xlpc = cur_xlpc(2:(order+1),:);
   feat(i,:) = reshape(cur_xlpc,Nsignals*order,1)';
   
   st = st + wininc;
   en = en + wininc;
end

if dispstatus
    close(h)
end
