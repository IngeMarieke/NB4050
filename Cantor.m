classdef Cantor
    properties
        % basic default properties for using the ternary cantor set: 
        %8 iterations, do plot, do zoom, don't save
        it_max = 8
        plotting = true
        zoom = true
        save_its = false;
        % basic default properties for plotting the cantor set: 
        % position on screen, do plot the x-axis, pause of 1 second... 
        %...between iterations, line-color blue, line-width 10
        position = [100, 900, 900, 80];
        no_x_axis = false;
        show_title = true;
        ps = 1;
        cl = 'b';
        lwidth = 10;
        % zoom params, default: 10 fps ~2% zoom
        percentage = 0.995^2;
        num_frames = 200;
        frame_time = 0.05
    end
    
    methods
        function [obj] = ternary(obj, varargin)
            % control function of the cantor class, only function that
            % needs to be called. If no argument is given, it shows the
            % cantor set for 8 iterations, as described in the default 
            if nargin == 2
                obj.it_max = varargin{1};
            end
            fig = figure('Position', obj.position, 'NumberTitle', 'off',...
                'Color', 'w');
            
            rng_lst = {[0;1]}; 
            it = 1;
            obj.get_ranges(rng_lst, it, fig);
            
            if obj.zoom
                obj.zoom_in()
            end
        end
        function [ranges] = get_ranges(obj, rng_lst, it, fig)
            % should only be called by obj.ternary()
            if obj.plotting
                obj.plot(fig, rng_lst, it);
            end
            left_matrix = [1 0;2/3 1/3];
            right_matrix = [1/3 2/3;0 1];
            if it < obj.it_max
                ranges = cell(1,2*length(rng_lst));
                for j=1:length(rng_lst)
                    ranges{(j*2)-1} = left_matrix * rng_lst{j};
                    ranges{j*2} = right_matrix * rng_lst{j};
                end
                rng_lst = ranges;
                it = it + 1;
                obj.get_ranges(rng_lst, it, fig);
            end
        end
        function [x, y] = plot(obj, fig, rng_lst, it)
            % should only be called by obj.get_ranges()
            s2m = @(s) [s{1:length(s)}];
            x = s2m(rng_lst);
            y = zeros(2,length(rng_lst));
            
            if obj.save_its
                fig = figure('Position', obj.position, 'NumberTitle', ...
                    'off', 'Color', 'w');
            end
            fig.Name = sprintf('Cantor Set iteration: %d',it);
            plot(x,y,obj.cl,'LineWidth',obj.lwidth)
            ax = gca;
            if obj.show_title
                t = title(sprintf('Cantor Set iteration: %d',it));
            end
            t.FontSize = 30;
            ax.YTick = [];
            ax.YColor = 'none';
            if obj.no_x_axis
                ax.XColor = 'none';
            end
            ax.Color = 'w';
            ax.Box = 'off';
            ax.XAxisLocation = 'origin';
            if obj.save_its
                saveas(gcf,sprintf('cantor_no_axis_%d.png',it))
            end
            pause(obj.ps)
        end
        function [obj] = zoom_in(obj)
            % should only be called by obj.ternary()
            range = [0 1];
            for a = 1:obj.num_frames
                range = range * obj.percentage;
                ax = gca;
                ax.XLim = range;
                pause(obj.frame_time)
            end
        end
    end
end

