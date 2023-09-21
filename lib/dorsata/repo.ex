defmodule Dorsata.Repo do
  use Ecto.Repo,
    otp_app: :dorsata,
    adapter: Ecto.Adapters.Postgres
end
