require_relative '../lib/robot'
require_relative '../lib/surface'

RSpec.describe 'Mars Control Centre' do
  describe 'forever lost' do
    context 'when robot moves off the eastern edge' do
      it 'returns last grid position' do
        output = `./bin/mars_robot_control_centre 1 1 0 0 N RFF`

        expect(output).to match(/1 0 E LOST/)
      end
    end
  end

  describe 'output of final coordinates and orientation' do
    it 'returns results of final coordinates and orientation' do
      output = `./bin/mars_robot_control_centre 5 3 1 1 E RFRFRFRF`

      expect(output).to match(/1 1 E/)
    end

    it 'returns results of final coordinates and orientation' do
      output = `./bin/mars_robot_control_centre 5 3 3 2 N FRRFLLFFRRFLL`

      expect(output).to match(/3 3 N LOST/)
    end

    it 'returns results of final coordinates and orientation' do
      output = `./bin/mars_robot_control_centre 5 3 3 2 N FRRFLLFFRRFLL 0 3 W LLFFFLFLFL`

      expect(output).to match(/2 3 S/)
    end

    it 'returns results of final coordinates and orientation' do
      output = `./bin/mars_robot_control_centre 5 3 1 1 E RFRFRFRF 3 2 N FRRFLLFFRRFLL 0 3 W LLFFFLFLFL`

      expect(output).to match(/1 1 E/)
      expect(output).to match(/3 3 N LOST/)
      expect(output).to match(/2 3 S/)
    end

    context 'when there is no movement' do
      it 'returns initial coordinates and initial orientation' do
        output = `./bin/mars_robot_control_centre 5 5 1 2 N`

        expect(output).to match(/1 2 N/)
      end
    end

    context 'when robot is instructed to move once from initial position' do
      it 'moves and returns new position' do
        output = `./bin/mars_robot_control_centre 5 5 0 0 N F`

        expect(output).to match(/0 1 N/)
      end
    end

    context 'when robot is given a set of instructions' do
      it 'returns final position and orientation after execution' do
        output = `./bin/mars_robot_control_centre 5 5 1 2 N L`

        expect(output).to match(/1 2 W/)
      end

      it 'returns final position and orientation after execution' do
        output = `./bin/mars_robot_control_centre 5 5 1 2 N LFLFLFLFF`

        expect(output).to match(/1 3 N/)
      end

      it 'returns final position and orientation after execution' do
        output = `./bin/mars_robot_control_centre 5 5 3 3 E FFRFFRFRRF`

        expect(output).to match(/5 1 E/)
      end
    end

    context 'when robot is given a set of instructions' do
      subject(:output) { `./bin/mars_robot_control_centre 5 3 3 2 N FRRFLLFF` }

      it 'returns final position and orientation after execution' do
        expect(output).to match(/3 3 N LOST/)
      end
    end
  end
end
