defmodule RateMyBeard.Repo.Migrations.CreateVotes do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add :ip_address, :string
      add :entry_id, references(:entry)

      timestamps
    end
  end
end
