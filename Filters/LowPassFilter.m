%% Function Name: LowPassFilter
% This function implements a low pass filter bahavior. Jumps in point
% postions are deferred.
%
% Inputs:
%   sel_points: Points with highest probability
%   found: Number of found points
%   points_last_found: Selected points from last frame
%   counter: Number of frames point is already deferred (For each region)
%   MAX_COUNTER: Max. number of frames point will be deferred (For each region)
%   NO_REGIONS: Number of regions
%   MAX_DISTANCES: Max. distance for each region, tells when point shall be
%   deffered

% Outputs:
%   points_last_found: Points that will be used as lane points 
%   counter: Number of frames point is already deferred (For each region)
%
% $Date: Feb 4, 2018 Christoph Friedrich, chfrit00@hs-esslingen.de
% ________________________________________

function [points_last_found, counter] = LowPassFilter(sel_points, found, points_last_found, counter, NO_REGIONS, MAX_DISTANCES, MAX_COUNTER)
X = 1;
Y = 2;
for REGION = 1:NO_REGIONS
    if (found(REGION) == true) 
        points_last_found(Y, REGION) = sel_points(Y, REGION);
        dist = sel_points(X, REGION) - points_last_found(X, REGION);
        if (abs(dist) <= MAX_DISTANCES(REGION))
            points_last_found(:, REGION) = sel_points(:, REGION);
        else 
            counter(REGION) = counter(REGION) + 1;
            if (counter(REGION) < MAX_COUNTER)
                points_last_found(X, REGION) = points_last_found(X, REGION) +  dist/MAX_COUNTER;
                counter(REGION) = 0;
            end     
            if (REGION > 3)
                points_last_found(:, REGION) = points_last_found(:, REGION-1);
            end
            if (REGION == 2 && found(REGION-1) == true && found(REGION+1) == true && found(REGION+2) == true)
                        points_last_found(X, REGION) = (points_last_found(X, REGION-1) +  points_last_found(X, REGION+1))/2;
            end   
        end
    else
        % Try
        if (REGION > 3)
            points_last_found(X, REGION) = points_last_found(X, REGION-1);
            points_last_found(Y, REGION) = points_last_found(Y, REGION-1);      
        end 
    end
end
end
