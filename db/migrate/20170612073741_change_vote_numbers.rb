class ChangeVoteNumbers < ActiveRecord::Migration[5.0]
  def change
    change_column_default :photographs, :vote_numbers, 0
  end
end
