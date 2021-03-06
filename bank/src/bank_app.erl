-module(bank_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% Application callbacks

start(_StartType, _StartArgs) ->
	bank_event_store:init(),
    bank_read_store:init(),
	keypid:init(),

    case bank_sup:start_link() of
        {ok, Pid} ->
            bank_command_handler:add_handler(),
            bank_event_handler:add_handler(),
            {ok, Pid};
        Other ->
            {error, Other}
    end.

stop(_State) ->
    ok.
