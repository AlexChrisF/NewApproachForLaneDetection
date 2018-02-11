function [normal_detected] = CheckNormal(found_points)
% This function is supposed to check there is nothing special
persistent counter 

if isempty(counter) 
   counter = 0;
end

normal_detected = false;
X = 1;

REGION_1 = found_points(X,1);
REGION_2 = found_points(X,2);
REGION_3 = found_points(X,3);
REGION_4 = found_points(X,4);
dis = abs(REGION_3-REGION_4);
dis_2 = abs(REGION_3-REGION_2);
dis_3 = abs(REGION_2-REGION_1);
dis_sum = dis + dis_2 + dis_3;
if(dis_sum > 0 && dis_sum < 150)
    counter = counter + 1;
   disp(counter)
    if (counter == 10)
        normal_detected = true;
        counter = 0;
    end
end

end
