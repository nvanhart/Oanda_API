function pl = GetTradeInfo(tradeID)
% Returns the pl or exit price for the trade. 
% Example: GetTradeInfo('665')
%
%% API Call
try
RawInfo = GetTradeInfo(oapi,tradeID);
catch 
    pl = 'N/A';
end

%% Error Checking and Report Assingment
if isfield(RawInfo,'code')
    pl = RawInfo;
    fprintf('OANDA ERROR:\ncode: %s\n%s\n',num2str(pl.code),pl.message);
    return
end

%% Convert structure to vector
pl = RawInfo.transaction
fp = RawInfo.transaction.tradesClosed

end