function varargout = DrivenHarmonicTool(varargin)
% DRIVENHARMONICTOOL M-file for DrivenHarmonicTool.fig
%      DRIVENHARMONICTOOL, by itself, creates a new DRIVENHARMONICTOOL or raises the existing
%      singleton*.
%
%      H = DRIVENHARMONICTOOL returns the handle to a new DRIVENHARMONICTOOL or the handle to
%      the existing singleton*.
%
%      DRIVENHARMONICTOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DRIVENHARMONICTOOL.M with the given input arguments.
%
%      DRIVENHARMONICTOOL('Property','Value',...) creates a new DRIVENHARMONICTOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SpringToolDriven_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DrivenHarmonicTool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help DrivenHarmonicTool

% Last Modified by GUIDE v2.5 17-Jun-2015 21:05:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DrivenHarmonicTool_OpeningFcn, ...
                   'gui_OutputFcn',  @DrivenHarmonicTool_OutputFcn, ...
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




% --- Executes just before DrivenHarmonicTool is made visible.
function DrivenHarmonicTool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DrivenHarmonicTool (see VARARGIN)

% Choose default command line output for DrivenHarmonicTool
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DrivenHarmonicTool wait for user response (see UIRESUME)
% uiwait(handles.figure1);
setappdata(gcf,'IsRunning',false);
handles.StartButton.String='Start';
Nstride=handles.Nslider.Value;
setappdata(gcf,'Nstride',Nstride);

ht=text(0,0.5,'$\omega_{driver}/\omega_0$',...
        'Parent',handles.fLabelText,...
        'Interpreter','latex',...
        'FontSize',14);
axis(handles.fLabelText,'off');

% --- Outputs from this function are returned to the command line.
function varargout = DrivenHarmonicTool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function vy0Text_Callback(hObject, eventdata, handles)
% hObject    handle to vy0Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vy0Text as text
%        str2double(get(hObject,'String')) returns contents of vy0Text as a double


% --- Executes during object creation, after setting all properties.
function vy0Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vy0Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y0Text_Callback(hObject, eventdata, handles)
% hObject    handle to y0Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y0Text as text
%        str2double(get(hObject,'String')) returns contents of y0Text as a double


% --- Executes during object creation, after setting all properties.
function y0Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y0Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in BounceCheckbox.
function BounceCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to BounceCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of BounceCheckbox


% --- Executes on button press in StartButton.
function StartButton_Callback(hObject, eventdata, handles)
% hObject    handle to StartButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% toggle IsRunning variable
IsRunning=getappdata(gcf,'IsRunning');
if IsRunning
    setappdata(gcf,'IsRunning',false);
    handles.StartButton.String='Start';
else
    setappdata(gcf,'IsRunning',true);
    handles.StartButton.String='Stop';
    PlotSpringF(handles);
end




function TimeText_Callback(hObject, eventdata, handles)
% hObject    handle to TimeText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TimeText as text
%        str2double(get(hObject,'String')) returns contents of TimeText as a double


% --- Executes during object creation, after setting all properties.
function TimeText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TimeText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','16');



% --- Executes on slider movement.
function Nslider_Callback(hObject, eventdata, handles)
% hObject    handle to Nslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

N=round(handles.Nslider.Value);
handles.Nslider.Value=N;
setappdata(gcf,'Nstride',N);

% --- Executes during object creation, after setting all properties.
function Nslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Nslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Value',1);


% --- Executes on selection change in MyAxes2Popup.
function MyAxes2Popup_Callback(hObject, eventdata, handles)
% hObject    handle to MyAxes2Popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns MyAxes2Popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MyAxes2Popup


% --- Executes during object creation, after setting all properties.
function MyAxes2Popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MyAxes2Popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in MyAxes1Popup.
function MyAxes1Popup_Callback(hObject, eventdata, handles)
% hObject    handle to MyAxes1Popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns MyAxes1Popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MyAxes1Popup


% --- Executes during object creation, after setting all properties.
function MyAxes1Popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MyAxes1Popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function Ntext_Callback(hObject, eventdata, handles)
% hObject    handle to Ntext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ntext as text
%        str2double(get(hObject,'String')) returns contents of Ntext as a double


% --- Executes during object creation, after setting all properties.
function Ntext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ntext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Topentext_Callback(hObject, eventdata, handles)
% hObject    handle to Topentext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Topentext as text
%        str2double(get(hObject,'String')) returns contents of Topentext as a double


% --- Executes during object creation, after setting all properties.
function Topentext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Topentext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Areaclosedtext_Callback(hObject, eventdata, handles)
% hObject    handle to Areaclosedtext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Areaclosedtext as text
%        str2double(get(hObject,'String')) returns contents of Areaclosedtext as a double


% --- Executes during object creation, after setting all properties.
function Areaclosedtext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Areaclosedtext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function areaopentext_Callback(hObject, eventdata, handles)
% hObject    handle to areaopentext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of areaopentext as text
%        str2double(get(hObject,'String')) returns contents of areaopentext as a double


% --- Executes during object creation, after setting all properties.
function areaopentext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to areaopentext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function SpringconstText_Callback(hObject, eventdata, handles)
% hObject    handle to SpringconstText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SpringconstText as text
%        str2double(get(hObject,'String')) returns contents of SpringconstText as a double


% --- Executes during object creation, after setting all properties.
function SpringconstText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SpringconstText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MassText_Callback(hObject, eventdata, handles)
% hObject    handle to MassText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MassText as text
%        str2double(get(hObject,'String')) returns contents of MassText as a double


% --- Executes during object creation, after setting all properties.
function MassText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MassText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DampingText_Callback(hObject, eventdata, handles)
% hObject    handle to DampingText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DampingText as text
%        str2double(get(hObject,'String')) returns contents of DampingText as a double


% --- Executes during object creation, after setting all properties.
function DampingText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DampingText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on slider movement.
function FreqSlider_Callback(hObject, eventdata, handles)
% hObject    handle to FreqSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

hdfreq=handles.FreqSlider;
freqratio=get(hdfreq,'Value');
hftext=handles.FreqStaticText;
set(hftext,'String',num2str(1+freqratio));

% --- Executes during object creation, after setting all properties.
function FreqSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FreqSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function DriverAmpText_Callback(hObject, eventdata, handles)
% hObject    handle to DriverAmpText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DriverAmpText as text
%        str2double(get(hObject,'String')) returns contents of DriverAmpText as a double


% --- Executes during object creation, after setting all properties.
function DriverAmpText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DriverAmpText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


