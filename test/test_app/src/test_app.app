{application,
 test_app,
 [{description, "Cowboy server for tests"},
  {vsn, "0.0.1"},
  {applications, [kernel, stdlib, cowboy]}%,
  %{mod, {test_app, []}}
  ]}.
