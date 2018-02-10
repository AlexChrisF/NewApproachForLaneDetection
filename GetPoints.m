function [sel_points, found]  = GetPoints(all_points, no_points, NO_REGIONS)
% This function is supposed to return the points with the highest
% probability in each region
sel_points = zeros(2, NO_REGIONS);
found = zeros(NO_REGIONS);

min_probability = [65 30 30 30]; % Region based probability
for REGION = 1:NO_REGIONS
    % Check if points were found
    if(no_points(REGION) > 0)
        [M, I] = max(all_points(4,1:no_points(REGION),REGION));
        % Check if there is a point with a max probability
        if(M > min_probability(REGION))
            found(REGION) = true;
            sel_points(:, REGION) = all_points(1:2,I,REGION);
        end
    end
end
end
