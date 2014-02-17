require_relative '../../spec_helper'

describe CiInACan::ViewModels::ViewModel do

  it "should serve as a wrapper around data provided to it" do

    stub = Object.new
    stub.stubs(:one).returns Object.new
    stub.stubs(:two).returns Object.new
    stub.stubs(:three).returns Object.new

    view_model = CiInACan::ViewModels::ViewModel.new stub

    view_model.one.must_be_same_as stub.one
    view_model.two.must_be_same_as stub.two
    view_model.three.must_be_same_as stub.three
      
  end

end
