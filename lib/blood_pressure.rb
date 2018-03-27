require 'date'
require 'csv'

class BloodPressureLogger
  def initialize(systolic, diastolic, pulse)
    @systolic = systolic
    @diastolic = diastolic
    @pulse = pulse
  end

  def check_argvs
    fail 'Argument missing!' unless ARGV.count == 3
  end

  def print_log
    print_meassure('Systolic', @systolic)
    print_meassure('Diastolic', @diastolic)
    print_meassure('Pulse', @pulse)
  end

  def save_in_file
    CSV.open('pressure_measures.csv', 'a') do |csv|
      csv << ["#{DateTime.now}", "#{@systolic}", "#{@diastolic}", "#{@pulse}"]
    end
  end

  private
  def print_meassure(type, value)
    puts "#{type} value added: #{value}"
  end
end

logger = BloodPressureLogger.new(ARGV[0], ARGV[1], ARGV[2])
logger.check_argvs
logger.save_in_file
logger.print_log
