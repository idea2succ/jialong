Sequel::Model.plugin(:schema)
Sequel::Model.raise_on_save_failure = false # Do not throw exceptions on failure
Sequel::Model.db = case Padrino.env
  when :development then Sequel.connect("postgres://localhost/jialong_development", :loggers => [logger],:user=>"crmp",:password=>"123456")
  when :production  then Sequel.connect("postgres://localhost/jialong_production",  :loggers => [logger])
  when :test        then Sequel.connect("postgres://localhost/jialong_test",        :loggers => [logger])
end
