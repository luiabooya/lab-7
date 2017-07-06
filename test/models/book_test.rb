require 'test_helper'

class BookTest < ActiveSupport::TestCase
  # Start by using Shoulda's ActiveRecord matchers
  #
  # TODO: Relationship macros
  should belong_to(:category)
  should have_many(:book_authors)
  should have_many(:authors).through(:book_authors)

  # TODO: Validation macros
  should validate_presence_of(:title)
  
  should allow_value(1000).for(:units_sold)
  should_not allow_value(-1000).for(:units_sold)
  should_not allow_value(3.14159).for(:units_sold)
  should_not allow_value("bad").for(:units_sold)
  should allow_value(0).for(:units_sold)

  # TODO: Test dates as much as you can with matchers...
  should allow_value(1.year.ago).for(:proposal_date)
  should_not allow_value(1.week.from_now).for(:proposal_date)
  should_not allow_value("bad").for(:proposal_date)
  should_not allow_value(nil).for(:proposal_date)


  context "With a proper context, " do
    # I can create the objects I want with factories
    setup do
      # call the create_context method here
      create_context
    end

    # and provide a teardown method as well
    teardown do
      # call the remove_context method here
      remove_context
    end

    # test each factory object (not necessary, could be done in console)
    should "show that all factory objects are properly created" do
      assert_equal "Ruby", @ruby.name
      assert_equal "Rails", @rails.name
      assert_equal "Testing", @testing.name
      assert_equal "Black, David", @dblack.name
      assert_equal "Hartl, Michael", @michael.name
      assert_equal "Hellesoy, Aslak", @aslak.name
      assert_equal "Chelimsky, David", @dchel.name
      assert_equal "The Well-Grounded Rubyist", @wgr.title
      assert_equal "Rails 3 Tutorial", @r3t.title
      assert_equal "Ruby for Masters", @rfm.title
      assert_equal "The RSpec Book", @rspec.title
      assert_equal "Black, David", @wgr.authors.first.name
      assert_equal "Hartl, Michael", @r3t.authors.first.name
      assert_equal 2, @rspec.authors.size
      assert_equal "Chelimsky, David", @rspec.authors.alphabetical.first.name
      assert_equal "Black, David", @rfm.authors.first.name
      assert_nil @agt.contract_date
      assert_nil @rfm.published_date
    end


    # TESTING SCOPES
    #
    # Avaliable book scopes (copied from book model for easy reference):
    #   - by_title
    #   - by_category
    #   - published
    #   - under_contract
    #   - proposed
    #   - for_category
    
    should "have all the books listed alphabetically by title" do
      # test code goes here...
      assert_equal ["Agile Testing", "Rails 3 Tutorial", "Ruby for Masters", "The RSpec Book",
         "The Well-Grounded Rubyist"], Book.by_title.map{|b| b.title}
      
    end
    
    should "have all the books listed alphabetically by category, then by title" do
      # test code goes here...
      assert_equal ["Rails 3 Tutorial", "Ruby for Masters", "The Well-Grounded Rubyist", "Agile Testing", 
        "The RSpec Book"], Book.by_category.map{|xx| xx.title}
    end
    
    should "have all the published books" do
      # test code goes here...
      assert_equal ["Rails 3 Tutorial", "The RSpec Book", "The Well-Grounded Rubyist"], 
      Book.published.by_title.map{|b| b.title}
    end
    
    should "have all the books under contract" do
      # test code goes here...
      assert_equal ["Ruby for Masters"], 
      Book.under_contract.by_title.map{|b| b.title}
    end
    
    should "have all the books that are only at proposal stage" do
      # test code goes here...
      assert_equal ["Agile Testing"], 
      Book.proposed.by_title.map{|b| b.title}
    end
    
    should "have all the books for a particular category" do
      # test code goes here...
      assert_equal ["Rails 3 Tutorial"], Book.for_category(@rails.id).by_title.map{|b| b.title}
      assert_equal ["Ruby for Masters", "The Well-Grounded Rubyist"], Book.for_category(@ruby.id).by_title.map{|b| b.title}
    end
    
    # TESTING CONTRACT AND PUBLISHED DATES
    # proposal_date was validated earlier with a matcher
        
    should "allow for a contract date in the past after the proposal date" do
      # take advantage of the fact that the default proposal date is 1 year ago...
      # test code goes here...
    end
    
    should "allow for contract and published dates to be nil" do
      # make pub date also nil otherwise it will fail b/c default pub date is 3 weeks ago, which is before a nil contract date      big_ruby_book = FactoryGirl.build(:book, :contract_date => nil, :published_date => nil, :category => @ruby, :title => "The Big Book of Ruby")
      # test code goes here...
    end
    
    should "not allow for a contract date in the past before the proposal date" do
      # test code goes here...
    end
    
    should "not allow for a contract date in the future" do
      # test code goes here...
    end
    
    should "allow for a published date in the past after the contract date" do
      # take advantage of the fact that the default contract date is 10 months ago...
      # test code goes here...
    end
    
    should "allow for just the published date to be nil" do
      # test code goes here...
    end
    
    should "not allow for a published date in the past before the contract date" do
      # test code goes here...
    end
    
    should "not allow for a published date in the future" do
      # test code goes here...
    end
    
    
    # TESTING CUSTOM VALIDATIONS
    # test the custom validation 'category_is_active_in_system'
    should "identify an inactive category as invalid" do
      # test code goes here...
    end
  end

end
