function [stopline_detected] = CheckStopline(WholeImage)
% This function is supposed to check if there is a stopline

stopline_detected = false;
MAX_NO_PEAKS_IN_COLUMN = 250;
NO_COLUMNS = 2;
check_columns = [260 360];
all_points = zeros(3, MAX_NO_PEAKS_IN_COLUMN, NO_COLUMNS);
no_points = zeros(NO_COLUMNS);
ref_y = 0;
counter = 1;
start = 0;
ende = 0;
ref = zeros(2, 2, NO_COLUMNS);
upper_limit = 0;
lower_limit = 0;
sum = 0;
mean = 1;
diff = 0;
threshold = 230;

for column = 1:NO_COLUMNS
    current_column = check_columns(column);
    
    for line = 280:-1:1
        value = WholeImage(line,current_column);
        if (value >= threshold)
            no_points(column) = no_points(column)+1;
            all_points(1, no_points(column), column) = line;
            all_points(2, no_points(column), column) = current_column;
            distance = line - ref_y;
            all_points(3, no_points(column), column) = abs(distance);
            ref_y = line;
        end
    end
 
    for i = 1:no_points(column)+1
        distance = all_points(3, i, column);
        disp('distance')
        disp(distance)
        if distance == 1
            counter = counter + 1;
        else
            disp(counter)
            if counter > 5 && counter < 15
                start = all_points(1, i-counter, column);
                ende = all_points(1, i-1, column);
                ref(1, 1, column) = start;
                ref(1, 2, column) = check_columns(column);
                ref(2, 1, column) = ende;
                ref(2, 2, column) = check_columns(column);
            end
            counter = 0;
        end
    end
    counter = 0;
end

if ref(1, 1, 1) > ref(1, 1, 2)
    upper_limit = ref(1, 1, 1);
else
    upper_limit = ref(1, 1, 2);
end
if ref(2, 1, 1) < ref(2, 1, 2)
    lower_limit = ref(2, 1, 1);
else
    lower_limit = ref(2, 1, 2);
end

if ref(1, 1, 1) > 0 && ref(1, 1, 2) > 0
    stopline_detected = true;
    
%             matrix = WholeImage(lower_limit:upper_limit, check_columns(1):check_columns(2));
%             for row = 1:size(matrix,1)
%                 for column = 1:size(matrix,2)-1
%     
%                     diff = abs(matrix(row, column+1) - matrix(row, column));
%                     sum = sum+double(diff);
%                     disp(sum)
%                 end
%             end
end
end
