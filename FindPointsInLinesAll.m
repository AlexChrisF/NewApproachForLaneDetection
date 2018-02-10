%% Function Name: FindPointsInLinesAll
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


function [all_points, no_points]  = FindPointsInLinesAll(variables, REGIONS, only_first, take_third)
% This function in supposed to find all white points in line

all_points = zeros(4, variables.MAX_NO_PEAKS_IN_LINE, variables.NO_REGIONS);
no_points = zeros(variables.NO_REGIONS);
first_line = 1;
X = 1;
Y = 2;
D = 3;
ref_x = 0;

for REGION = 1:variables.NO_REGIONS
    ref_x = 0;
    last_line = size(REGIONS(:,:,REGION), 1);  %Check all lines in image
    % True if first line to be checked shall be the third line
    if(take_third == true)
        first_line = 3;
    end
    % True if only one line shall be checked
    if(only_first == true)
        last_line = first_line;
    end
    % Walk through line(s) in region
    for line = first_line:last_line
        for column = 1:640
            if (REGIONS(line,column,REGION)==1)
                no_points(REGION) = no_points(REGION)+1;
                all_points(X, no_points(REGION), REGION) = column;
                all_points(Y, no_points(REGION), REGION) = line+variables.REGIONS_BEGIN(REGION)-1;
                distance = column - ref_x;
                all_points(D, no_points(REGION), REGION) = distance;
                ref_x = column;
            end
        end
    end
end
end

