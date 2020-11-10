function  [y] = tent(x)
y_up = @(x) 3 * x;
y_down = @(x) 3 - 3 * x;

if x >= 0
    if x <= 1/2
        y = y_up(x);
        return
    elseif x <= 1
        y = y_down(x);
        return
    end
end
y = 0
end

