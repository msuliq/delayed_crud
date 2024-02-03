# frozen_string_literal: true

require "test_helper"

class TestDelayedCrudArgumentErrors < Minitest::Test
  def test_delayed_read_with_missing_method_name
    assert_raises(NoMethodError) do
      DelayedCrud::BackgroundJobHandler.delayed_read(Object.new, nil)
    end
  end

  def test_delayed_read_with_invalid_method_name
    assert_raises(NoMethodError) do
      DelayedCrud::BackgroundJobHandler.delayed_read(Object.new, :invalid_method)
    end
  end

  def test_delayed_read_with_invalid_method_name_type
    assert_raises(NoMethodError) do
      DelayedCrud::BackgroundJobHandler.delayed_read(Object.new, 123)
    end
  end
end
