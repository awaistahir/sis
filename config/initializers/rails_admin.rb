RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  # config.model 'Question' do
  #   field :statment, :froala
  # end
  
  config.model Section do
    object_label_method :name_location
  end

  config.model Course do
    object_label_method :grade_name
  end

  config.model Period do
    edit do
      field :teacher do
        inline_add false
        inline_edit false
      end
      field :section do
        inline_add false
        inline_edit false
      end
      field :course do
        inline_add false
        inline_edit false
      end
    fields :period_no, :incharge, :no_of_days #, ...

  end
end

config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
