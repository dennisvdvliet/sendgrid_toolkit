module SendgridToolkit
  class Subusers < AbstractSendgridClient
    def add(options = {})
      response = apiv2_post('customer', 'add', options)
      response
    end
    
    # def delete(options = {})
    #   response = api_post('unsubscribes', 'delete', options)
    #   raise UnsubscribeEmailDoesNotExist if response['message'].include?('does not exist')
    #   response
    # end
    

    def retrieve(options = {})
      options = options.merge({:task => 'get'})
      response = apiv2_post('customer', 'profile', options)
      response
    end

    def limit(options = {})
      response = apiv2_post('customer', 'limit', options)
      response
    end

    def ip(options = {})
      response = apiv2_post('customer', 'ip', options)
      response
    end
    
    def sendip(options = {})
      response = apiv2_post('customer', 'sendip', options)
      response
    end

    def auth(options = {})
      response = apiv2_post('customer', 'auth', options)
      response
    end

    def eventposturl(options = {} )
      response = apiv2_post('customer', 'eventposturl', options)
      response
    end

    def apps(options = {} )
      response = apiv2_post('customer', 'apps', options)
      response
    end
    # def retrieve_with_timestamps(options = {})
    #   options.merge! :date => 1
    #   response = retrieve options
    #   response.each do |unsubscribe|
    #     unsubscribe['created'] = Time.parse(unsubscribe['created']) if unsubscribe.has_key?('created')
    #   end
    #   response
    # end
  end
end