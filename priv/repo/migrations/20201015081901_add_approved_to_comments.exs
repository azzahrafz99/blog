defmodule Blog.Repo.Migrations.AddApprovedToComments do
  use Ecto.Migration

  def change do
    alter table(:comments) do
      add :approved, :boolean
    end
  end
end
