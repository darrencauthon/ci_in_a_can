module CiInACan

  class GithubPayloadParser

    def parse content
      payload = extract_payload_from content
      project = extract_repo_from payload

      { 
        git_ssh: "git@github.com:#{project}.git",
        repo:    project,
        branch:  extract_branch_from(payload),
        sha:     extract_sha_from(payload) 
      }
    end

    private

    def extract_repo_from payload
      username, project_name = get_username_and_project_name_from payload
      "#{username}/#{project_name}"
    end

    def extract_payload_from content
      data = JSON.parse content
      JSON.parse data['payload']
    end

    def get_username_and_project_name_from payload
      splat = payload['compare'].split('/')
      [splat[3], splat[4]]
    end

    def extract_sha_from payload
      payload['head_commit']['id']
    end

    def extract_branch_from payload
      array = payload['ref'].split('/')
      array.shift # remove "refs"
      array.shift # remove next value (like "heads" or "tags")
      array.count == 0 ? payload['ref'] : array.join('/')
    end

  end
end
