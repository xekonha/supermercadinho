@user = User.new('name' => 'rainey', 'email' => 'rainey.lopes@gmail.com', 'role' => 'admin', \
                 'password' => '123456')
@user.save!
new_reg = {}
path = "app/assets/images/products/"
file_path = "#{path}*.*"
files = Dir[file_path]
files.first(3).each_with_index do |file, index|
  file_name = file.split('/')[-1]
  file_parts = file_name.split('-')
  parts = []
  file_parts.each { |part| part.is_a?(String) ? parts << part.strip.squeeze(" ").titleize : parts << part }
  # Product::CATEGORY = %w[açougue bazar bebidas congelados frios higiene
  # hortifruti leite-derivados limpeza matinais mercearia]
  case parts[-4].downcase
  when 'acougue'
    category = 'açougue'
  when 'leitederivado', 'leitederivados', 'leitesderivados', 'leite', 'leite derivados'
    category = 'leite-derivados'
  when 'matinal'
    category = 'matinais'
  else
    if Product::CATEGORY.include?(parts[-4].downcase)
      category = parts[-4].downcase
    else
      puts "ERRO: categoria #{parts[-4]} inexistente!!!"
      puts "parts = #{parts}"
      puts "file = #{file}"
    end
  end

  unit = parts[-1].split('.')[0].downcase
  new_reg = { 'category' => category,
              'name' => parts[-3],
              'description' => parts[-2],
              'unit' => unit,
              'price' => ((1..100).to_a.sample.to_f - 0.01).round(2),
              'total_quantity' => (1..100).to_a.sample,
              'user' => @user }

  product = Product.new(new_reg)
  product.user = @user
  ext = file_name.split(".")[1].downcase
  product.photo.attach(io: File.open(file),
                       filename: file_name,
                       content_type: "image/#{ext}")
  if product.save!
    puts "Produto #{product.name} cadastrado com sucesso."
  else
    puts 'ERRO!!!'
    break
  end
end
