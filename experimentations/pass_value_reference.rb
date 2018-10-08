def log_message (message)
  message << “at ” + Time.now.to_s
  $stdout.puts(message)
end

home = File.expand_path(“~”)
p home
log_message(home) # home is mutated.

# This won't work as expected.
Dir.entries(home) do |entry|

  # ...
end
