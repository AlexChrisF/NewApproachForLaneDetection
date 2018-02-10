%% Function Name: CheckPosition
% This function is supposed to find the first right point going from and to
% give them a higher probability
%
% Inputs:
%   all_points: All white points in line
%   no_points: Number of white points in line
%   NO_REGIONS: Number of regions used
%   variable_mid: Mid of picture in pixels
%   norm: matrix with normal distributed numbers

% Outputs:
%   all_points: All white points with probability being set

%
% $Date: Feb 4, 2018 Christoph Friedrich, chfrit00@hs-esslingen.de
% ________________________________________


function [all_points] = CheckPosition(all_points, no_points, NO_REGIONS, variable_mid, norm)

X = 1;
P = 4;
for REGION = 1:NO_REGIONS
    found = false;
    index = 0;
    if(REGION == 1)
        variable_mid = 490;
    end
    for i=1:no_points(REGION)
  
        if(all_points(X,i,REGION) > variable_mid &&  all_points(X,i,REGION) < (variable_mid+150) && found == false)
            
            found = true;
            
            if(REGION < 3)
                variable_mid = all_points(X,i,REGION) - 100;
            else
                variable_mid = all_points(X,i,REGION) - 50;
            end
            
            index = i;
            all_points(P,i,REGION) = norm(1);
            % Check right side
            if(index+1 <= no_points(REGION))
                for j = index+1:1:no_points(REGION)
                    distance = abs(all_points(X,j,REGION) - all_points(X,index,REGION));
                    if (distance <= size(norm, 2))
                        all_points(P,j,REGION) = norm(distance);
                    end
                end
            end
            % Check left side
            if(index-1 >= 1)
                for j = index-1:-1:1
                    distance = abs(all_points(X,j,REGION) - all_points(X,index,REGION));
                    if (distance <= size(norm, 2))
                        all_points(P,j,REGION) = norm(distance);
                    end
                end
            end
        end
    end
end
end
