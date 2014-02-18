require_relative '../spec_helper'

describe CiInACan::Repo do

  before do
    clear_all_persisted_data

    uuid = Object.new
    uuid.stubs(:generate).returns api_key
    UUID.stubs(:new).returns uuid
  end

  describe "create and find" do

    [:id, :name, :api_key].to_objects {[
      ['abc', 'apple', 'test1'],
      ['123', 'orang', 'test2']
    ]}.each do |data|

      describe "create" do

        let(:api_key) { data.api_key }

        it "should return the repo" do
          repo = CiInACan::Repo.create(id: data.id)
          repo.is_a?(CiInACan::Repo).must_equal true
          repo.id.must_equal data.id
        end
      end

      describe "finding a record by id" do

        let(:api_key) { data.api_key }

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

      describe "attributes" do

        let(:api_key) { data.api_key }

        it "should allow the stamping by name" do
          CiInACan::Repo.create(id: data.id, name: data.name)

          repo = CiInACan::Repo.find data.id
          repo.name.must_equal data.name
        end

        it "should create a unique api key" do
          CiInACan::Repo.create(id: data.id)

          repo = CiInACan::Repo.find data.id
          repo.api_key.must_equal data.api_key
        end

        it "should not override the existing api key" do
          CiInACan::Repo.create(id: data.id, 
                                api_key: 'previously set value')

          repo = CiInACan::Repo.find data.id
          repo.api_key.must_equal 'previously set value'
        end

      end

    end

  end

end
