function orderInfo = MarketOrder(pair,units)
% Sends market order and returns receipt. Can extract price, orderID, etc
% Units should be integer format.
% Long: units = + , e.g. 100
% Short: units  = - , e.g. -100
%
% Ex: order.price = MarketOrder('EUR_USD',1000) - returns price filled
% (note char array - not float format)
% Ex: order.orderID = MarketOrder('USD_MXN',-533) - returns orderID
%% Input Organization
%% API Call
RawOrderInfo = MarketOrder(oapi,pair,units);
%% Error Checking and Report Assignment
if isfield(RawOrderInfo,'code')
    orderInfo = RawOrderInfo;
    fprintf('OANDA ERROR:\ncode: %s\n%s\n',num2str(orderInfo.code),orderInfo.message);
    return
end
%% Output Assignment
orderInfo = RawOrderInfo.orderFillTransaction;
%% Data Massaging
%add in function to write history to file
end
