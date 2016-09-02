defmodule RateMyBeard.Vote do
  use RateMyBeard.Web, :model

  schema "votes" do
    field :ip_address, :string

    belongs_to :entry, RateMyBeard.Entry

    timestamps
  end

  
end
