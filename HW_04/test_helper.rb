require 'minitest/pride'

# rubocop:disable all
class HW4Runner
  class << self
    def call
      tasks_range.each do |task_number|
        next unless path_for_task(task_number)
        require path_for_task(task_number)
      end
      require File.join('.', File.dirname(__FILE__), "/specs/main_spec.rb")
    end

    private

    def tasks_range
      (1..4).to_a(&:to_s)
    end

    def path_for_task(number)
      regexp = Regexp.new("hw_04_t_0#{number}")
      exclude_maks_regexp = Regexp.new("maksim_holubeu")
      Dir[File.join('.', '**/*.rb')].select { |f| f.match?(regexp) && !f.match?(exclude_maks_regexp) }.last
    end
  end
end
# rubocop:enable all

HW4Runner.call
