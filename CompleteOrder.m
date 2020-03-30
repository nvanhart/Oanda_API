function orderInfo = CompleteOrder(pair,units,limit,stopLoss,takeProfit)
% Sends full order. Requires limit price, stop loss, and take profit.
% 
% Ex: completeOrder('USD_MXN','-1000','19.5335','19.9','19.1')
%% Input Organization
%% API Call
RawOrderInfo = CompleteOrder(oapi,pair,units,limit,stopLoss,takeProfit);
%% Error Checking and Report Assignment
if isfield(RawOrderInfo,'code')
    orderInfo = RawOrderInfo;
    fprintf('OANDA ERROR:\ncode: %s\n%s\n',num2str(orderInfo.code),orderInfo.message);
    return
end
%% Output Assignment
orderInfo = RawOrderInfo
%% Data Massaging
%add in function to write history to file
end
