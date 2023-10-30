# frozen_string_literal: true

# class my first job
class MyFirstJob
  include Sidekiq::Job

  def perform
    puts 'I am , running my first job at '
  end
end
