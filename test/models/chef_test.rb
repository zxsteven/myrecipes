require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chefname: 'Steven', email: 'Steven@example.com')
  end
  
  test "Chef should be valid" do
    assert @chef.valid?
  end
  
  test "chefname should be present" do
    @chef.chefname = ' '
    assert_not @chef.valid?
  end
  
  test "chefname should not be short" do
    @chef.chefname = 'a' * 2
    assert_not @chef.valid?
  end
  
  test "chefname should not be long" do
    @chef.chefname = 'a' * 41
    assert_not @chef.valid?
  end
  
  test "Email should be present" do
    @chef.email = ' '
    assert_not @chef.valid?
  end
  
  test "Email should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end
  
  test "Email validation should accept valid addresses" do
    valid_addresses = %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@eee.au tim+eric@lame.cm]
    valid_addresses.each do |va|
      @chef.email = va
      assert @chef.valid?, '#{va.inspect} should be valid'
    end
  end
  
  test "Email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_eee.org user.name@example. eee@i_am_.com foo@ee+aar.com]
    invalid_addresses.each do |ia|
      @chef.email = ia
      assert_not @chef.valid?, '#{ia.inspect} should be invalid'
    end
  end
end