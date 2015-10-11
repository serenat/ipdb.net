ActiveAdmin.register PodcastStat, as: 'Statistics' do
  filter :hits
  filter :unique_hits
  filter :downloads
  filter :unique_downloads
  filter :share
  filter :unique_shares
  filter :itunes_rating
  filter :itunes_review_count
  filter :updated_at

  active_admin_importable

  index do
    selectable_column
    column :podcast
    column :hits
    column :unique_hits
    column :downloads
    column :unique_downloads
    column :shares
    column :unique_shares
    column :itunes_rating
    column :itunes_review_count
    actions
  end

  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
