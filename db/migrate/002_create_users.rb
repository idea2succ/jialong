Sequel.migration do
  up do
    create_table :users do
      primary_key :id
      String :name
      String :email
      String :crypted_password
      String :salt
      String :mphone
      bigint :QQ
      String :role
      String :group
      integer :wuye_id
      integer :xiaoqu_id
      String :url_header
      String :verifiedbit
      String :verify_code
    end
  end

  down do
    drop_table :users
  end
end
