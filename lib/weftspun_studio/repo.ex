# SPDX-License-Identifier: MIT
# Copyright (c) 2026 K. S. Ernest (iFire) Lee

defmodule WeftspunStudio.Repo do
  @moduledoc """
  The database connection for the studio core.

  RFD 0020 selected the V-Sekai CockroachDB build and RFD 0067 kept
  it. Both are retracted, and `cockroach-local` is archived, so the
  store is a SQLite file this service owns outright.

  The natural keys stay. They were adopted because CockroachDB gives
  no gap free `SERIAL`, and they are still the right shape: a catalog
  fact has a natural key, so an integer id would be a second name for
  the same row.

  `migration_lock: false` is gone. It existed for CockroachDB's
  missing advisory lock, and that constraint left with the database.
  """

  use Ecto.Repo,
    otp_app: :weftspun_studio,
    adapter: Ecto.Adapters.SQLite3

  @doc "True when the pool holds a live connection."
  @spec up?() :: boolean()
  def up? do
    case Process.whereis(__MODULE__) do
      nil ->
        false

      _pid ->
        # query/2 answers with a tuple, thus this needs no rescue. A
        # refused connection is the answer to "is the pool up?", and
        # not an exception to catch.
        match?({:ok, _result}, query("SELECT 1", []))
    end
  end
end
