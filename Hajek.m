function [accuracy, runtime] =  Hajek(n,p,q) 

%   Hajek.m  
%   Quick implementation of sdp proposed in "Achieving Exact Cluster
%   Recovery Threshold via SDP" by Hajek et al.
%   Input parameters: 
%         n: 2x1 vector containing the cardinalities of the two clusters 
%         p: intra-cluster probability
%         q: inter-cluster probability
%   Output parameters:
%      accuracy
%      runtime 
% Copyright (C) 2017 Charalampos E. Tsourakakis 

%% generate planted partition graph 

% by default the sizes of the two clusters are equal 
if length(n) == 1 
    n(2) = n(1);
end 

N = n(1)+n(2);
labels = ones(N,1); 
sigma = labels; 
sigma(1:n(1))=-1;
%Groundtruth = sigma*sigma';
labels(1:n(1))=2; 
Psi = [p,q;q,p];


A = zeros(N); %<- expected 
for i = 1 : N
    for j = i+1 : N
        A(i,j) = Psi(labels(i),labels(j));
    end
end
A=A+A';

Abar = rand(N)<=A;%<- adjacency matrix, rounding result of A
Abar = triu(Abar,1);
Abar= Abar+Abar'; 

%% solve the SDP proposed by Hajek et al. 
tic
cvx_begin sdp 
variable Y(N,N) symmetric; 
dual variable a;
dual variable b;
dual variable c;
maximize ( trace(Abar*Y) ); 
subject to
a : Y >= 0;
b : diag(Y) == 1;
c : trace(Y*ones(N,N))==0;
cvx_end
runtime =toc;
optval = cvx_optval;

mistakes =  min( length(find( sigma'+sign(Y(1,:)) ~= 0)), length(find( sigma'-sign(Y(1,:)) ~= 0))); 
accuracy = 1-mistakes/N;
