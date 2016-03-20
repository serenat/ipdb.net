class AddUserAndItunesToReviews < ActiveRecord::Migration
  def change
    add_reference :reviews, :user, index: true
    add_column     :reviews, :itunes, :boolean, default: false
  end
end
