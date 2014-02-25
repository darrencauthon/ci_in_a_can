require_relative '../spec_helper'

describe CiInACan::Cli do

  describe "run" do

    [:args, :pwd].to_objects {[
      [['create', 'ok'], 'directory_a'],
      [['create', 'ko'], 'directory_b']
    ]}.each do |test|

      describe "create" do

        before do
          Dir.stubs(:pwd).returns test.pwd
        end

        it "should use the structure builder to create the app" do

          structure_builder = Object.new
          structure_builder.expects(:create)

          CiInACan::Cli::StructureBuilder.stubs(:new)
                                         .with(root: "#{test.pwd}/#{test.args[1]}",
                                               id:   test.args[1])
                                         .returns structure_builder

          CiInACan::Cli.run test.args
            
        end

      end

    end

  end

end
