function openfig = initfig(heading)

openfig = findobj('Type','figure','Name',heading);

if isempty(openfig)
    openfig = figure('Name',heading,'MenuBar','none');
else
    figure(openfig)
end
    
    
    
    
    
    
    
    