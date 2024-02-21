% Contents of physbe directory
%
% physbe.mdl  - The PHYSBE model for Simulink 2.0
%               (type physbe at the MATLAB command line)
% pctrl2.m    - The PHYSBE GUI. It will be opened automatically by physbe.mdl.
% showv.m     - A post-processing script that plots Internal Pressure, 
%               Input Pressure, and Volume data for all nine PHYSBE subsystems
%               Requires the following variables to be in the workspace:
%                  tout                  - from SIMULINK parameter settings
%                  pressure, pin, volume - from To Workspace blocks in PHYSBE
%
% physbe_setting.mat - A MAT-file containing all the parameters for the
%                      PHYSBE model and the pctrl2 interface.
%
%
%initfig.m    - function to initialize plots
%
%lineplot.m   - additional plotting function
%
%
%
%
