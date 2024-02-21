% Filename: pctrl2.m
% Rev.Date: 5/2/97
%
% PCTRL2 is a script that sets all parameters for the SIMULINK 
% model physbe.mdl, as well as generating the PHYSBE Control
% Window, a GUI for changing those parameters. It should not 
% be necessary to excecute PCTRL2 from the command line, as the 
% physbe model should launch it automatically when opened 
% (type "physbe" at the command line to open the physbe model).
%
% Note that while the original PHYSBE Control Window was designed
% using GUIDE, the file has since been rewritten. It now includes
% custom features that made it easier for the author to manage the
% basic, but large array of editable text boxes. 
% If GUIDE is use to change the PHYSBE Control Window, these custom
% features will not be saved along with the new GUI. It is advisable,
% therefore, to make a backup copy of this file before making any
% changes using GUIDE.

% Functions required:
%  initfig - figure initiation utility
% Written by: Kevin Kohrt
% Written on: 11/17/96
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-------------------------------------------------------------------------------
% INITIATE CONTROL FIGURE
%-------------------------------------------------------------------------------
% [a, newflag] = initfig( 'PHYSBE Control Center', 'hidden' );
hFig = findobj( allchild(0), 'Name', 'PHYSBE Control Center' );

% If GUI already exists, bring it to front and escape
if ~isempty(hFig), 
    set(0,'CurrentFigure',hFig);
    return
end

% Time to make a new figure

% Warn user of possible delay
disp('Building PHYSBE interface...')
       
% Set up string to save PHYSBE parameters
phySaveCmd = [ 'save PHYSBE_settings ',...
				'Ri Ro C W A fe fd V0 h0 V Pi P Po f K ta Cl Cr' ];

%------------------------------------------------------------------------------
% Load pctrl data -- if not available, Define default parameters
%------------------------------------------------------------------------------  
if exist('physbe_settings.mat') == 2;
    load physbe_settings.mat;
else
    %display info message
    fprintf('\nDefault settings being saved as ''physbe_settings.mat...'' \n');
        
    % Initialize variables (lung2 ==> output params for C & V)
    %                                                     Vena
    %     RHrt  Lung1  LHrt Aorta Arms  Head  Trunk Legs  Cava Lung2
    %       1     2     3     4     5     6     7    8      9   10
    Ri = [  3.0 187.5  27.5    0  5150  2580   670  2580  0.0  0.0 ]'*0.001;
    Ro = [ 3e-3   0.0  6e-3    0    10     5  1.42     5  0.0  0.0 ]';
    
    C  = [   75  5.33 75.00 1.01  4.25  1.21  34.0  11.1  250 32.5 ]';
    W  = [  0.6   1.0   0.6  0.0  7.00   4.5  53.0  18.5  0.0  0.0 ]'*1000; 
    A  = [  0.0   0.0   0.0  0.0  3.67   1.4   6.0   7.0  0.0  0.0 ]'*1000;
    
    fe = [  0.0   0.0   0.0  0.0   0.0   0.0   0.0   0.0  0.0  0.0 ]';
    fd = fe; 
    
    % Initial conditions
    V0 = [  150   120   150  100   280  80.0  2250   730  500  240 ]';
    
    h0 = [  0.0   0.0   0.0  0.0   0.0   0.0   0.0   0.0  0.0  0.0 ]';
    
    % Benchmark parameters / operational limits
    V  = V0;
    Pi = [  0.5  16.0   7.0   80  80.0  80.0  80.0  80.0  0.5  0.0
            4.0  29.0   8.0  118 118.0 118.0 118.0 118.0  4.0  0.0 ]';
    P  = [  0.0   0.0   2.0   80  54.0  54.0  54.0  54.0  0.5  0.0
           30.0   0.0 120.0  118  80.0  80.0  80.0  80.0  4.0  0.0 ]';
    Po = [ 16.0   7.0  80.0   80   0.5   0.5   0.5   0.5  0.5  0.0
           29.0   8.0 118.0  118 118.0 118.0 118.0 118.0  4.0  0.0 ]';
    f  = [ 80.0  80.0  80.0   80   6.4  12.8  49.0  12.8 80.0  0.0 ]'; 
    
    % Constants
    K   =   1; % Thermal constant
    ta  = 300; % Ambient temperature (deg K)
    
    % Values for 1/C values for left and right ventricles over time as copied from:
    % DARE/PHYSBE by Granino A Korn, John McLeod, and John Wait; SIMULATION, 229-231, 1970?
    % Cr = [ time; 1/C ] for right ventricle 
    % Cl = [ time; 1/C ] for left ventricle 
    Cr = [ 0.0000 0.04 0.08 0.12 0.16 0.20 0.24 0.28 0.32 0.36 0.4000 1.0000 
           0.0033 0.05 0.10 0.15 0.17 0.24 0.30 0.36 0.40 0.30 0.0033 0.0033 ];
    Cl = [ 0.0000 0.04 0.08 0.12 0.16 0.20 0.24 0.28 0.32 0.36 0.4000 1.0000 
           0.0066 0.60 1.00 1.25 1.40 1.50 1.60 1.60 1.50 1.00 0.0066 0.0066 ];
    
    % Save-em
    save PHYSBE_settings Ri Ro C W A fe fd V0 h0 V Pi P Po f K ta Cl Cr
end

%-------------------------------------------------------------------------------
% Assign basic UI control parameters
%-------------------------------------------------------------------------------
xCoord  = (0:15)*50+5;
yCoord  = (0:15)*20+5;
uiWide  = 45;
uiHigh  = 20;

