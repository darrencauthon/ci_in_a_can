require_relative '../spec_helper'

describe CiInACan::BuildSetting do

  before do
    clear_all_persisted_data
  end

  describe "commands for a build" do

    [nil, ''].each do |bad_value|
      describe "bad build" do
        it "should default to nothing" do
          CiInACan::BuildSetting.commands_for(bad_value).must_equal []
        end
      end
    end

    [:repo, :commands].to_objects {[
      ['abc', ['1', '2', '3']],
      ['def', ['4', '5', '6']]
    ]}.each do |test|

      describe "settings for the build repo exist" do

        it "should return the settings" do
          CiInACan::Repo.create(id: test.repo, build_commands: test.commands)
          build = CiInACan::Build.new(repo: test.repo)
          commands = CiInACan::BuildSetting.commands_for test.repo
          commands.must_equal test.commands
        end

      end

    end

  end

end
