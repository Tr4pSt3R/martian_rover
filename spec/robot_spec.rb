require_relative '../lib/robot'
require_relative '../lib/surface'

RSpec.describe Robot do
  describe 'bad orientartion' do
    context 'when orientation is set as 3' do
      it 'throws an error' do
        expect do
          Robot.new(x: 0, y: 0, orientation: 3)
        end.to raise_error(Robot::InvalidOrientation)
      end
    end
  end

  describe 'forever lost' do
    let(:surface) { Surface.new(x: 1, y: 1) }

    subject(:robot) do
      Robot.new(x: 0, y: 0, orientation: 'N', surface: surface)
    end

    before do
      robot.perform instructions
    end

    context 'when robot moves off the far-western edge' do
      let(:instructions) { 'LFF' }

      it 'returns last grid position' do
        expect(robot.position).to match(/0 0 W LOST/)
      end
    end

    context 'when robot moves off the far-eastern edge' do
      let(:instructions) { 'RFF' }

      it 'returns last grid position' do
        expect(robot.position).to match(/1 0 E LOST/)
      end
    end

    context 'when robot moves off the northern edge' do
      let(:instructions) { 'FF' }

      it 'returns last grid position' do
        expect(robot.position).to match(/0 1 N LOST/)
      end
    end

    context 'when robot moves off the southern edge' do
      let(:instructions) { 'RRF' }

      it 'returns last grid position' do
        expect(robot.position).to match(/0 0 S LOST/)
      end
    end
  end

  describe 'final coordinates' do
    let(:surface) { Surface.new(x: 1, y: 1) }
    let(:robot) { Robot.new(x: 0, y: 0, orientation: 'N', surface: surface) }

    context 'when no move instructions are given' do
      it 'returns the initial position and coordinates of the robot' do
        robot.perform

        expect(robot.position).to match(/0 0 N/)
      end
    end
  end

  describe 'exploration' do
    let(:surface) { Surface.new(x: 1, y: 1) }
    let(:robot) do
      Robot.new(x: 0, y: 0, orientation: 'N', surface: surface)
    end

    describe 'movement' do
      context 'when surface has space' do
        let(:surface) { Surface.new(x: 4, y: 4) }

        context 'when robot moves up' do
          it 'permits movement to coordinate' do
            robot.perform('F')

            expect(robot.position).to eq('0 1 N')
          end
        end
      end
    end

    describe 'rotation' do
      context 'when robot is facing north(N)' do
        context 'when I rotate left(L)' do
          it 'should face West(W)' do
            robot = Robot.new(x: 0, y: 0, orientation: 'N')
            robot.left!

            expect(robot.orientation).to eq('W')
          end
        end
      end
    end

    describe 'dangerous spots' do
      let(:surface) { Surface.new(x: 1, y: 1) }
      let(:robot) { Robot.new(x: 0, y: 0, orientation: 'N', surface: surface) }

      context 'when another robot has fallen here' do
        it 'should ignore instruction to move forward here' do
          robot.perform('LFRF')

          expect(robot.position).to match(/0 1 N/)
        end
      end
    end

    describe 'instruction set' do
      context 'when more than 100' do
        it 'should raise an alarm' do
          surface = Surface.new(x: 5, y: 5)
          robot = Robot.new(x: 5, y: 3, orientation: 'N', surface: surface)

          crazy_instruction = []
          35.times { crazy_instruction << %w[L R F].sample(3) }
          crazy_instruction.flatten.join

          expect { robot.perform(crazy_instruction) }.to raise_error(
            Robot::YouAreTooBossy
          )
        end
      end
    end
  end
end
