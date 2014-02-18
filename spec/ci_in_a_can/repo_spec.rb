require_relative '../spec_helper'

describe CiInACan::Repo do

  before do
    clear_all_persisted_data
  end

  describe "create and find" do

    [:id, :name].to_objects {[
      ['abc', 'apple'],
      ['123', 'orang']
    ]}.each do |data|

      describe "finding a record by id" do

        it "should return a repo with that id" do

          CiInACan::Repo.create( { id: data.id } )

          repo = CiInACan::Repo.find data.id
          repo.is_a?(CiInACan::Repo).must_equal true
          repo.id.must_equal data.id
        end

        it "should return the right record if many exist" do

          CiInACan::Repo.create(id: UUID.new.generate)
          CiInACan::Repo.create(id: data.id)
          CiInACan::Repo.create(id: UUID.new.generate)

          repo = CiInACan::Repo.find data.id
          repo.is_a?(CiInACan::Repo).must_equal true
          repo.id.must_equal data.id
            
        end

      end

      it "should allow the stamping by name" do
        CiInACan::Repo.create(id: data.id, name: data.name)

        repo = CiInACan::Repo.find data.id
        repo.name.must_equal data.name
      end

    end

  end

end
