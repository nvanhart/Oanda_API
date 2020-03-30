function history = GetPriceHistory(pairString,lookback,granularity)
% Returns the historic price data for the specified pair.
% Example: GetPriceHistory('EUR_USD',1,'M5') - 1 day lookback at 5 minute
%                                         granularity
%          GetPriceHistory('EUR_USD',6,'H3') - 6 day lookback at 3 hour
%                                         granularity
%
% Supported granularity: S5,10,15,30; M1-5,10,15,30; H1-4,6,8; D; W; M
%
%% Convert lookback format
CT = datetime('now','Timezone','UTC')-lookback; %current time in UTC, minus lookback (days)
lookback = char(datetime(CT,'Format','yyyy-MM-dd''T''hh''%3A''mm''%3A''ss''.000000000Z')); %converts to char 8601 format 

%% API Call
RawHistory = GetPriceHistory(oapi,pairString,lookback,granularity);

%% Error Checking and Report Assingment
if isfield(RawHistory,'code')
    history = RawHistory;
    fprintf('OANDA ERROR:\ncode: %s\n%s\n',num2str(history.code),history.message);
    return
end

%% Convert structure to vector
history = cell2mat(RawHistory.candles); %extracts number (count) of structures w timestamp, volume, prices
points = length(history); %checks size/number of points returned

time   = strings([points,1]); %creates empty vector length of count
volume = zeros(points,1);
%high   = zeros(points,1);
%low    = zeros(points,1);
openBid   = zeros(points,1);
closeBid  = zeros(points,1);
openAsk   = zeros(points,1);
closeAsk  = zeros(points,1);

for j = 1:length(time)
    volume(j) = string(history(j).volume);
    openBid(j) = string(history(j).bid.o);
    closeBid(j) = string(history(j).bid.c);
    openAsk(j) = string(history(j).ask.o);
    closeAsk(j) = string(history(j).ask.c);
    time(j) = convert8601(string(history(j).time));
    %high(j) = string(history(j).ask.h);
    %low(j) = string(history(j).ask.l);
end


%% Dispense results
history = table(openBid,openAsk,closeBid,closeAsk,volume,time);

end