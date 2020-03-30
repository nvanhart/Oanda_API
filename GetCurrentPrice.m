function price = GetCurrentPrice(pair)
% Returns the current bid/ask for the specified pair. 
% Example: GetCurrentPrice('EUR_USD')
%
%% Ensure correct formatting
pair = upper(pair);
%% API Call
try
RawPrice = GetCurrentPrice(oapi,pair);
catch 
    closeBid = 0;
    closeAsk = 0;
    time = "Error";
    price = table(time,closeBid,closeAsk);
end

%% Error Checking and Report Assingment
if isfield(RawPrice,'code')
    price = RawPrice;
    fprintf('OANDA ERROR:\ncode: %s\n%s\n',num2str(price.code),price.message);
    return
end

%% Convert structure to vector
closeBid = string(RawPrice.prices.closeoutBid);
closeAsk = string(RawPrice.prices.closeoutAsk);
time = convert8601(string(RawPrice.time));
%d = time - 4 %unsure why this is -8 for EST...

%% Dispense results
price = table(time,closeBid,closeAsk);

end