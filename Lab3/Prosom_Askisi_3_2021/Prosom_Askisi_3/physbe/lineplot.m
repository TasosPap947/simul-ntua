function lineplot(varargin)

xlim = get(gca,'xlim');
ylim = get(gca,'ylim');
hold on

for i=1:2:nargin
    for j=1:length(varargin{i})
        if i~=nargin & ischar(varargin{i+1})
            plot(xlim,varargin{i}(j)*ones(1,2),varargin{i+1})
        else
            plot(xlim,varargin{i}(j)*ones(1,2))
        end
    end
end

hold off