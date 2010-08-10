require 'digger/request'

module Digger
  class Api
    %w(story topic container).each do |method|
      define_method(method) do |*args|
        request = Request.new
        request.send(method, *args)
      end
    end
  end
end