require 'rails_helper'

describe type: :model do
  describe 'freeze_time' do
    context 'when freeze_time is called' do
      before { freeze_time }
      it { expect(Time.now).to eq Time.zone.now }
    end
    context 'when freeze_time is not called' do
      it { expect(Time.now).not_to eq Time.zone.now }
    end
  end
end
