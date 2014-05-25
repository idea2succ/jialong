Sequel.migration do
  up do
    create_table :nodes do
      primary_key :id
      String :nodename
      Integer :nodenumber
      String :nodetype
      Integer :created_by
      DateTime :created_at
      DateTime :updated_at
      DateTime :destroy_at
      Integer :destroyed_by
      Integer :owner
      Integer :admin
      Float :locationx
      Float :locationy
    end
  end

  down do
    drop_table :nodes
  end
end
