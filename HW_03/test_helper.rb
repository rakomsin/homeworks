require 'minitest/pride'
require 'openssl'

cipher = OpenSSL::Cipher::AES.new(128, :CBC)
cipher.encrypt
key = "_"*16
cipher.key = key
iv = "G\A�*{UK�	�"
cipher.iv = iv

# data = File.read("hw1_test.rb")
# encrypted = cipher.update(data) + cipher.final
# puts encrypted
# IO.write("encrypted_test_hw_1.rb", encrypted)

decipher = OpenSSL::Cipher::AES.new(128, :CBC)
decipher.decrypt
decipher.key = key
decipher.iv = iv

encrypted_file_path = File.join(".", File.dirname(__FILE__), "encrypted_test_hw_1.rb")
decrypted_file_path = File.join(".", File.dirname(__FILE__), "decrypted_test_hw_1.rb")
decrypted_test_data = decipher.update(File.read(encrypted_file_path)) + decipher.final
IO.write(decrypted_file_path, decrypted_test_data)


homeworks = Dir[File.join(".", "**/*.rb")].select { |f| f.match?(/hw_03_t_01/)}

homeworks.each do |hw|
  puts "Running tests for #{hw}..."
  require hw
  require decrypted_file_path
end

File.delete(decrypted_file_path)

