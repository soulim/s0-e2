dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(dir) unless $LOAD_PATH.include? dir

require 'rubygems'
require 'cinch'
require 'digger'

class DiggBot
  def initialize
    @digger = Digger::Api.new
    @bot    = Cinch.setup do 
      server    'irc.freenode.org'
      nick      'diggbot'
      username  'diggbot'
    end

    @bot.on(376) do |m|
      @bot.join '#rmu-session-0', 'zerowing'
    end

    @bot.plugin("digg top stories") do |m|
      m.answer  self.top_stories || "No results found"
    end

    @bot.plugin("digg containers") do |m|
      m.answer self.containers || "No results found"
    end

    @bot.plugin("digg hot stories in :container") do |m|
      m.answer self.hot_stories_from(m.args[:container]) || "No results found"
    end

    @bot.plugin("digg help") do |m|
      m.answer "Usage: !digg top stories #=> get top stories, !digg containers #=> list of all containers, !digg hot stories in [container_short_name] #=> list of hot stories from given container"
    end

    @bot.run
  end
  
  def top_stories(container = nil)
    @digger.story.getTop.options(:count => 3, :container => container).fetch.collect { |story| "'#{story.title}' ( #{story.href} )" }.join(', ')
  end
  
  def containers
    @digger.container.getAll.fetch.collect { |container| "'#{container.name}' (#{container.short_name})" }.join(', ')
  end
  
  def hot_stories_from(container = nil)
    @digger.story.getHot.options(:count => 3, :container => container).fetch.collect { |story| "'#{story.title}' ( #{story.href} )" }.join(', ')
  end
end