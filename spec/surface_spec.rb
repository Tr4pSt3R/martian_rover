RSpec.describe Surface do
  describe 'validations' do
    describe 'invalid arguments' do
      context 'when I initialise with x coordinate of nil' do
        let(:x) { nil }
        let(:y) { 3 }

        it 'should raise an error' do
          expect do
            Surface.new(x: x, y: y)
          end.to raise_error(Surface::BlackHoleError)
        end
      end

      context 'when I initialise with y coordinate of nil' do
        let(:x) { 5 }
        let(:y) { nil }

        it 'should raise an error' do
          expect do
            Surface.new(x: x, y: y)
          end.to raise_error(Surface::BlackHoleError)
        end
      end

      context 'when I initialise with x coordinate of zero' do
        let(:x) { 0 }
        let(:y) { 3 }

        it 'should raise an error' do
          expect do
            Surface.new(x: x, y: y)
          end.to raise_error(Surface::BlackHoleError)
        end
      end

      context 'when I initialise with y coordinate of zero' do
        let(:x) { 5 }
        let(:y) { 0 }

        it 'should raise an error' do
          expect do
            Surface.new(x: x, y: y)
          end.to raise_error(Surface::BlackHoleError)
        end
      end

      context 'when I initialise with value for x above 50' do
        it 'should throw an error' do
          expect do
            Surface.new(x: 55, y: 5)
          end.to raise_error(
            Surface::CoordinateTooLarge
          ).with_message('The maximum value for any coordinate is 50')
        end
      end

      context 'when I initialise with value for y above 50' do
        it 'should throw an error' do
          expect do
            Surface.new(x: 5, y: 55)
          end.to raise_error(
            Surface::CoordinateTooLarge
          ).with_message('The maximum value for any coordinate is 50')
        end
      end
    end

    describe 'valid arguments' do
      context 'when I initialise with value for x below 50' do
        it 'should be valid' do
          Surface.new(x: 45, y: 35)

          expect { Surface.new(x: 35, y: 25) }.not_to raise_error(
            Surface::CoordinateTooLarge
          )
        end
      end
    end
  end
end
