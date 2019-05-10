class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new

    # alias_action :create, :read, to: :basic_action

    can :read, Coin, accepted: true
    can :read, Question, accepted: true
    can [:index, :calendar], Event   
    can :read, KeyPlayer, accepted: true
    can :index, KeyPlayer
    can :read, Term, accepted: true
    can :index, Term
    can [:read,:index], Post
    can [:index, :read], Genre

    # if user.present?
    #   can [:create], Coin
    #   can [:create, :index, :challenge, :upvote, :downvote], Question
    #   can [:create, :challenge], Term
    #   can [:create, :challenge], KeyPlayer
    #   can :read, Event, accepted: true
    #   can [:create, :upvote, :downvote], Event
    #   can [:create], Link
    #   can [:create, :upvote, :downvote], Post 
    #   can [:update, :destroy], Post do |post|
    #     post.user == user
    #   end
    #   can [:create, :upvote, :downvote], Comment 
    #   can [:update, :destroy], Comment do |comment|
    #     comment.user == user
    #   end
    #   can :create, Picture
    #   can :create, Flag
    #   can [:read, :update], User, id: user.id

    #   if user.moderator?
    #     can [:update, :flop], Coin do |coin| 
    #       coin.moderator == user
    #     end

    #     can [:read, :update, :activate, :deactivate], Question do |question|
    #       question.coin.moderator == user
    #     end

    #     can [:read, :update, :activate, :deactivate], Term do |term|
    #       term.coin.moderator == user
    #     end

    #     can [:read, :update, :activate, :deactivate], KeyPlayer do |keyplayer|
    #       keyplayer.coin.moderator == user
    #     end
        
    #     can [:read, :update, :activate, :deactivate], Event do |event|
    #       event.coin.moderator == user
    #     end

    #     can [:read, :update, :activate, :deactivate], Link do |link|
    #       link.coin.moderator == user 
    #     end

    #     cannot [:update, :destroy], Post, coin_id: nil
    #     can [:update, :destroy], Post do |post|  
    #       post.coin_id.present? and post.coin.moderator == user
    #     end

    #     cannot [:update, :destroy], Comment, coin_id: nil
    #     can :manage, Comment do |comment| 
    #       comment.coin_id.present? and comment.coin.moderator == user
    #     end

    #     can :manage, Picture do |picture|
    #       picture.coin.moderator == user
    #     end
    #     cannot :destroy, Picture

    #     # can :manage, QuestionImage do |image|
    #     #   image.coin.moderator == user
    #     # end
    #     # cannot :destroy, QuestionImage

    #     can :manage, Flag do |flag|
    #       flag.coin.moderator == user
    #     end
    #   end

    #   if user.admin?
    #     can :manage, :all
    #   end

    # end
  end
end
