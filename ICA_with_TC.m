function varargout = ICA_with_TC(varargin)
% ICA_WITH_TC MATLAB code for ICA_with_TC.fig
%      ICA_WITH_TC, by itself, creates a new ICA_WITH_TC or raises the existing
%      singleton*.
%
%      H = ICA_WITH_TC returns the handle to a new ICA_WITH_TC or the handle to
%      the existing singleton*.
%
%      ICA_WITH_TC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ICA_WITH_TC.M with the given input arguments.
%
%      ICA_WITH_TC('Property','Value',...) creates a new ICA_WITH_TC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ICA_with_TC_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ICA_with_TC_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ICA_with_TC

% Last Modified by GUIDE v2.5 17-Jun-2020 15:43:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ICA_with_TC_OpeningFcn, ...
                   'gui_OutputFcn',  @ICA_with_TC_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ICA_with_TC is made visible.
function ICA_with_TC_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ICA_with_TC (see VARARGIN)

% Choose default command line output for ICA_with_TC
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ICA_with_TC wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ICA_with_TC_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Workingdirectoryedit_Callback(hObject, eventdata, handles)
% hObject    handle to Workingdirectoryedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Workingdirectory = handles.Workingdirectoryedit.String;
if ~exist(Workingdirectory)
    mkdir(Workingdirectory);
end

try
    cd(Workingdirectory);
catch
    warndlg([Workingdirectory ' is not exist or not a directory'],'Working directory');
end

% Hints: get(hObject,'String') returns contents of Workingdirectoryedit as text
%        str2double(get(hObject,'String')) returns contents of Workingdirectoryedit as a double


% --- Executes during object creation, after setting all properties.
function Workingdirectoryedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Workingdirectoryedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in WorkingdirectoryButton.
function WorkingdirectoryButton_Callback(hObject, eventdata, handles)
% hObject    handle to WorkingdirectoryButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.figure1.Visible = 'off';
Workingdirectory = uigetdir(pwd,'Working directory');
try
    cd(Workingdirectory);
    handles.Workingdirectoryedit.String = Workingdirectory;
catch
    warndlg([Workingdirectory ' is not exist or not a directory'],'Working directory')
end
handles.figure1.Visible = 'on';



function OutputdirectoryEdit_Callback(hObject, eventdata, handles)
% hObject    handle to OutputdirectoryEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OutputdirectoryEdit as text
%        str2double(get(hObject,'String')) returns contents of OutputdirectoryEdit as a double


% --- Executes during object creation, after setting all properties.
function OutputdirectoryEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OutputdirectoryEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OutputdirectoryButton.
function OutputdirectoryButton_Callback(hObject, eventdata, handles)
% hObject    handle to OutputdirectoryButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.figure1.Visible = 'off';
Outputdirectory = uigetdir(pwd,'Output directory');
handles.OutputdirectoryEdit.String = Outputdirectory;
handles.figure1.Visible = 'on';

% --- Executes on button press in LoadDataButton.
function LoadDataButton_Callback(hObject, eventdata, handles)
% hObject    handle to LoadDataButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.figure1.Visible = 'off';
[filename,filepath]=uigetfile('*.nii',...
    'Select data File','MultiSelect','on');
Items = handles.SubjectList.String;
if iscell(filename)
    for isfile = 1:length(filename)
        Items = [Items {[filepath filename{isfile}]}];
    end
    handles.SubjectList.String = Items;
end
handles.figure1.Visible = 'on';

% --- Executes on selection change in SubjectList.
function SubjectList_Callback(hObject, eventdata, handles)
% hObject    handle to SubjectList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SubjectList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SubjectList


% --- Executes during object creation, after setting all properties.
function SubjectList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SubjectList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MaskEdit_Callback(hObject, eventdata, handles)
% hObject    handle to MaskEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MaskEdit as text
%        str2double(get(hObject,'String')) returns contents of MaskEdit as a double


% --- Executes during object creation, after setting all properties.
function MaskEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MaskEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in MaskButton.
function MaskButton_Callback(hObject, eventdata, handles)
% hObject    handle to MaskButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.figure1.Visible = 'off';
[filename,filepath]=uigetfile('*.nii',...
    'Select Mask File','MultiSelect','off');
if ischar(filename)
    handles.MaskEdit.String = [filepath filename];
end
handles.figure1.Visible = 'on';

% --- Executes on selection change in Algorithm.
function Algorithm_Callback(hObject, eventdata, handles)
% hObject    handle to Algorithm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Algorithm contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Algorithm


% --- Executes during object creation, after setting all properties.
function Algorithm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Algorithm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RunsEdit_Callback(hObject, eventdata, handles)
% hObject    handle to RunsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RunsEdit as text
%        str2double(get(hObject,'String')) returns contents of RunsEdit as a double


% --- Executes during object creation, after setting all properties.
function RunsEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RunsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ModelOrderLowEdit_Callback(hObject, eventdata, handles)
% hObject    handle to ModelOrderLowEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ModelOrderLowEdit as text
%        str2double(get(hObject,'String')) returns contents of ModelOrderLowEdit as a double


% --- Executes during object creation, after setting all properties.
function ModelOrderLowEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ModelOrderLowEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ModelOrderHighEdit_Callback(hObject, eventdata, handles)
% hObject    handle to ModelOrderHighEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ModelOrderHighEdit as text
%        str2double(get(hObject,'String')) returns contents of ModelOrderHighEdit as a double


