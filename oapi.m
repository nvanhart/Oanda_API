classdef oapi
     properties (Constant)
     accountId = 'XXX-XXX-XXXXXXX-XXX'
     token = 'Bearer kjfhjasfkjdsfljdlfdsfldfkjdlflsdfkld-dsfdsff'; %security/api key
     server = 'https://api-fxpractice.oanda.com/v3/';
         %live    : 'https://api-fxtrade.oanda.com/v3'
         %practice: 'https://api-fxpractice.oanda.com/v3'
     Auth_Header = [http_createHeader('Authorization',oapi.token)...
                    http_createHeader('Content-Type','application/json')...
                    http_createHeader('AcceptDatetimeFormat','UNIX')];
     end
     
     methods
         
%% GetAccountInfo         returns info associated with selected account
     function RawAccountInfo = GetAccountInfo(oapi,accountId)
         Path = ['accounts/',accountId,'/summary'];
         RawAccountInfo = loadjson(urlread2([oapi.server,Path],'GET','',oapi.Auth_Header));
     end
%% GetInstruments         returns tradable pairs
     function RawInstrumentData = GetInstruments(oapi,accountId)
         Path = ['accounts/',accountId,'instruments'];
         RawInstrumentData = loadjson(urlread2([oapi.server,Path],'GET','',oapi.Auth_Header));
     end
%% GetPriceHistory        returns volume, ohlc
     function RawHistory = GetPriceHistory(oapi,pairString,lookback,granularity)
         formatSpec = 'instruments/%s/candles?price=BA&from=%s&granularity=%s';
         Path = sprintf(formatSpec,pairString,lookback,granularity);
         RawHistory = loadjson(urlread2([oapi.server,Path],'GET','',oapi.Auth_Header));
     end
%% GetCurrentPrice        returns current bid/ask
     function RawPrice = GetCurrentPrice(oapi,pair)
          url = [oapi.server,'accounts/',oapi.accountId,'/pricing?instruments=',pair];
          options = weboptions('RequestMethod','get','HeaderFields',...      
                              {'Authorization' [oapi.token] ;'Content-Type' 'application/json'});
          RawPrice = webread(url,options);
     end
%% CompleteOrder          sends order w limit, stop loss, take profit
     function RawOrderInfo = CompleteOrder(oapi,pair,units,limit,stopLoss,takeProfit)
          url = [oapi.server,'accounts/',oapi.accountId,'/orders'];
          options = weboptions('RequestMethod','post','HeaderFields',...      
                              {'Authorization' [oapi.token] ;'Content-Type' 'application/json'});
          STL = struct('timeInForce','GTC','price',stopLoss);
          TP = struct('price',takeProfit);
          body = struct('price',limit,'stopLossOnFill',STL,'takeProfitOnFill',...
                        TP,'timeInForce','GTC','instrument',pair,'units',units,...
                        'type','LIMIT','positionFill','DEFAULT');
         body = struct('order',body);
         RawOrderInfo = webwrite(url,body,options);
     end
%% LimitOrder             sends limit order
     function RawOrderInfo = LimitOrder(oapi,pair,units,limit)
          url = [oapi.server,'accounts/',oapi.accountId,'/orders'];
          options = weboptions('RequestMethod','post','HeaderFields',...      
                              {'Authorization' [oapi.token] ;'Content-Type' 'application/json'});
          body = struct('price',limit,'timeInForce','GTC','instrument',pair,...
                        'units',units,'type','LIMIT','positionFill','DEFAULT');
          body = struct('order',body);
          RawOrderInfo = webwrite(url,body,options);
     end
%% MarketOrder            sends market order
     function RawOrderInfo = MarketOrder(oapi,pair,units)
          url = [oapi.server,'accounts/',oapi.accountId,'/orders'];
          options = weboptions('RequestMethod','post','HeaderFields',...      
                              {'Authorization' [oapi.token] ;'Content-Type' 'application/json'});
          body = struct('units',units,'instrument',pair,'timeInForce',...
                        'FOK','type','MARKET','positionFill','DEFAULT');
          body = struct('order',body);
          RawOrderInfo = webwrite(url,body,options);
     end
%% CloseOrder            sends close/take profit order
     function RawOrderInfo = CloseOrder(oapi,pair,long_short,units)
           url = [oapi.server,'accounts/',oapi.accountId,'/positions/',pair,'/close'];
           options = weboptions('RequestMethod','put','HeaderFields',...      
                               {'Authorization' [oapi.token] ;'Content-Type' 'application/json'});
           body = struct(long_short,units);
           RawOrderInfo = webwrite(url,body,options);
     end
%% GetTradeInfo           returns p/l on trade
     function RawTradeInfo = GetTradeInfo(oapi,tradeID)
           url = [oapi.server,'accounts/',oapi.accountId,'/transactions/',tradeID];
           options = weboptions('RequestMethod','get','HeaderFields',...      
                               {'Authorization' [oapi.token] ;'Content-Type' 'application/json'});
           RawTradeInfo = webread(url,options);
     end
%% 
     end
end
       