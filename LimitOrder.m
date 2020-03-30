function orderInfo = LimitOrder(pair,units,limit)
% Sends limit order.
%
% Ex: LimitOrder('USD_MXN','1000','19.000')
%% Input Organization
%% API Call
RawOrderInfo = LimitOrder(oapi,pair,units,limit);
%% Error Checking and Report Assignment
if isfield(RawOrderInfo,'code')
    orderInfo = RawOrderInfo;
    fprintf('OANDA ERROR:\ncode: %s\n%s\n',num2str(orderInfo.code),orderInfo.message);
    return
end
%% Output Assignment
orderInfo = RawOrderInfo.orderCreateTransaction
%% Data Massaging
%add in function to write history to file
end
