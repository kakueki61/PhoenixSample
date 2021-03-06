# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SimpleAuth.Repo.insert!(%SimpleAuth.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will halt execution if something goes wrong.

alias SimpleAuth.Repo
alias SimpleAuth.User

admin_params = %{ name: "Admin User",
                  email: "admin@test.com",
                  password: "supersecret",
                  is_admin: true }

unless Repo.get_by(User, email: admin_params[:email]) do
  %User{}
  |> User.registration_changeset(admin_params)
  |> Repo.insert!
end
