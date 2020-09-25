defmodule Blog.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :text
      add :article_id, references(:articles, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:comments, [:article_id])
    create index(:comments, [:user_id])
  end
end
