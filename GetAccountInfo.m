function AccountInfo = GetAccountInfo(accountId)
% Returns the account information for the supplied accountId
%% Input Organization
if nargin == 0
    accountId = oapi.accountId;
end
%% API Call
RawAccountInfo = GetAccountInfo(oapi,accountId);
%% Error Checking and Report Assignment
if isfield(RawAccountInfo,'code')
    AccountInfo = RawAccountInfo;
    fprintf('OANDA ERROR:\ncode: %s\n%s\n',num2str(AccountInfo.code),AccountInfo.message);
    return
end
%% Output Assignment
AccountInfo = RawAccountInfo;
end