require 'sinatra/base'

module CiInACan

  class App < Sinatra::Base

    enable :sessions

    get '/' do
              html = CiInACan::Web.new.show_a_list_of_the_runs
              CiInACan::WebContent.layout_page_around html
            end

    get '/login' do
                   html = CiInACan::Web.new.login_page
                   CiInACan::WebContent.layout_page_around html
                 end

    post '/login' do
                    CiInACan::Web.new(params: params, session: session)
                      .submit_a_passphrase
                    redirect '/'
                  end

    get '/test_result/:id' do
                             html = CiInACan::Web.new(params: params)
                                      .show_the_test_result
                             CiInACan::WebContent.layout_page_around html
                           end

    get '/test_result/:id.json' do
                                  CiInACan::Web.new(params: params)
                                    .show_the_test_result_in_json
                                end

    get %r{/repo/(.+)} do
                         web = CiInACan::Web.new(params: params, session: session)

                         unless web.logged_in?
                           redirect '/login'
                           return
                         end

                         html = web.show_the_repo_edit_form
                         CiInACan::WebContent.layout_page_around html
                       end

    post %r{/repo/(.+)} do
                          web = CiInACan::Web.new(params: params, session: session)
                          unless web.logged_in?
                            redirect '/login'
                            return
                          end
                          repo = web.update_repo_details
                          redirect "/repo/#{repo.id}"
                        end

    post %r{/push/(.+)} do
                          CiInACan::Web.new(params: params).start_a_new_build
                        end

  end

end
