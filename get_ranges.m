function [ranges] = get_ranges(it_max, varargin)
    %% initating
    if nargin == 4
        rng_lst = varargin{1};
        it = varargin{2};
        plotting = varargin{3};
    elseif nargin == 1
        rng_lst = {[0;1]};
        it = 1;
        plotting = true;
    else
        return
    end
    %% Display progress
    % disp('iteration:')
    % disp(it)
    % disp('number of ranges:')
    % disp(length(rng_lst))
    % disp('max number of its:')
    % disp(its)
    %% plotting
    % convert cell to 2xlength(segments) matrix
    if plotting
        s2m = @(s) [s{1:length(s)}];
        x = s2m(rng_lst);
        y = zeros(2,length(rng_lst));
        
        
%         fig = gcf; % current figure handle
        fig = figure;
        set(gcf, 'Position',  [100, 900, 900, 80])
        fig.Name = sprintf('Cantor Set iteration: %d',it);
        fig.NumberTitle = 'off';
        fig.Color = 'w';
        plot(x,y,'-b','LineWidth',10)
        ax = gca;
        t = title(sprintf('Cantor Set iteration: %d',it));
        t.FontSize = 30;
        ax.YTick = [];
        ax.YColor = 'none';
%         ax.XColor = 'none';
        ax.Color = 'w';
        ax.Box = 'off';
        ax.XAxisLocation = 'origin';
        saveas(gcf,sprintf('cantor_no_axis_%d.png',it))
        
        pause(1)
        
    end
    %% getting new ranges
    if it < it_max % return if finished
        left_matrix = [1 0;2/3 1/3];
        right_matrix = [1/3 2/3;0 1];
        new_ranges = cell(1,2*length(rng_lst));
        for j = 1:length(rng_lst)
            new_ranges{(j*2)-1} = left_matrix * rng_lst{j};
            new_ranges{j*2} = right_matrix * rng_lst{j};
        end
        get_ranges(it_max, new_ranges, it+1, plotting)
    else
        
        ranges = rng_lst;
        %% zoom
        fig = gcf; % current figure handle
        fig.Name = sprintf('Cantor Set iteration: %d',it);
        fig.NumberTitle = 'off';
        fig.Color = 'w';
        
        plot(x,y,'-b','LineWidth',10)
        
        ax = gca;
        t = title(sprintf('Cantor Set iteration: %d',it));
        t.FontSize = 30;
        ax.YTick = [];
        ax.YColor = 'none';
%         ax.XColor = 'none';
        ax.Color = 'w';
        ax.Box = 'off';
        ax.XAxisLocation = 'origin';
        
%         percentage = 0.995;
        percentage = 0.995^4;
        range = [0 1];
        
        
        
        for a=0:100
            range = range * percentage;
            ax.XLim = range;
%             saveas(gcf,sprintf('zoom_%d.png',a))
            pause(0.1)
        end
        
        
        
        
    end
    %% getting new ranges alternative
%     if it < it_max % return if finished
%         left_matrix = [1 0;5/8 3/8];
%         right_matrix = [3/8 5/8;0 1];
%         new_ranges = cell(1,2*length(rng_lst));
%         for j = 1:length(rng_lst)
%             new_ranges{(j*2)-1} = left_matrix * rng_lst{j};
%             new_ranges{j*2} = right_matrix * rng_lst{j};
%         end
%         get_ranges(it_max, new_ranges, it+1, plotting)
%     else
%         ranges = rng_lst;
%     end
end

% varargin: variable (number of) arguments in (this function)
% nargin: number of arguments in (this function)