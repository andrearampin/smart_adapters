# frozen_string_literal: true

require 'test_helper'

module SmartAdapters
  class Test < ActiveSupport::TestCase
    test 'truth' do
      assert_kind_of Module, SmartAdapters
    end
  end
end
