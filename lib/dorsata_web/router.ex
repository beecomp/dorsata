defmodule DorsataWeb.Router do
  use DorsataWeb, :router

  import DorsataWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {DorsataWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  use Kaffy.Routes, scope: "/admin", pipe_through: [:browser, :require_authenticated_user]

  scope "/", DorsataWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", DorsataWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:dorsata, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: DorsataWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", DorsataWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{DorsataWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", DorsataWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{DorsataWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end
  end

  scope "/", DorsataWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{DorsataWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new

      live "/championships", ChampionshipLive.Index, :index
      live "/championships/new", ChampionshipLive.Index, :new
      live "/championships/:id/edit", ChampionshipLive.Index, :edit

      live "/championships/:id", ChampionshipLive.Show, :show
      live "/championships/:id/show/edit", ChampionshipLive.Show, :edit

      live "/rounds", RoundLive.Index, :index
      live "/rounds/new", RoundLive.Index, :new
      live "/rounds/:id/edit", RoundLive.Index, :edit

      live "/rounds/:id", RoundLive.Show, :show
      live "/rounds/:id/show/edit", RoundLive.Show, :edit

      live "/submissions", SubmissionLive.Index, :index
      live "/submissions/new", SubmissionLive.Index, :new
      live "/submissions/:id/edit", SubmissionLive.Index, :edit

      live "/submissions/:id", SubmissionLive.Show, :show
      live "/submissions/:id/show/edit", SubmissionLive.Show, :edit
    end
  end
end
