# encoding: utf-8

RSpec.describe Loaf::OptionsValidator, '.valid?' do
  let(:klass) { Class.extend Loaf::OptionsValidator }

  it 'validates succesfully known option' do
    expect(klass.valid?(match: :exact)).to eq(true)
  end

  it 'validates unknown option with an error' do
    expect {
      klass.valid?(invalid_param: true)
    }.to raise_error(Loaf::InvalidOptions)
  end
end
