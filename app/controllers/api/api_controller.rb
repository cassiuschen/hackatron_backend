module Api
  class ApiController< ActionController::Metal
    abstract!

    MODULES = [
        AbstractController::Rendering,

        ActionController::Helpers,
        ActionController::HideActions,
        ActionController::UrlFor,
        ActionController::Redirecting,
        ActionView::Layouts,
        ActionController::Head,
        ActionController::Rendering,
        ActionController::Renderers::All,
        ActionController::ConditionalGet,
        ActionController::RackDelegation,
        ActionController::Caching,
        ActionController::MimeResponds,
        ActionController::ImplicitRender,
        ActionController::StrongParameters,

        # Before callbacks should also be executed the earliest as possible, so
        # also include them at the bottom.
        AbstractController::Callbacks,

        # Append rescue at the bottom to wrap as much as possible.
        ActionController::Rescue,

        # Add instrumentations hooks at the bottom, to ensure they instrument
        # all the methods properly.
        ActionController::Instrumentation,

        # Params wrapper should come before instrumentation so they are
        # properly showed in logs
        ActionController::ParamsWrapper,

        Rails.application.routes.url_helpers
    ]

    MODULES.each do |mod|
      include mod
    end

    ActiveSupport.run_load_hooks(:action_controller, self)

    rescue_from Mongoid::Errors::DocumentNotFound do
      head :not_found
    end
  end
end