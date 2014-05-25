Sequel.migration do
  up do
    create_table :messages do
      primary_key :id
      Text :msgbody
      String :msgtype
      DateTime :created_at
      DateTime :updated_at
      DateTime :destroy_at
      Integer :node_id
      Integer :touser_id
      Integer :fromuser_id
    end
  end

  down do
    drop_table :messages
  end
end
