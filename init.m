function [variables, states, my_init, LookUpMatrixWorld] = init()
% This function is supposed to initialize some variables

% Constants
NO_REGIONS = 4;
TOLERANCE = [20 20 20 20];
MAX_NO_PROCESSED_FRAMES = 1;
MAX_NO_PEAKS_IN_LINE = 300;
MAX_DISTANCES = [30 50 50 50];
MAX_COUNTER = 2;
EXPECTED_LANE_WIDTH = [400 350 200 150];
EXPECTED_MARKER_WIDTH = [5 20; 5 20; 5 15; 3 15];
REGIONS_BEGIN = [475 330 205 170]; 
VARIABLE_MID = 320;

LookUpMatrix = coder.load('LookUp.mat');
LookUpMatrixWorld = LookUpMatrix.lookUpTableWorld;

% States
field1 = 'NORMAL';  value1 = 1;
field2 = 'CROSSWALK';  value2 = 2;
field3 = 'JUNCTION'; value3 = 3;
states = struct(field1,value1,field2,value2,field3,value3);

% Variables
history_regions = zeros(4, MAX_NO_PEAKS_IN_LINE, MAX_NO_PROCESSED_FRAMES, NO_REGIONS);
history_regions_first_right =  zeros(2, MAX_NO_PROCESSED_FRAMES, NO_REGIONS);
points_last_found = zeros(2, NO_REGIONS);
number_points_in_regions = zeros(NO_REGIONS, MAX_NO_PROCESSED_FRAMES);
number_of_processed_frames = 0;
my_init = false;
counter = zeros(NO_REGIONS,1);
norm = normpdf(1:1:50,0,30)*3000;
current_state = states.NORMAL;
last_state = states.NORMAL;
delay_counter = ones(NO_REGIONS, 1);
field4 = 'history_regions';
field5 = 'history_regions_first_right';
field6 = 'points_last_found';
field7 = 'number_points_in_regions';
field8 = 'number_of_processed_frames';
field9 = 'counter';
field10 = 'norm';
field11 = 'current_state';
field12 = 'last_state';
field13 = 'delay_counter';

% Constants
field14 = 'NO_REGIONS';
field15 = 'TOLERANCE';
field16 = 'MAX_NO_PROCESSED_FRAMES';
field17 = 'MAX_NO_PEAKS_IN_LINE';
field18 = 'MAX_DISTANCES';
field19 = 'MAX_COUNTER';
field20 = 'EXPECTED_LANE_WIDTH';
field21 = 'EXPECTED_MARKER_WIDTH';
field22 = 'REGIONS_BEGIN';
field23 = 'VARIABLE_MID';

variables = struct(field4,history_regions,field5,history_regions_first_right,...
                       field6,points_last_found,field7,number_points_in_regions,...
                       field8,number_of_processed_frames,field9,counter,field10,norm,...
                       field11,current_state,field12,last_state,field13,delay_counter,...
                       field14,NO_REGIONS,field15,TOLERANCE,field16,MAX_NO_PROCESSED_FRAMES,...
                       field17,MAX_NO_PEAKS_IN_LINE,field18,MAX_DISTANCES,field19,MAX_COUNTER,...
                       field20,EXPECTED_LANE_WIDTH,field21,EXPECTED_MARKER_WIDTH,field22,REGIONS_BEGIN,field23,VARIABLE_MID);

end


