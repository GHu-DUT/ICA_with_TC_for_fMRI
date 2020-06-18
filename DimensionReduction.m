function [Data_AllSub_R95,Coeff_AllSub,Cont] = DimensionReduction(SourceFile,Mask,OutPutdir)
% PURPOSE
% First level dimesion reduction of groupICA
%
% INPUTS
% SourceFile:   (string) the directory of data to be decomposed for each subject
% Mask:         (string) the directory of the mask file
% OutPutdir:    (string) the directory for results to be saved

% ver 1.0 060720 GQ

file = SourceFile;
Data_AllSub_R95 = [];
img = load_nii(Mask);
Mask = img.img;
for isfile = 1:length(file)
    fileName = file{isfile};
    disp(['Loading file name:' fileName]);
    img = load_nii(fileName);
    for isScan = 1:size(img.img,4)
        tmp = img.img(:,:,:,isScan);
        data(:,isScan) = double(tmp(Mask==1));
    end
    data = data-repmat(mean(data'),size(data,2),1)';
    [coeff,score,latent] = pca(data);
    Ratio = 0;
    Cont(isfile) = 0;
    while Ratio<0.95
        Cont(isfile) = Cont(isfile)+1;
        Ratio = sum(latent(1:Cont(isfile)))/sum(latent);
    end
    Coeff_AllSub(:,:,isfile) = coeff;
    Data_AllSub_R95 = [Data_AllSub_R95 score(:,1:Cont(isfile))];
end
mkdir(OutPutdir);
save([OutPutdir filesep 'Data_AllSub_R95'],'Data_AllSub_R95','-v7.3');
save([OutPutdir filesep 'Coeff_AllSub'],'Coeff_AllSub','-v7.3');
save([OutPutdir filesep 'Cont'],'Cont','-v7.3');
end