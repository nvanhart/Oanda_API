function [results] = GetPriceFeed(pair,runTime,frequency)
%% GetPriceFeed to stream real-time prices
%  Function to stream (eventually plot) realtime data from Oanda. Can be
%  used to update bayesian MC models, etc. 
%
%  Ex: data500points = GetPriceFeed('aud_jpy',500,0.5); %500 data points at
%  frequency of 0.5 seconds
%% Initialize Table
cp = GetCurrentPrice(char(lower(pair))); %fetches new data
time = cp.time(1);
spread = abs(str2double(cp.closeBid(1)) - str2double(cp.closeAsk(1)));
bid = str2double(cp.closeBid(1));
live_stream = table(time,bid,spread); %first entry

if char(frequency) == "max"
    for i = 1:runTime-1
        cp = GetCurrentPrice(char(lower(pair))); %fetches new data
        time = cp.time(1);
        spread = abs(str2double(cp.closeBid(1)) - str2double(cp.closeAsk(1)));
        bid = str2double(cp.closeBid(1));
        new_stream = table(time,bid,spread);
        live_stream = [live_stream;new_stream]
    end
else
    tic
    while toc <= runTime
        pause(frequency) %in seconds
    
        cp = GetCurrentPrice(char(lower(pair))); %fetches new data
        time = cp.time(1);
        spread = abs(str2double(cp.closeBid(1)) - str2double(cp.closeAsk(1)));
        bid = str2double(cp.closeBid(1));
        new_stream = table(time,bid,spread);
        live_stream = [live_stream;new_stream]
    end
end

results = flipud(live_stream); %flips upside down w recent date at top
end