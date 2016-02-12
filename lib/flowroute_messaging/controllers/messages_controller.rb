# This file was automatically generated for flowroute by APIMATIC BETA v2.0 on 02/12/2016

module FlowrouteMessaging
  class MessagesController

    # Initializer with authentication and configuration parameters
    def initialize(username, password)
        @username = username;
        @password = password;
    end

    # Send a message
    # @param [Message] message Required parameter: Message Object to send.
    # @return String response from the API call
    def create_message message
      # the base uri for api requests
      query_builder = Configuration.BASE_URI.dup

      # prepare query string for API call
      query_builder << "/messages"

      # validate and preprocess url
      query_url = APIHelper.clean_url query_builder

      # prepare headers
      headers = {
        "user-agent" => "Flowroute Messaging SDK 1.0",
        "content-type" => "application/json; charset=utf-8"
      }

      # invoke the API call request to fetch the response
      response = Unirest.post query_url, headers:headers, parameters:message.to_json, auth:{ :user => @username, :password => @password }

      # Error handling using HTTP status codes
      if response.code == 401
        raise APIException.new "UNAUTHORIZED", 401, response.raw_body
      elsif response.code == 403
        raise APIException.new "FORBIDDEN", 403, response.raw_body
      elsif !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code, response.raw_body
      end

      response.body
    end

    # Lookup a Message by MDR
    # @param [String] record_id Required parameter: Unique MDR ID
    # @return String response from the API call
    def get_message_lookup record_id
      # the base uri for api requests
      query_builder = Configuration.BASE_URI.dup

      # prepare query string for API call
      query_builder << "/messages/{record_id}"

      # process optional query parameters
      query_builder = APIHelper.append_url_with_template_parameters query_builder, {
        "record_id" => record_id,
      }

      # validate and preprocess url
      query_url = APIHelper.clean_url query_builder

      # prepare headers
      headers = {
        "user-agent" => "Flowroute Messaging SDK 1.0"
      }

      # invoke the API call request to fetch the response
      response = Unirest.get query_url, headers:headers, auth:{ :user => @username, :password => @password }

      #Error handling using HTTP status codes
      if !(response.code.between?(200,206)) # [200,206] = HTTP OK
        raise APIException.new "HTTP Response Not OK", response.code, response.raw_body
      end

      response.body
    end

  end
end