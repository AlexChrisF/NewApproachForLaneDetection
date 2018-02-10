%% Function Name: CheckLaneWidth
% This function is supposed to give points with an expected distance to the middle lane a higher probablility
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

function [all_points] = CheckLaneWidth(all_points, no_points, NO_REGIONS, EXPECTED_LANE_WIDTH)
D = 3;
P = 4;
% Check lane width
for REGION = 1:NO_REGIONS
    if(no_points(REGION) > 1)
        [dis, I] = sort(all_points(D,1:no_points(REGION),REGION), 'descend');
        
        for i = 1:size(I,2)
            
            if all_points(D,i,REGION) > EXPECTED_LANE_WIDTH(REGION) && all_points(D,i,REGION) 
                all_points(P,i,REGION) =  all_points(P,i,REGION)+20;
                
            elseif (REGION > 2) && all_points(D,i,REGION) > (1.8 * EXPECTED_LANE_WIDTH(REGION)) && all_points(D,i,REGION) < (2.2 * EXPECTED_LANE_WIDTH(REGION))
                     all_points(P,i,REGION) =  all_points(P,i,REGION)+20;
            end
  
        end
        
        
    end
end
end
