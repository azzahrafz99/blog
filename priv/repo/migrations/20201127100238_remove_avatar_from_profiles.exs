defmodule Blog.Repo.Migrations.RemoveAvatarFromProfiles do
  use Ecto.Migration

  def change do
    alter table("profiles") do
      remove :avatar
    end
  end
end
