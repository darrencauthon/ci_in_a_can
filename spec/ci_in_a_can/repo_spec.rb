require_relative '../spec_helper'

describe CiInACan::Repo do

  before do
    clear_all_persisted_data
  end

  describe "create and find" do

    before do
      uuid = Object.new
      uuid.stubs(:generate).returns api_key
      UUID.stubs(:new).returns uuid
    end

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

      describe "finding a record that does not exist" do
        let(:api_key) { data.api_key }
        it "should return nil" do
          CiInACan::Repo.find(data.id).nil?.must_equal true
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

        [['one'], ['one', 'two', 'three']].each do |build_commands|
          describe "different build commands" do
            it "should store an array of build commands" do
              repo = CiInACan::Repo.create(id: data.id, build_commands: build_commands)
              repo.build_commands.must_equal build_commands
            end
          end
        end

        describe "build commands" do
          it "should default to an empty array" do
            CiInACan::Repo.new.build_commands.must_equal []
          end
        end

      end

    end

  end

  describe "save" do
    it "should update all of the fields" do
      repo = CiInACan::Repo.create(id: 'test')
      repo.name           = UUID.new.generate
      repo.api_key        = UUID.new.generate
      repo.build_commands = [UUID.new.generate]
      repo.save

      new_repo = CiInACan::Repo.find('test')

      [:name, :api_key, :build_commands].each do |field|
        new_repo.send(field).must_equal repo.send(field)
      end
    end
  end

  describe "resetting an api key" do
    it "should reset the api key" do
      r = CiInACan::Repo.create(id: 'test')
      original_api_key = r.api_key

      r.reset_api_key

      r = CiInACan::Repo.find('test')
      new_api_key = r.api_key

      new_api_key.wont_equal original_api_key
    end
  end

  ['test', 'test2'].each do |id|
    describe "url" do
      it "should return push/id/api_key" do
        repo = CiInACan::Repo.create(id: id)
        repo.url.must_equal "/push/#{repo.id}/#{repo.api_key}"
      end
    end
  end

  describe "all" do
    it "should return all of the repos" do
      repo_ids = [CiInACan::Repo.create(id: UUID.new.generate),
                  CiInACan::Repo.create(id: UUID.new.generate),
                  CiInACan::Repo.create(id: UUID.new.generate)].map { |x| x.id }

      actual_ids = CiInACan::Repo.all.map { |x| x.id }.sort_by { |x| x }

      repo_ids.sort_by! { |x| x }
      actual_ids.sort_by! { |x| x }

      repo_ids.must_equal actual_ids
    end
  end

end
