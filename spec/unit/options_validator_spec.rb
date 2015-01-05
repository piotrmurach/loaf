require 'spec_helper'

describe Loaf::OptionsValidator do

  let(:klass) { Class.extend Loaf::OptionsValidator }

  describe '.valid?' do
    context 'when the passed options are valid' do
      let(:options) do
        { :crumb_length => 10 }
      end

      it 'returns true' do
        klass.valid?(options).should be_true
      end
    end
    context 'when the passed optiosn are invalid' do
       let(:options) do
          { :invalid_param => true }
       end

       it 'raises an error' do
         expect do
           klass.valid? options
         end.to raise_error(Loaf::InvalidOptions)
       end
    end
  end
end # Loaf::OptionsValidator
