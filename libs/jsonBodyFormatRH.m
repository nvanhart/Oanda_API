function jsonout = jsonBodyFormatRH(username,password,clientID)
%formats RH body string to json
params = {'username'};
params = [params,{username}];
params = [params,{'password'}];
params = [params,{password}];
params = [params,{'grant_type'},{'password'},{'scope'},{'internal'},...
         {'expires_in'},{'3600'},{'client_id'}]; %may need to remove scope & expires_in
params = [params,{clientID}];
[query,unusedHeaderOutput] = http_paramsToString(params,1); %correct urlread2 header already added
jsonout = query;