require_relative '../spec_helper'

describe CiInACan::BuildSetting do

  let(:persistence_type) { 'repos' }

  before do
    clear_all_persisted_data
  end

  describe "commands for a build" do

    describe "bad build" do
      it "should default to nothing" do
        CiInACan::BuildSetting.commands_for(nil).must_equal []
      end
    end

    [:repo, :commands].to_objects {[
      ['abc', ['1', '2', '3']],
      ['def', ['4', '5', '6']]
    ]}.each do |test|

      describe "settings for the build repo exist" do

        it "should return the settings" do

          CiInACan::Persistence.save(persistence_type, test.repo, { commands: test.commands } )

          build = CiInACan::Build.new(repo: test.repo)

          commands = CiInACan::BuildSetting.commands_for build

          commands.must_equal test.commands
            
        end

      end

    end

  end

end
