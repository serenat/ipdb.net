class CreatePeople < ActiveRecord::Migration

  class User < ActiveRecord::Base
    def name
      "#{__first_name} #{__last_name}".strip
    end

    def name_from_email
      /(\S+)@/.match(email)[1]
    end

    def any_name
      if name.present?
        return name
      elsif __username.present?
        return __username
      else
        name_from_email
      end
    end
  end

  class Person < ActiveRecord::Base
  end

  def up
    create_table :people do |t|
      t.string :name, null: false
      t.timestamps null: false
    end

    User.find_each do |user|
      person = Person.create!(name: user.any_name)
      user.update_columns(person_id: person.id)
    end
  end

  def down
    User.update_all(person_id: nil)
    drop_table :people
  end
end
