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
      String :role #默认角色
      String :group # 默认group
      integer :wuye_id  # 默认物业公司
      integer :xiaoqu_id # 默认小区id
      String :url_header #头像的URL地址
      String :verifiedbit #校验位
      String :verify_code #校验码
    end
  end

  down do
    drop_table :users
  end
end
