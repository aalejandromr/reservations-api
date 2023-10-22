class CreateAgents < ActiveRecord::Migration[7.0]
  def change
    create_table :agents do |t|
      t.string :first_name
      t.string :last_name
      t.string :agent_code

      t.timestamps
    end
  end
end
