defmodule Blog.Repo.Migrations.AddBioToProfile do
  use Ecto.Migration

  def change do
    alter table(:profiles) do
      add :bio, :text
    end
  end
end
