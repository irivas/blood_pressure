require './lib/blood_pressure'

describe BloodPressureLogger do
  let(:systolic) { 120 }
  let(:diastolic) { 80 }
  let(:pulse) { 60 }

  describe '#check_argvs' do
    context 'when argvs are less than three' do
      subject { described_class.new(systolic, diastolic) }
      
      it 'shows argument missing error' do
        expect{subject.check_argvs}.to raise_error(ArgumentError)
      end
    end

    context 'when argvs are three' do
      subject { described_class.new(systolic, diastolic, pulse) }
      
      it 'does not show argument missing error' do
        expect{subject.check_argvs}.not_to raise_error
      end
    end
  end

  describe '#print_log' do
    context 'when having the correct data' do
      subject { described_class.new(systolic, diastolic, pulse) }
      let(:systolic_message) { "Systolic value added: #{systolic}" }
      let(:diastolic_message) { "Diastolic value added: #{diastolic}" }
      let(:pulse_message) { "Pulse value added: #{pulse}" }

      it 'prints the correct message' do
        expect{subject.print_log}.to output("#{systolic_message}\n#{diastolic_message}\n#{pulse_message}\n").to_stdout
      end
    end
  end
end