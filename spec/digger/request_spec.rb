require 'spec_helper'

module Digger
  describe Request do
    subject { Request.new }
    
    describe '#fetch' do
      before(:each) do
        Net::HTTP.stub!(:start)
        JSON.stub!(:parse)
      end
      
      it 'makes request to digg.com' do
        Net::HTTP.should_receive(:start)
        subject.fetch
      end
      
      it 'uses digg\'s host and port from Digger module' do
        Net::HTTP.should_receive(:start).with(Digger::HOST, Digger::PORT)
        subject.fetch
      end
      
      it 'parses respose from digg.com' do
        JSON.should_receive(:parse)
        subject.fetch
      end
    end    
  end
end