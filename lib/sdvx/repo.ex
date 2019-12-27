defmodule Sdvx.Repo do
  use Ecto.Repo,
    otp_app: :sdvx,
    adapter: Ecto.Adapters.Postgres
end
