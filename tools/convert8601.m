function [output] = convert8601(string8601)
% Convert ISO 8601 formatted date string to serial date number (EST)
% Syntax: output = convert8601(8601str)
%% Section 1: Manipulate data
c8601 = char(string8601); %convert char
c8601 = c8601(1:22); %removes additional decimals
Y = uint16(str2double(c8601(1:4)));
M = uint16(str2double(c8601(6:7)));
D = uint16(str2double(c8601(9:10)));
H = uint16(str2double(c8601(12:13))); 
MI = uint16(str2double(c8601(15:16)));
S = uint16(str2double(c8601(18:19)));
MS = uint16(str2double(c8601(21:22)));

%% Section 2: Output results
output = datetime(Y,M,D,H,MI,S,MS); %UTC 
output = output - (4/24); %(-04:00 to EST)
