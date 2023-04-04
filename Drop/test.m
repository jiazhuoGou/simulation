x = 10;
count = 0;
    for j = 1 : 9
        if j + j >= 10
            if  j >= 6
                disp([j, j, 0]);
                break;
            elseif j >= 8
                   disp([j, j, 1]);
                   break;
            end
        end
    end