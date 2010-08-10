require 'net/http'
require 'json'
require 'cgi'
require 'digger/response'

module Digger
  class Request
    def initialize
      @options      = {}
      @method_parts = []
    end
    
    def options(params)
      @options.merge!(params) unless params.empty?
      self  
    end
    
    def method_missing(name,*args,&block)
      @method_parts << name
      self
    end
    
    def fetch
      response = make_request
      @options      = {}
      @method_parts = []
      Response.new(JSON.parse(response)).parse
    end
    
    private
    
    def make_request
      Net::HTTP.start(Digger::HOST, Digger::PORT) do |http|
        http.get(
          path,
          'User-Agent' => Digger::USER_AGENT,
          'Accept'     => Digger::RESPONSE_TYPE
        ).body
      end      
    end
    
    def path
      "/#{Digger::API_VERSION}/endpoint?method=#{@method_parts.join('.')}#{path_options}"
    end
    
    def path_options
      @options.inject("") do |options, (key, value)|
        options + "&#{key}=#{(value.kind_of?(String)) ? CGI.escape(value) : value}"
      end      
    end
  end
end