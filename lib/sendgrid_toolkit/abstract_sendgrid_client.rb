module SendgridToolkit
  class AbstractSendgridClient

    def initialize(api_user = nil, api_key = nil)
      @api_user = api_user || SendgridToolkit.api_user || ENV['SMTP_USERNAME']
      @api_key = api_key || SendgridToolkit.api_key || ENV['SMTP_PASSWORD']

      raise SendgridToolkit::NoAPIUserSpecified if @api_user.nil? || @api_user.length == 0
      raise SendgridToolkit::NoAPIKeySpecified if @api_key.nil? || @api_key.length == 0
    end

    protected

    def api_post(module_name, action_name, opts = {})
      #logger.debug "https://#{BASE_URI}/#{module_name}.#{action_name}.json?"
      response = HTTParty.post("https://#{BASE_URI}/#{module_name}.#{action_name}.json?", :query => get_credentials.merge(opts), :format => :json)
      if response.code > 401
        raise(SendgridToolkit::SendgridServerError, "The Sendgrid server returned an error. #{response.inspect}")
      elsif has_error?(response) and
          response['error'].respond_to?(:has_key?) and
          response['error'].has_key?('code') and
          response['error']['code'].to_i == 401
        raise SendgridToolkit::AuthenticationFailed
      elsif has_error?(response)
        raise(SendgridToolkit::APIError, response['error'])
      end
      response
    end

    def apiv2_post(module_name, action_name, opts = {})
      #logger "POST https://#{BASE_URI_V2}/#{module_name}.#{action_name}.json?"
      response = HTTParty.get("https://#{BASE_URI_V2}/#{module_name}.#{action_name}.json?", :query => get_credentials.merge(opts), :format => :json)
      if response.code > 401
        raise(SendgridToolkit::SendgridServerError, "The Sendgrid server returned an error. #{response.inspect}")
      elsif has_error?(response) and
          response['error'].respond_to?(:has_key?) and
          response['error'].has_key?('code') and
          response['error']['code'].to_i == 401
        raise SendgridToolkit::AuthenticationFailed
      elsif has_error?(response)
        raise(SendgridToolkit::APIError, response['error']['message'])
      end
      response
    end

    def apiv2_get(module_name, opts = {})

    end


    def get_credentials
      {:api_user => @api_user, :api_key => @api_key}
    end

    private
    def has_error?(response)
      response.kind_of?(Hash) && response.has_key?('error')
    end
  end
end
