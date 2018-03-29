require './lib/blood_pressure'

describe BloodPressureLogger do
  let(:systolic) { 120 }
  let(:systolic_2) { 125 }
  let(:diastolic) { 80 }
  let(:diastolic_2) { 85 }
  let(:pulse) { 60 }
  let(:pulse_2) { 65 }

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
      let(:systolic_message) { "Systolic value added: #{systolic}" }
      let(:diastolic_message) { "Diastolic value added: #{diastolic}" }
      let(:pulse_message) { "Pulse value added: #{pulse}" }
      
      subject { described_class.new(systolic, diastolic, pulse) }

      it 'prints the correct message' do
        expect{subject.print_log}.to output("#{systolic_message}\n#{diastolic_message}\n#{pulse_message}\n").to_stdout
      end
    end
  end
  
  describe '#save_in_file' do
    context 'when having the correct data' do
      let(:file) { 'pressure_measures.csv' }
      
      subject { described_class.new(systolic_2, diastolic_2, pulse_2) }

      before { subject.save_in_file }
      
      it 'writes the proper data in file' do
        lines = File.open(file).to_a
        row = CSV.parse_line(lines.last.scrub(''), col_sep: ',')
    
        expect(row.drop(1)).to eq([systolic_2.to_s, diastolic_2.to_s, pulse_2.to_s])  
      end
    end
  end
end
