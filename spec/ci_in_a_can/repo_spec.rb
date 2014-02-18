require_relative '../spec_helper'

describe CiInACan::Repo do

  before do
    clear_all_persisted_data
  end

  describe "create and find" do

    describe "finding a record by id" do

      it "should return a repo with that id" do

        CiInACan::Repo.create(id: 'abc')

        repo = CiInACan::Repo.find 'abc'
        repo.is_a?(CiInACan::Repo).must_equal true
        repo.id.must_equal 'abc'
      end

      it "should return the right record if many exist" do

        CiInACan::Repo.create(id: UUID.new.generate)
        CiInACan::Repo.create(id: 'abc')
        CiInACan::Repo.create(id: UUID.new.generate)

        repo = CiInACan::Repo.find 'abc'
        repo.is_a?(CiInACan::Repo).must_equal true
        repo.id.must_equal 'abc'
          
      end

    end

  end

end
