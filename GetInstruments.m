function Instruments = GetInstruments(accountId)
% Returns a list of all tradable instruments for the specified account
%% Input Organization
if nargin == 0
    accountId = oapi.accountId;
end
%% API Call
RawInstrumentData = GetInstruments(oapi,accountId);
%% Error Checking and Report Assignment
if isfield(RawInstrumentData,'code')
    Instruments = RawInstrumentData;
    fprintf('OANDA ERROR:\ncode: %s\n%s\n',num2str(Instruments.code),Instruments.message);
    return
end
%% Output Assignment
Intruments = RawInstrumentData
%InstrumentData = (RawInstrumentData.instruments)';
%Instruments = cell(length(InstrumentData),1);
%for ii = 1:length(InstrumentData)
%    Instruments{ii} = InstrumentData{ii}.instrument;
%end
end 