class BloodPressurePlotter
  require 'gnuplot'
  require 'csv'

  def initialize
    @dates = []
    @systolics = []
    @diastolics = []
    @pulses = []
  end

  def read_file
    CSV.foreach('pressure_measures.csv') do |date, systolic, diastolic, pulse|
      @dates << date
      @systolics << systolic
      @diastolics << diastolic
      @pulses << pulse
    end
  end

  def graph
    Gnuplot.open do |gp|
      Gnuplot::Plot.new(gp) do |plot|
        configure(plot)
        draw_lines(plot, @systolics, :systolic)
        draw_lines(plot, @diastolics, :diastolic)
        draw_lines(plot, @pulses, :pulse)
      end
    end
  end

  private

  def configure(plot)
    plot.title 'My blood pressure'
    plot.xlabel 'Time'
    plot.ylabel 'mmHg'
    plot.timefmt "'%Y-%m-%dT%H:%M:%S'"
    plot.xdata 'time'
    plot.format "x '%d/%m/%Y'"
    plot.set 'terminal postscript color eps enhanced font "Helvetica,13" size 16cm,8cm'
    plot.set 'grid ytics lc rgb "#bbbbbb" lw 1 lt 0'
    plot.set 'grid xtics lc rgb "#bbbbbb" lw 1 lt 0'
    plot.set 'offset "1,1,1,1"'
    plot.set "output 'measures_graph.ps'"
  end

  def draw_lines(plot, measures, type)
    plot.data << Gnuplot::DataSet.new([@dates, measures]) do |ds|
      ds.with = 'lines'
      ds.title = type.to_s.capitalize
      ds.using = '1:2'
    end

    plot.data << Gnuplot::DataSet.new([@dates, measures]) do |ds|
      ds.with = 'labels'
      ds.notitle
      ds.using = '1:2:(sprintf("%d", $2))'
    end
  end
end

plotter = BloodPressurePlotter.new
plotter.read_file
plotter.graph
