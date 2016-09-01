defmodule RateMyBeard.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entry) do
      add :title, :string
      add :image, :string
      add :up_votes, :integer
      add :down_votes, :integer

      timestamps
    end
  end
end
