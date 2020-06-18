function [Matrix_iq,step,sR,Contruns,coeff] = ICA_decomposition_tensor_clustering(Data_AllSub_R95,isComp,runs,OutPutdir,Method)
% PURPOSE
% ICA decomposition and stability analysis with tensor clustering
%
% INPUTS
% Data_AllSub_R95: (array) the data to be decomposed
% isComp:          (vector) the model order to be selected
% runs:            (scalar) the number of runs for each model order  
% OutPutdir:       (string) the directory for results to be saved
% Method:          (string) the ICA algorithm to be used: 'FastICA'/'InfomaxICA'

% ver 1.0 060720 GQ
ResultFile = [OutPutdir filesep 'MO_' num2str(isComp)];
[coeff,score,latent] = pca(Data_AllSub_R95);
save([OutPutdir filesep 'PCA.mat'],'coeff','score','latent','-v7.3');
%% ICA decomposition
switch Method
    case 'FastICA'
        MaxIteration = 100;
        [sR,step]=icassoEst('both', score(:,1:isComp)',runs, 'lastEig', isComp, 'g','tanh', ...
            'approach', 'symm');
    case 'InfomaxICA'
        MaxIteration = 512;
        [sR step]=icassoEst_infomaxICA('both',score(:,1:isComp)',runs, 'lastEig', isComp, 'g', 'tanh', ...
            'approach', 'symm');
    otherwise
        disp('Unknow method.');
end
%%
Contruns = sum(step<MaxIteration);
New_sR.mode = sR.mode;
New_sR.signal = sR.signal;
New_sR.fasticaoptions = sR.fasticaoptions;
New_sR.index = sR.index(1:Contruns*isComp,:);
New_sR.A = sR.A(step<MaxIteration);
New_sR.W = sR.W(step<MaxIteration);
New_sR.whiteningMatrix = sR.whiteningMatrix;
New_sR.dewhiteningMatrix = sR.dewhiteningMatrix;
New_sR.cluster = sR.cluster;
New_sR.projection = sR.projection;
sR = New_sR;
%% Cluster of component matrix
sR=icassoCluster(sR,0,[],'strategy','AL','simfcn','abscorr','s2d','sim2dis','L','rdim');
sR=icassoProjection(sR,'cca','s2d','sqrtsim2dis','epochs',75);
[iq,A,W,S]=icassoShow(sR,'L',isComp,'colorlimit',[.8 .9]);
save([ResultFile filesep 'Component_A'],'A','-v7.3');
save([ResultFile filesep 'Component_W'],'W','-v7.3');
save([ResultFile filesep 'Component_iq'],'iq','-v7.3');
save([ResultFile filesep 'Component_S'],'S','-v7.3');
save([ResultFile filesep 'Component_sR'],'sR','-v7.3');
save([ResultFile filesep 'Component_step'],'step','-v7.3');
%% Cluster of coefficient matrix
for isRun = 1:Contruns
    disp(['Calculate features ' num2str(isRun) ' / ' num2str(runs)])
    W = sR.W{isRun};
    S = W*sR.signal;
    Temporal(:,(isRun-1)*isComp+1:isRun*isComp) = coeff(:,1:isComp)/W;
end
Feature = rownorm(Temporal');
SimA = Feature*Feature';
[iq,A,W,S,sR] = f_Cluster_Feature(SimA,sR,isComp,S);
save([ResultFile filesep 'Coefficient_iq'],'iq','-v7.3');
save([ResultFile filesep 'Coefficient_sR'],'sR','-v7.3');
clear Temporal
%% Cluster of matrix
load([ResultFile filesep 'Component_S.mat']);
SimS = abs(corrw(icassoGet(sR,'W'),icassoGet(sR,'dewhitemat')));
Similarity = SimA.*SimS;
[iq,A,W,S,sR] = f_Cluster_Feature(Similarity,sR,isComp,S);
save([ResultFile filesep 'Matrix_iq'],'iq','-v7.3');Matrix_iq = iq;
save([ResultFile filesep 'Matrix_sR'],'sR','-v7.3');
end