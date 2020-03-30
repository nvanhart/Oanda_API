function orderInfo = CloseOrder(pair,long_short,units)
% Closes long/short position of desired units and returns price sold/bought
% Input must be string or char formatted EXACTLY as below:
% Ex: CloseOrder('USD_MXN','longUnits','1000')
% Ex: CloseOrder('EUR_USD','shortUnits','ALL')
%% API Call
RawOrderInfo = CloseOrder(oapi,pair,long_short,units);
%% Error Checking and Report Assignment
if isfield(RawOrderInfo,'code')
    orderInfo = RawOrderInfo;
    fprintf('OANDA ERROR:\ncode: %s\n%s\n',num2str(orderInfo.code),orderInfo.message);
    return
end
%% Output Assignment
if long_short == "longUnits"
    orderInfo = RawOrderInfo.longOrderFillTransaction.price; %outputs price sold
else
    orderInfo = RawOrderInfo.shortOrderFillTransaction.price; %outputs price bought
end
