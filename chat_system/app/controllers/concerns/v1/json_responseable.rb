module V1
  module JsonResponseable
    extend ActiveSupport::Concern

    included do
      helper_method :render_response

      rescue_from StandardError, with: :server_error_response
      rescue_from ActiveRecord::RecordInvalid, with: :validation_error_response
      rescue_from ActionController::ParameterMissing, with: :parameter_missing_error_response
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_error_response
    end

    def render_response(json, code, message = '')
      code = status_code(code)
      json.code code
      json.status 'success'
      json.data do
        yield if block_given?
      end
      json.message message
      json.error ''
      json.errors []
    end

    def render_json(code, options = {})
      default_options = { data: [], message: '', error: '', errors: [] }
      code = status_code(code)
      options = default_options.merge(options)

      if code.to_s.start_with?('2')
        render json: { code: code, status: 'success' }.merge(options)
      else
        render json: { code: code, status: 'error' }.merge(options)
      end
    end

    private

    def status_code(code)
      code.is_a?(Symbol) ? Rack::Utils::SYMBOL_TO_STATUS_CODE[code] : code
    end

    private

    def validation_error_response(exception)
      errors = exception.record.errors.full_messages
      render_json 422, error: 'Validation failed', errors: errors
    end

    def parameter_missing_error_response(exception)
      render_json 422, error: 'Validation failed', errors: exception.message
    end

    def record_not_found_error_response(exception)
      render_json 404, error: exception.message
    end

    def server_error_response(exception)
      bc = ActiveSupport::BacktraceCleaner.new
      bc.add_filter   { |line| line.gsub(Rails.root.to_s, '') }
      bc.add_silencer { |line| line =~ /puma|rubygems|gems/ }
      render_json 500, error: exception.message, errors: bc.clean(exception.backtrace)
    end
  end
end
