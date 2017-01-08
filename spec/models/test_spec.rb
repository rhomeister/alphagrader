# frozen_string_literal: true
require 'rails_helper'

describe Test, type: :model do
  it 'has test results' do
    test = create(:test)
    test_result = create(:test_result)
    test.test_results << test_result

    expect(test_result.reload.test).to eq test
    expect(test.reload.test_results).to eq [test_result]
  end
end
