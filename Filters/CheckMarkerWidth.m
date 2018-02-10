%% Function Name: CheckMarkerWidth
% This function is supposed to give points within a possible lane marker a higher probablility
% Assumptions: None
%
% Inputs:
%   all_points: All white points in line
%   no_points: Number of white points in line
%   NO_REGIONS: Number of regions used
%   EXPECTED_LANE_WIDTH: Expected lane width (Distance from middle lane to
%   right lane)

% Outputs:
%   all_points: All white points with probability being set

%
% $Date: Feb 4, 2018 Christoph Friedrich, chfrit00@hs-esslingen.de
% ________________________________________

function [all_points] = CheckMarkerWidth(all_points, no_points, NO_REGIONS, EXPECTED_MARKER_WIDTH)
D = 3;
P = 4;
for REGION = 1:4 %NO_REGIONS
    if(no_points(REGION) > 1)
        for i = 1:no_points(REGION)
            min = EXPECTED_MARKER_WIDTH(REGION,1);
            max = EXPECTED_MARKER_WIDTH(REGION,2);
            distance = all_points(D,i,REGION);
            if distance > min && distance < max
                % Give found point
                if( i > 1)
                    all_points(P,i-1,REGION) =  all_points(P,i-1,REGION)+28;
                end
            end
        end
    end
end

end