parts   = {   'R.Heart','Lung','L.Heart','Aorta', ...
            'Arms','Head','Trunk','Legs','V.Cava' ,'Lung2*'};
            
vars    = { 'Ri','Ro','C','W','A','V0','h0','fe','fd' };

bkColor = get(0,'defaultuicontrolbackgroundcolor');
nParts  = length(parts);
nVars   = length(vars);
etb     = zeros( nParts, nVars ); % array for storing editable text box handles

%-------------------------------------------------------------------------------
% Config figure
%-------------------------------------------------------------------------------
hFig = figure( ...
                'Name'          , 'PHYSBE Control Center'   , ...
                'Visible'       , 'off'                     , ...
                'Units'         , 'points'                  , ...
                'Position'      , [5 180 505 275]           , ...
                'Color'         , bkColor                   , ...
                'numbertitle'   , 'off'                     , ...
                'UserData'      , phySaveCmd                , ...
                'Tag'           , 'pctrl'                   );
    
%-------------------------------------------------------------------------------
% Add title bar to the figure
%-------------------------------------------------------------------------------
b = uicontrol(...
    'Parent'            , hFig                      , ...
    'Style'             , 'text'                    , ...
    'String'            , 'PHYSBE Control Center'   , ...
    'Units'             , 'points'                  , ...
    'Position'          , [5 230 495 30]            , ...
    'BackgroundColor'   , bkColor                   , ...
    'FontName'          , 'Geneva'                  , ...
    'FontSize'          , 24                        , ...
    'FontWeight'        , 'bold'                    , ...
    'Tag'               , 'TitleBar'                );

%-------------------------------------------------------------------------------
% Set up grid of editable text boxes in the figure
%-------------------------------------------------------------------------------
for row = 1:nParts,
    % Put in text label for row
    txt = uicontrol( ...
        'Style'            , 'text'                                     , ...
        'String'           , parts{nParts - row + 1}                    , ...
        'BackgroundColor'  , bkColor                                    , ...
        'Units'            , 'points'                                   , ...
        'Position'         , [xCoord(1), yCoord(row), uiWide, uiHigh]   , ...
        'Tag'              , 'PartText'                                 );
        
    % Put in an etb for ea. column (ea. variable)
    for col = 1:nVars,
        % generate variable and callback strings
        vText = [ vars{col} '(' num2str(nParts - row + 1) ')' ];
        cText = [ vText '=str2num(get(gcbo,''String''));'];
        % generate the etb
        etb(row,col) = uicontrol( ...
            'Style'          , 'edit'                                    , ...
            'String'         , eval(['num2str(' vText ')'])              , ...
            'BackgroundColor', [1 1 1]                                   , ...
            'Units'          , 'points'                                  , ...
            'Position'       , [xCoord(col+1) yCoord(row) uiWide uiHigh ], ...
            'CallBack'       , [cText, 'set_param(gcb,''UserData'',1);'] , ...
            'Tag'            , [ parts{nParts - row + 1} '_' vars{col} ] );    
        if row == 1,
            % put labels on the top of the column
            yPreCalc = yCoord(nParts + 1);
            txt = uicontrol( ...
                'Style'          ,'text'                                , ...
                'String'         ,vars{col}                             , ...
                'BackgroundColor',bkColor                               , ...
                'Units'          ,'points'                              , ...
                'Position'       ,[xCoord(col+1) yPreCalc uiWide uiHigh], ...
                'Tag'            ,'VarText'                             );    
        end % if row =  
    end % for col =...
end % for row =...

%-------------------------------------------------------------------------------
% Config certain etitable text boxes
%-------------------------------------------------------------------------------
etb=flipud(etb);
set( etb([1,3,4,9,10],[4,5,7:9]), 'BackGroundColor','c');
%set( etb(4,[1,2,4,5,8,9]),'BackGroundColor','c');
set( [etb(2,2), etb(10,2) etb(10,1)], 'BackGroundColor','c');

%-------------------------------------------------------------------------------
% Add save and reset buttons
%-------------------------------------------------------------------------------
uicontrol( ...
    'Style'             , 'pushbutton'              , ...
    'String'            , 'Save'                    , ...
    'BackgroundColor'   , bkColor                   , ...
    'Units'             , 'points'                  , ...
    'Position'          , [5, 235, uiWide, uiHigh]  , ...
    'Callback'          , phySaveCmd                , ...
    'Tag'               , 'SaveBtn'                 );    
    
uicontrol( ...
    'Style'             , 'pushbutton'                      , ...
    'String'            , 'Reset'                           , ...
    'BackgroundColor'   , bkColor                           , ...
    'Units'             , 'points'                          , ...
    'Position'          , [500-uiWide, 235, uiWide, uiHigh] , ...
    'Callback'          , 'delete(gcf); pctrl2;'            , ...                                , ...
    'Tag'               , 'ResetBtn'                        );    
    
%-------------------------------------------------------------------------------
% Turn figure "on" and clean up extra variables
%-------------------------------------------------------------------------------
set(hFig,'Visible','on');
physbe_var_list = 'A C Cl Cr K P Pi Po Ri Ro V V0 W f fd fe h0 ta';

clear xCoord yCoord uiWide uiHigh parts vars bkColor nParts nVars col
clear etb a b btn yPreCalc txt vText cText row newflag phySaveCmd
