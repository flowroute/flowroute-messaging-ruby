# This file was automatically generated for flowroute by APIMATIC BETA v2.0 on 02/12/2016

module FlowrouteMessaging
  class Message

    # Phone number in E.164 format to send a message to.
    # @return [String]
    attr_accessor :to

    # Phone number in E.164 format where the message is sent from.
    # @return [String]
    attr_accessor :from

    # The content of the message.
    # @return [String]
    attr_accessor :content

    def initialize(to, from, content)
        @to = to
        @from = from
        @content = content
    end
    
    def method_missing (method_name)
      puts "there's no method called '#{method_name}'"
    end

    # Creates JSON of the curent object  
    def to_json
      hash = self.key_map()
      hash.to_json
    end

    # Defines the key map for json serialization  
    def key_map
      hash = {}
      hash['to'] = self.to
      hash['from'] = self.from
      hash['content'] = self.content
      hash
    end

  end
end