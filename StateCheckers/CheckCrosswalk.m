function [crosswalk_detected, where] = CheckCrosswalk(distances, no_points, NO_REGIONS)
% This function is supposed to check if there is a crosswalk
crosswalk_detected = false;
where = zeros(NO_REGIONS, 1);
counter = 0;

for REGION = 1:NO_REGIONS
    for i = 1:no_points(REGION)
        distance = distances(1, i, REGION); 
        if (distance > 10 && distance < 36)
            counter = counter + 1;
        end 
        if (counter > 7)
            where(REGION) = true;
            crosswalk_detected = true;
        end
    end
    counter = 0;
end
end
