function y=PlotSpringF(handles)
%  Plots damped-driven harmonic oscillator--a mass on a spring
%  
%  The mass is attached to one end of a spring and the other end
%  is driven sinusoidally.
%  Time marching is done using the Verlet method.
%   Evaluates force by calling the function:
%               F= Fspringdamp(y, v, m, k, y0, gamma)
%    where position of mass m is y, velocity is v, spring constant is k
%              position of other end of spring is y0, and damping
%              factor is gamma.
%
%   use SI units throughout
%                               Author: CSL

%% Get parameters from  GUI
% --  initial velocity (m/s)
vyinit=str2double(handles.vy0Text.String);

% --  initial displacement from 0 (m)
yinit=str2double(handles.y0Text.String);

% --  interval for speed slider
Nstride=round(handles.Nslider.Value);

% --  number of time points
Nt=round(str2double(handles.Ntext.String));

% -- get number of periods
Nper=str2double(handles.TimeText.String);

%  --  spring constant (N/m)
kspring=str2double(handles.SpringconstText.String);

%  --  mass (kg)
mass=str2double(handles.MassText.String);

%  --  gamma (N s/m)
gamma=str2double(handles.DampingText.String);

%  --  driver amplitude (m)
ydmax=str2double(handles.DriverAmpText.String);

%  --  driver frequency ratio
%     slider min/max = [-1, 1]
freqratio=handles.FreqSlider.Value;

%%  derived  quantities
%  natural frequency of oscillator (rad/sec)
omega=sqrt(kspring/mass);

% driver frequency
domega=omega+omega*freqratio;
Tper=2*pi/omega;

% Final time of calculation
Tf=Nper*Tper;

%% initialize arrays
t=linspace(0,Tf,Nt);
y=zeros(1,Nt);
vy=zeros(1,Nt);
KE=zeros(1,Nt);
PE=zeros(1,Nt);
TotE=zeros(1,Nt);

% sinusoidal driver 
%    driven end of spring is assumed initially at y=0
%    and oscillates with amplidutde ydmax
y0=ydmax*sin(domega*t);

y(1)=yinit;
vy(1)=vyinit;
dt=t(2)-t(1);

%% main loop for time marching with Verlet
hwait=waitbar(0,'Calculating...');
for k=1:Nt-1
     waitbar(k/Nt,hwait);

     Fold=Fspringdamp(y(k),vy(k),mass,kspring,y0(k),gamma);
     vyhalf=vy(k)+0.5*dt*Fold/mass; 
     y(k+1)=y(k)+dt*vyhalf;
     Fnew=Fspringdamp(y(k+1),vyhalf,mass,kspring,y0(k+1),gamma);
     vy(k+1)=vyhalf+0.5*dt*Fnew/mass;
     F(k)=Fnew;

end
close(hwait);

%% calculate energies
KE=0.5*mass*vy.^2;
PE=0.5*kspring*(y-y0).^2;
TotE=PE+KE;

%% ------------- Plot results
ymax=max([max(y0),max(y)]);
ymin=min([min(y0),min(y)]);
vmax=max(vy);
vmin=min(vy);
Emax=max(TotE);

it=0;
done=false;
Nstride=getappdata(gcf,'Nstride');
while ~done
    % increment and check on stop/start button
    it=it+Nstride;

    % animation plot
    hposaxes=handles.PositionAxes;
    plot(hposaxes,[0 0],[y0(it), y(it)],...
        0, y(it),'o', 0, y0(it),'+');
    axis(hposaxes,[-0.5 0.5 1.05*ymin 1.05*ymax])
    ylabel(hposaxes,'y(m)');
    
    % axes 1: energy plot
    haxes1=handles.MyAxes1;
    switch handles.MyAxes1Popup.Value
        case 1
            plot(haxes1,t(1:it),KE(1:it),'r',...
                t(1:it),PE(1:it),'b',...
                t(1:it),TotE(1:it),'k');
            axis(haxes1,[0 Tf 0 1.1*Emax])
            ylabel(haxes1,'Energy(J)');
            xlabel(haxes1,'t(s)');
            grid(haxes1,'on');
            drawnow;
        case 2
            plot(haxes1, y(1:it),PE(1:it),'g',...
                y(it),TotE(it),'ro',...
                y(1:it),TotE(1:it),'k',...
                [y(it),y(it)],[PE(it),TotE(it)],'r');
            axis(haxes1,[1.1*ymin 1.1*ymax 0 1.1*Emax])
            ylabel(haxes1,'Energy(J)');
            xlabel(haxes1,'y(m)');
            drawnow;            
        otherwise
            disp('unrecognized option--popup1');
    end
    
    % axes 2: position, velocity, phase plot
    haxes2=handles.MyAxes2;
    switch handles.MyAxes2Popup.Value
        case 1
            plot(haxes2,t(1:it),y(1:it),'b')
            axis(haxes2,[0 Tf 1.1*ymin 1.1*ymax])
            ylabel(haxes2,'y(m)');
            xlabel(haxes2,'t(s)');
            grid(haxes2,'on');
            drawnow;
        case 2
            plot(haxes2,t(1:it),vy(1:it),'b')
            axis(haxes2,[0 Tf -1.1*vmax 1.1*vmax])
            ylabel(haxes2,'Velocity(m/s)');
            xlabel(haxes2,'t(s)');
            grid(haxes2,'on');
            drawnow;
        case 3
            plot(haxes2,y(1:it),vy(1:it),'b')
            axis(haxes2,[1.1*ymin 1.1*ymax 1.1*vmin 1.1*vmax])
            ylabel(haxes2,'Velocity(m/s)');
            xlabel(haxes2,'y(m)');
            grid(haxes2,'on');
            drawnow;
        otherwise
            disp('unrecognized option--popup2');
    end
    
    
    % -- update interval for speed slider
    Nstride=getappdata(gcf,'Nstride');
    
    % check for finished loop
    %   logical IsRunning might have been switch by Start/Stop
    IsRunning=getappdata(gcf,'IsRunning');
    done= (it > Nt-Nstride) || ~IsRunning;
    
end

handles.StartButton.String='Start';
setappdata(gcf,'IsRunning',false);

