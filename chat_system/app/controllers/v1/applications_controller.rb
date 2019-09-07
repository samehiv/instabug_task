module V1
  class ApplicationsController < ApiController
    before_action :set_application, only: %i[show update destroy]

    def index
      @data = Pagination.serialize(Application, params[:page], params[:per_page])
    end

    def show; end

    def create
      application = Application.create!(application_params)

      render_json(200, data: { token: application.token })
    end

    def update
      @application.update!(application_params)

      render_json(200)
    end

    def destroy
      @application.destroy

      render_json(200)
    end

    private

    def application_params
      params.permit(:name)
    end

    def set_application
      @application = Application.find_by!(token: params[:token])
    end
  end
end