% --- Executes during object creation, after setting all properties.
function ModelOrderHighEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ModelOrderHighEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in RunButton.
function RunButton_Callback(hObject, eventdata, handles)
% hObject    handle to RunButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SourceFile = handles.SubjectList.String;
OutPutdir = handles.OutputdirectoryEdit.String;
runs = str2double(handles.RunsEdit.String);
Comp = str2double(handles.ModelOrderLowEdit.String):str2double(handles.ModelOrderHighEdit.String);
MethodValue = handles.Algorithm.Value;
switch MethodValue
    case 1
        Method = 'FastICA';
        MaxIteration = 100;
    case 2
        Method = 'InfomaxICA';
        MaxIteration = 512;
    otherwise
        disp('Unknow method.');
end
Mask = handles.MaskEdit.String;
%% ICA decomposition
%handles.figure1.Position = [100 100 900 537];
handles.RunButton.BackgroundColor = [1 1 0];
handles.RunButton.String = 'Running';drawnow;
try
    clc;
    [Data_AllSub_R95,Coeff_AllSub,Cont]= DimensionReduction(SourceFile,Mask,OutPutdir);
    for isComp = Comp
        ResultFile = [OutPutdir filesep 'MO_' num2str(isComp)];
        if ~exist(ResultFile,'dir')
            mkdir(ResultFile);
        end
        [Matrix_iq, steps,sR,Contruns,coeff]= ICA_decomposition_tensor_clustering(Data_AllSub_R95,isComp,runs,OutPutdir,Method);
        Subject_Iq(ResultFile,length(SourceFile),Coeff_AllSub,sR,Contruns,coeff,isComp,Cont);
        Parameter(isComp,1) = nanmean(Matrix_iq);
        Parameter(isComp,2) = nanstd(Matrix_iq);
        Parameter(isComp,3) = size(steps(steps<MaxIteration),2);
        plot(handles.Stability,Parameter(:,1),'-+m','linewidth',2);%hold(handles.Stability,'on');
        ylim(handles.Stability,[-0.1 1.1]);
        xlim(handles.Stability,[min(Comp) max(Comp)]);
        xlabel(handles.Stability,'Model order','fontsize',14);
        ylabel(handles.Stability,'Stability index','fontsize',14);
        title(handles.Stability,'Stability','fontsize',14);drawnow;
        %plot(handles.Stability,Parameter(:,2),'-*r','linewidth',2);hold(handles.Stability,'off'); drawnow;
        plot(handles.Convergence,Parameter(:,3),'-v','linewidth',2);
        ylim(handles.Convergence,[-5 runs+5]);
        xlim(handles.Convergence,[min(Comp) max(Comp)]);
        xlabel(handles.Convergence,'Model order','fontsize',14);
        ylabel(handles.Convergence,'Number of converged runs','fontsize',14);
        title(handles.Convergence,'Convergence','fontsize',14);drawnow;
    end
    handles.RunButton.BackgroundColor = [0 1 0];
    handles.RunButton.String = 'Done';drawnow;
catch
    handles.RunButton.BackgroundColor = [1 0 0];
    handles.RunButton.String = 'Error';drawnow;
    
end

% --- Executes on button press in ExitButton.
function ExitButton_Callback(hObject, eventdata, handles)
% hObject    handle to ExitButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 closereq(); 


function SelectedModelOrder_Callback(hObject, eventdata, handles)
% hObject    handle to SelectedModelOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SelectedModelOrder as text
%        str2double(get(hObject,'String')) returns contents of SelectedModelOrder as a double


% --- Executes during object creation, after setting all properties.
function SelectedModelOrder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SelectedModelOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SaveButton.
function SaveButton_Callback(hObject, eventdata, handles)
% hObject    handle to SaveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
isModelOrder = str2double(handles.SelectedModelOrder.String);
OutPutdir = handles.OutputdirectoryEdit.String;
ResultFile = [OutPutdir filesep 'MO_' num2str(isModelOrder)];
tmp = load([ResultFile filesep 'Component_S.mat']);
S = tmp.S;
Mask = handles.MaskEdit.String;
img = load_nii(Mask);
Mask = img.img;
for isComp = 1:isModelOrder
    tmp = zeros(size(Mask));
    tmp(Mask==1) = S(isComp,:);
    img.img = tmp;
    save_nii(img,[OutPutdir filesep 'Spatial_MO#' num2str(isModelOrder) '_Comp#' num2str(isComp) '.nii']);
end
SourceFile = handles.SubjectList.String;
NumSub = length(SourceFile);
for isSub = 1:NumSub
    tmp = load([ResultFile filesep 'Temporal_Sub#' num2str(isSub) '.mat']);
    Temporal = tmp.Temporal;
    Ind1 = strfind(SourceFile{isSub},filesep);
    Ind2 = strfind(SourceFile{isSub},'.');
    SubName = SourceFile{isSub}(Ind1(end)+1:Ind2(end)-1);
    save([OutPutdir filesep 'Temporal_MO#' num2str(isModelOrder) '_' SubName],'Temporal','-v7.3');
end
msgbox([{'Your results have been successfully saved in:'} {OutPutdir}],'Congratulations!');
