function Subject_Iq(ResultFile,NumSub,Coeff_AllSub,sR,Contruns,coeff,isComp,Cont)
% PURPOSE
% Subject specific clustering results
%
% INPUTS
% ResultFile:      (array) the directory that saved ICA reuslts
% NumSub:          (scalar) the number of subjects  
% Coeff_AllSub:    (string) coefficient matrix of dimension reduction
% sR:              (struct) the struct with ICA results

% ver 1.0 060720 GQ

SimS = abs(corrw(icassoGet(sR,'W'),icassoGet(sR,'dewhitemat')));
for isSub = 1:NumSub
    SubsR = sR;
    for isRun = 1:Contruns
        disp(['Subject#' num2str(isSub) ' Calculate features ' num2str(isRun) ' / ' num2str(Contruns)])
        W = sR.W{1,isRun};
        S = W*sR.signal;
        A = sR.A{isRun};
        SubTemporal = squeeze(Coeff_AllSub(:,1:Cont(isSub),isSub))*...
            coeff(sum(Cont(1:isSub-1))+1:sum(Cont(1:isSub)),1:isComp)/W;
        Temporal(:,(isRun-1)*isComp+1:isRun*isComp) = SubTemporal;
        SubsR.A(isRun) = {SubTemporal};
    end
    Feature = rownorm(Temporal');
    SimA = Feature*Feature';
    Similarity = SimA.*SimS;
    %% Cluster of matrix
    load([ResultFile filesep 'Component_S']);
    [iq,A,W,S,SubsR] = f_Cluster_Feature(Similarity,SubsR,isComp,S);
    Temporal = squeeze(Coeff_AllSub(:,1:Cont(isSub),isSub))*...
        coeff(sum(Cont(1:isSub-1))+1:sum(Cont(1:isSub)),1:isComp)/W;
    save([ResultFile filesep 'Matrix_Temporal_Iq_Sub#' num2str(isSub)],'iq','-v7.3');     save([ResultFile filesep 'Matrix_Temporal_sR_Sub#' num2str(isSub)],'SubsR','-v7.3');
    save([ResultFile filesep 'Temporal_Sub#' num2str(isSub)],'Temporal','-v7.3');clear Temporal;
    Iq_AllSub_Temporal(:,isSub) = iq;
end
save([ResultFile filesep 'Iq_AllSub_Temporal'],'Iq_AllSub_Temporal','-v7.3');
clear Temporal;
clear Iq_AllSub_Temporal;

end