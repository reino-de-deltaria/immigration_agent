defmodule ImmigrationAgent do
  import Application
  use Supervisor
  import Cachex.Spec

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Consumer, []),
      worker(Mongo, [[
        name: :mongo,
        database: get_env(:mongodb, :database),
        hostname: get_env(:mongodb, :hostname),
        username: get_env(:mongodb, :username),
        password: get_env(:mongodb, :password),
        pool: DBConnection.Poolboy
      ]]),
      worker(Cachex, [ :cache, [
        expiration: expiration(default: :timer.minutes(1)),
        limit: limit(size: 500, policy: Cachex.Policy.LRW, reclaim: 0.5)
      ]])
    ]

    opts = [strategy: :one_for_one, name: ImmigrationAgent.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
