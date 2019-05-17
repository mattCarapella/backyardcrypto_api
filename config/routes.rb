Rails.application.routes.draw do
  devise_for :users

 	namespace :api, defaults: { format: :json } do
    namespace :v1 do
    	
      resources :users, :only => [:create, :show, :index]
    	
      resource :sessions, :only => [:show, :create, :destroy]

    	resources :coins do 	
        get 'pending', to: 'coins#pending', on: :collection
  
        resources :events do 
          get 'calendar', to: 'events#calendar', on: :collection
          member do
            get :activate
            get :deactivate
            get "getlikes", to: "events#getupvotes"
            get "getdislikes", to: "events#getdownvotes"
            put "like", to: "events#upvote"
            put "dislike", to: "events#downvote"
          end
        end	

        resources :key_players do
          member do
            get :activate
            get :deactivate
          end
          get 'challenge', to: 'key_players#challenge', on: :member
        end
 
        resources :links do
          member do
            get :activate
            get :deactivate
          end
        end

        resources :posts do
          resources :flags
          resources :comments, module: :posts
          resource :favorite
          member do
              get :flop
          get "getlikes", to: "posts#getupvotes"
          get "getdislikes", to: "posts#getdownvotes"
            put "like", to: "posts#upvote"
            put "dislike", to: "posts#downvote"
          end
        end

        resources :questions do
          # resources :citations
          resources :flags
          resources :comments, module: :questions
          # resources :question_images do
          #   get 'pending', to: 'question_images#pending', on: :collection
          #   member do
          #     # get :flop
          #     # get :reject
          #     get :activate
          #     get :deactivate
          #     get :make_primary
          #   end
          # end
          # resources :comments, module: :questions do
          #   member do
          #     put "like", to: "comments#upvote"
          #     put "dislike", to: "comments#downvote"
          #     put "delete", to: "comments#destroy"
          #     put "edit", to: "comments#update"
          #   end
          # end
          get 'discussion', to: 'questions#discussion', on: :member
          get 'pending_topics', to: 'questions#pending_topics', on: :collection
          get 'challenge', to: 'questions#challenge', on: :member             # user submits new term
          # get 'flag', to: 'questions#flag', on: :member
          get 'archived', to: 'questions#archive', on: :collection
          member do
            get :activate
            get :deactivate
            put "like", to: "questions#upvote"
            put "dislike", to: "questions#downvote"
          end
        end
    		
    		resources :terms do
          member do
            get :activate
            get :deactivate
          end
          get 'challenge', to: 'terms#challenge', on: :member
        end 

        resources :pictures 	
      end
    	
      resources :genres

      resources :key_players do
        member do
          get :activate
          get :deactivate
        end
        get 'challenge', to: 'key_players#challenge', on: :member
      end

      resources :posts do
        resource :favorite, module: :posts
        member do
          get "getlikes", to: "posts#getupvotes"
          get "getdislikes", to: "posts#getdownvotes"
          put "like", to: "posts#upvote"
          put "dislike", to: "posts#downvote"
          put "delete", to: "posts#delete"
        end
        resources :flags
        resources :comments, module: :posts do
          member do
          get "getlikes", to: "comments#getupvotes"
          get "getdislikes", to: "comments#getdownvotes"
          put "like", to: "comments#upvote"
          put "dislike", to: "comments#downvote"
          put "delete", to: "comments#destroy"
          put "edit", to: "comments#update"
        end
        end
        member do
          put "like", to: "posts#upvote"
          put "dislike", to: "posts#downvote"
        end
      end
      
      resources :terms do
        member do
          get :activate
          get :deactivate
        end
        get 'challenge', to: 'terms#challenge', on: :member
      end

      

    end
  end

end
