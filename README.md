jrpc
=====

An OTP application

Build
-----

    $ rebar3 compile

```
jrpc:call(#{<<"module">> => <<"io">>, <<"method">> => <<"format">>,
            <<"params">> => [<<"\"~p~n\"">>, <<"[\"Hello World\"]">>]}).
```
