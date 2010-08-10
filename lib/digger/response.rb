module Digger
  class Response
    def initialize(data)
      @data = data
    end
    
    def parse
      if @data && @data['stories']
        @data['stories'].collect { |story| Story.new(story) }
      elsif @data && @data['topics']
        @data['topics'].collect { |topic| Topic.new(topic) }
      elsif @data && @data['containers']
        @data['containers'].collect { |container| Container.new(container) }
      else
        []
      end
    end
  end
  
  class Story
    attr_accessor :id, :link, :submit_date, :diggs, :comments, :title, :description,
                  :status, :media, :user, :topic, :container, :thumbnail, :href, :shorturl
    
    def initialize(data = nil)
      new_from_json(data) if data
    end
    
    private
    
    def new_from_json(data)
      %w(id link submit_date diggs comments title description status media href).each do |attribute|
        self.send("#{attribute}=", data[attribute]) if data[attribute]
      end
      self.user      = User.new(data['user']) if data['user']
      self.topic     = Topic.new(data['topic']) if data['topic']
      self.container = Container.new(data['container']) if data['container']
      self.thumbnail = Thumbnail.new(data['thumbnail']) if data['thumbnail']
      self.shorturl  = Shorturl.new(data['shorturl']) if data['shorturl']
    end
  end
  
  class User
    attr_accessor :name, :registered, :icon, :profileviews
    
    def initialize(data = nil)
      new_from_json(data) if data
    end
    
    private
    
    def new_from_json(data)
      %w(name registered icon profileviews).each do |attribute|
        self.send("#{attribute}=", data[attribute]) if data[attribute]
      end      
    end
  end

  class Topic
    attr_accessor :name, :short_name
    
    def initialize(data = nil)
      new_from_json(data) if data
    end
    
    private
    
    def new_from_json(data)
      %w(name short_name).each do |attribute|
        self.send("#{attribute}=", data[attribute]) if data[attribute]
      end      
    end
  end  

  class Container
    attr_accessor :name, :short_name
    
    def initialize(data = nil)
      new_from_json(data) if data
    end
    
    private
    
    def new_from_json(data)
      %w(name short_name).each do |attribute|
        self.send("#{attribute}=", data[attribute]) if data[attribute]
      end      
    end
  end  

  class Thumbnail
    attr_accessor :originalheight, :originalwidth, :src, :height, :width, :contentType
    
    def initialize(data = nil)
      new_from_json(data) if data
    end
    
    private
    
    def new_from_json(data)
      %w(originalheight originalwidth src height width contentType).each do |attribute|
        self.send("#{attribute}=", data[attribute]) if data[attribute]
      end      
    end
  end  

  class Shorturl
    attr_accessor :short_url, :view_count
    
    def initialize(data = nil)
      new_from_json(data) if data
    end
    
    private
    
    def new_from_json(data)
      %w(short_url view_count).each do |attribute|
        self.send("#{attribute}=", data[attribute]) if data[attribute]
      end      
    end
  end  

end