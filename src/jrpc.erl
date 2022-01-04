-module(jrpc).

-export([call/1]).

% jrpc:call(#{<<"module">> => <<"io">>, <<"method">> => <<"format">>,
%             <<"params">> => [<<"\"~p~n\"">>, <<"[\"Hello World\"]">>]}).

call(#{<<"module">> := Module0,
       <<"method">> := Method0,
       <<"params">> := Params0}) ->
    Module = binary_to_atom(Module0),
    Method = binary_to_atom(Method0),
    Params = transform_params(Params0),
    rpc:call(node(), Module, Method, Params).

% HELPERZZZ

transform_params(Params) ->
    [term(P) || P <- Params].

term(Binary) ->
    Expression = unicode:characters_to_list(<<Binary/binary, ".">>),
    {ok, Tokens, _} = erl_scan:string(Expression),
    {ok, Parsed} = erl_parse:parse_exprs(Tokens),
    {value, Result, _} = erl_eval:exprs(Parsed, []),
    Result.

%% HELPERS
%decode_error_code(Code) ->
    %case Code of

        %-32700 -> parse_error;
        %-32600 -> invalid_request;
        %-32601 -> method_not_found;
        %-32602 -> invalid_params;
        %-32603 -> internal_error;
        %-32000 -> binding_not_found;
        %-32001 -> invalid_response;
        %-32002 -> server_error
    %end.
