-module(jrpc_http_h_SUITE).

-behaviour(ct_suite).

-include_lib("common_test/include/ct.hrl").
-include_lib("stdlib/include/assert.hrl"). % Assertion macros for convenience

-export([all/0, groups/0, init_per_suite/1, end_per_suite/1, init_per_testcase/2,
         end_per_testcase/2]).
-export([jrpc_http_h/1]).

-spec all() -> [ct_suite:ct_test_def(), ...].
all() ->
    [jrpc_http_h].

-spec groups() -> [ct_suite:ct_group_def(), ...].
groups() ->
    [].

-spec init_per_suite(Config :: ct_suite:ct_config()) ->
                        NewConfig ::
                            ct_suite:ct_config() |
                            {skip, Reason :: term()} |
                            {skip_and_save, Reason :: term(), SaveConfig :: ct_suite:ct_config()}.
init_per_suite(Config) ->
    ok = file:set_cwd("../../../../test/test_app/src"),
    {ok, [_ | _]} = application:ensure_all_started(test_app),
    Config.

-spec end_per_suite(Config :: ct_suite:ct_config()) ->
                       term() | {save_config, SaveConfig :: ct_suite:ct_config()}.
end_per_suite(Config) ->
    ok = application:stop(test_app),
    Config.

-spec init_per_testcase(ct_suite:ct_testname(), ct_suite:ct_config()) ->
                           ct_suite:ct_config() | {fail, term()} | {skip, term()}.
init_per_testcase(_Name, Config) ->
    Config.

-spec end_per_testcase(ct_suite:ct_testname(), ct_suite:ct_config()) ->
                          term() | {fail, term()} | {save_config, ct_suite:ct_config()}.
end_per_testcase(_Name, _Config) ->
    ok.

%% =============================================================================
%% Test Cases
%% =============================================================================

-spec jrpc_http_h(ct_suite:ct_config()) -> ok | no_return().
jrpc_http_h(_Config) ->
    Res = jrpc:call(#{<<"module">> => <<"io">>,
                      <<"method">> => <<"format">>,
                      <<"params">> => [<<"\"~p~n\"">>, <<"[\"Hello World\"]">>]}),
    ?assertEqual(ok, Res).
