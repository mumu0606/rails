Dir.glob(File.join(Rails.root, 'db', 'seed', 'pokedex', '*.rb')) do |file|
  begin
    load(file)
  rescue => e
    puts e.message
  end
end

if __FILE__ == $0
#  insert_item
  #insert_move
end