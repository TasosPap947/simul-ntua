% SHOWV plots Internal Pressure, Input Pressure, and Volume data
% for all nine subsystems of PHYSBE. Requires variables in workspace:
%   tout - from SIMULINK parameters
%   pressure, pin, and volume - from To Workspace blocks in PHYSBE

% Written By: Kevin Kohrt, kkohrt@mathworks.com
% Written On: 14 Dec 1996
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Params
lnx = [min(tout), max(tout)];
xTickVect = lnx(1):5:lnx(2);

% Plot all volumes
fig=initfig('V - PHYSBE Volume Data');
set(fig, 'NumberTitle','off', 'position', [ 245    55   485   350] );
sv(1) = subplot(331); plot(tout,volume(:, 1)); lineplot( [70 150], 'r', [70*0.9 150*1.1], 'k:'); % +/- 10%
					  title('r.heart');
sv(2) = subplot(332); plot(tout,volume(:,[2, 10])); lineplot( 120*[1 1.2 0.8], 'r--', 240*[1 1.2 0.8], 'k:' ); 	% +/- 20%
					  title('Lungs i,o');	 ylabel('i    o') 
sv(3) = subplot(333); plot(tout,volume(:, 3)); lineplot( [70 150], 'r', [70*0.9 150*1.1], 'k:'); % +/- 10%
					  title('l.heart');
sv(4) = subplot(334); plot(tout,volume(:,4)); lineplot( 100*[1 1.2 0.8], 'r' ); 	title('aorta'); ylabel('Vol (ml)');
sv(5) = subplot(335); plot(tout,volume(:,5)); lineplot( 280*[1 1.2 0.8], 'r' ); 	title('arms');	 
sv(6) = subplot(336); plot(tout,volume(:,9)); lineplot( 500*[1 1.2 0.8], 'r' ); 	title('vc'); 
sv(7) = subplot(337); plot(tout,volume(:,6)); lineplot(  80*[1 1.2 0.8], 'r' );		title('head');  
sv(8) = subplot(338); plot(tout,volume(:,7)); lineplot(2250*[1 1.2 0.8], 'r' ); 	title('trunk'); 
sv(9) = subplot(339); plot(tout,volume(:,8)); lineplot( 730*[1 1.2 0.8], 'r' ); 	title('legs'); 

% Plot all pressure in one figure
fig=initfig('P - PHYSBE Pressure Readings');
set(fig, 'NumberTitle','off', 'Position', [525   455   485   350]);
spp(1) = subplot(331); plot(tout,pressure(:,1)); lineplot( [ 0  30],'r', [ 0  30].*[.8 1.2] ); title('r.heart'); 
spp(2) = subplot(332); plot(tout,pressure(:,2)); lineplot( [ 7   8],'r', [ 7   8].*[.8 1.2] ); title('lungs o');  
spp(3) = subplot(333); plot(tout,pressure(:,3)); lineplot( [ 2 120],'r', [ 2 120].*[.8 1.2] ); title('l.heart');  
spp(4) = subplot(334); plot(tout,pressure(:,4)); lineplot( [80 118],'r', [80 118].*[.8 1.2] ); title('aorta'); ylabel('Pressure (mmHg)');
spp(5) = subplot(335); plot(tout,pressure(:,5)); lineplot( [54  80],'r', [54  80].*[.8 1.2] ); title('arms');
spp(6) = subplot(336); plot(tout,pressure(:,9)); lineplot( [.5   4],'r', [.5   4].*[.8 1.2] ); title('vc');  
spp(7) = subplot(337); plot(tout,pressure(:,6)); lineplot( [54  80],'r', [54  80].*[.8 1.2] ); title('head'); 
spp(8) = subplot(338); plot(tout,pressure(:,7)); lineplot( [54  80],'r', [54  80].*[.8 1.2] ); title('trunk'); 
spp(9) = subplot(339); plot(tout,pressure(:,8)); lineplot( [54  80],'r', [54  80].*[.8 1.2] ); title('legs');  

% Plot all input pressures in one figure
fig=initfig('Pi - PHYSBE Input Pressure Readings');
set(fig, 'NumberTitle','off', 'Position', [10   455   485   350]);
spi(1) = subplot(331); plot(tout,pin(:,1)); lineplot( [.5   4],'r', [.5   4].*[.8 1.2] ); title('R.Heart');  
spi(2) = subplot(332); plot(tout,pin(:,2)); lineplot( [16  29],'r', [16  29].*[.8 1.2] ); title('Lungs i'); 
spi(3) = subplot(333); plot(tout,pin(:,3)); lineplot( [ 7   8],'r', [ 7   8].*[.8 1.2] ); title('L.Heart'); 
spi(4) = subplot(334); plot(tout,pin(:,4)); lineplot( [80 118],'r', [80 118].*[.8 1.2] ); title('Aorta');  ylabel('Input Pressure (mmHg))');
spi(5) = subplot(335); plot(tout,pin(:,5)); lineplot( [80 118],'r', [80 118].*[.8 1.2] ); title('Arms'); 
spi(6) = subplot(336); plot(tout,pin(:,9)); lineplot( [.5   4],'r', [.5   4].*[.8 1.2] ); title('VC'); 
spi(7) = subplot(337); plot(tout,pin(:,6)); lineplot( [80 118],'r', [80 118].*[.8 1.2] ); title('Head');  
spi(8) = subplot(338); plot(tout,pin(:,7)); lineplot( [80 118],'r', [80 118].*[.8 1.2] ); title('Trunk');  
spi(9) = subplot(339); plot(tout,pin(:,8)); lineplot( [80 118],'r', [80 118].*[.8 1.2] ); title('Legs');  

% Set axes properties
set([ sv, spp, spi],'xtick',xTickVect,'xlim',[0,max(tout)],'xticklabel',[] )

% Clean up
clear xTickVect Inx fig sv spp spi

