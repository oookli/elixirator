require "rocket_launcher"

RSpec.describe RocketLauncher do
  subject(:rocket_launcher) { described_class.new(ship_mass, route) }

  let(:ship_mass) { 28801 }
  let(:route) { [[:land, 'earth']] }

  context 'when ship_mass is negative' do
    let(:ship_mass) { -20 }

    it 'raises error' do
      expect { rocket_launcher }.to raise_error 'the flight ship mass is not correct'
    end
  end

  context 'when ship_mass is nil' do
    let(:ship_mass) { nil }

    it 'raises error' do
      expect { rocket_launcher }.to raise_error 'the flight ship mass is not correct'
    end
  end

  context 'when route has incorrect route type' do
    let(:route) { [[:land, 'earth'], [:some_other_type, 'earth'], [:launch, 'moon']] }

    it 'raises error' do
      expect { rocket_launcher }.to raise_error 'a route type is not correct for [:some_other_type, "earth"]'
    end
  end

  context 'when route has the planet which does not gravity defined' do
    let(:route) { [[:land, 'earth'], [:launch, 'neptune']] }

    it 'raises error' do
      expect { rocket_launcher }.to raise_error 'no gravity defined for [:launch, "neptune"]'
    end
  end

  context 'when route has incorrect path in the middle' do
    let(:route) { [[:land, 'earth'], [:launch, 'moon'], [:launch, 'moon'], [:land, 'earth']] }

    it 'raises error' do
      expect { rocket_launcher }.to raise_error 'the route path is not correct'
    end
  end

  context 'when route has incorrect path in the beginning' do
    let(:route) { [[:land, 'earth'], [:land, 'earth'], [:launch, 'moon'], [:land, 'earth']] }

    it 'raises error' do
      expect { rocket_launcher }.to raise_error 'the route path is not correct'
    end
  end

  context 'when route has incorrect path at the end' do
    let(:route) { [[:land, 'earth'], [:launch, 'moon'], [:launch, 'moon'], [:launch, 'moon']] }

    it 'raises error' do
      expect { rocket_launcher }.to raise_error 'the route path is not correct'
    end
  end

  describe '#fuel_required' do
    it 'returns a correct value' do
      expect(rocket_launcher.fuel_required).to eq 13447
    end

    context 'when route is more complicated' do
      describe 'Apollo 11' do
        let(:route) { [[:launch, 'earth'], [:land, 'moon'], [:launch, 'moon'], [:land, 'earth']] }
        let(:ship_mass) { 28801 }

        it 'returns a correct value' do
          expect(rocket_launcher.fuel_required).to eq 51898
        end
      end

      describe 'Mission on Mars' do
        let(:route) { [[:launch, 'earth'], [:land, 'mars'], [:launch, 'mars'], [:land, 'earth']] }
        let(:ship_mass) { 14606 }

        it 'returns a correct value' do
          expect(rocket_launcher.fuel_required).to eq 33388
        end
      end

      describe 'Passenger ship' do
        let(:route) { [[:launch, 'earth'], [:land, 'moon'], [:launch, 'moon'], [:land, 'mars'], [:launch, 'mars'], [:land, 'earth']] }
        let(:ship_mass) { 75432 }

        it 'returns a correct value' do
          expect(rocket_launcher.fuel_required).to eq 212161
        end
      end
    end
  end
end
