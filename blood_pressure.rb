class BloodPressureLogger
  require 'date'
  require 'csv'

  def initialize(systolic, diastolic, pulse)
    @systolic = systolic
    @diastolic = diastolic
    @pulse = pulse
  end

  def check_argvs
    fail 'Argument missing!' unless ARGV.count == 3
  end

  def print_log
    puts "Systolic value added: #{@systolic}"
    puts "Diastolic value added: #{@diastolic}"
    puts "Pulse value added: #{@pulse}"
  end

  def save_in_file
    CSV.open('pressure_measures.csv', 'a') do |csv|
      csv << ["#{DateTime.now}", "#{@systolic}", "#{@diastolic}", "#{@pulse}"]
    end
  end
end

logger = BloodPressureLogger.new(ARGV[0], ARGV[1], ARGV[2])
logger.check_argvs
logger.save_in_file
logger.print_log
