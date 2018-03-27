require './lib/blood_pressure'

describe BloodPressureLogger do
  describe '#check_argvs' do
    
    let(:systolic) { 120 }
    let(:diastolic) { 80 }
    let(:pulse) { 60 }
    
    context 'when argvs are less than three' do
      subject { described_class.new(systolic, diastolic) }
      
      
      it 'shows argument missing error' do
        expect{subject.check_argvs}.to raise_error(ArgumentError)
        # expect(error.message).to eq('Argument missing!')
      end
    end
  end
end