if File.exists?("config/secrets.exs") do
  import_config("secrets.exs")
end
