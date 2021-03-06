require './lib/shift_calculator'
require './lib/caesar_cipher'
require './lib/offsettable'
require './lib/keyable'
require './lib/datable'

class Enigma
  include Offsettable, Keyable, Datable

  attr_reader :key,
              :date,
              :cipher,
              :shifter,
              :message,
              :new_message

  def initialize
    @key         = key
    @date        = date
    @message     = message
    @cipher      = CaesarCipher.new
    @shifter     = ShiftCalculator.new
    @new_message = []
  end

  def default_key
    self.generate_secure_key
  end

  def default_date
    self.generate_formatted_date
  end

  def offset
    self.calculate_offset(@date)
  end

  def shift
    @shifter.total_shift(key, offset)
  end

  def encrypt(message, key = default_key, date = default_date)
    @key  = key
    @date = date
    encode_all_characters(message)
    encryption_hash
  end

  def encode_all_characters(message)
    message.split("").each_slice(4) do |group|
      new_message << @cipher.encode(group[0], shift["A"]) if !group[0].nil?
      new_message << @cipher.encode(group[1], shift["B"]) if !group[1].nil?
      new_message << @cipher.encode(group[2], shift["C"]) if !group[2].nil?
      new_message << @cipher.encode(group[3], shift["D"]) if !group[3].nil?
    end
    @message = new_message.join
  end

  def encryption_hash
    {encryption: @message,
     key:        @key,
     date:       @date}
  end

  def decrypt(message, key, date = default_date)
    @key     = key
    @date    = date
    @message = message
    decode_all_characters(message)
    decryption_hash
  end

  def decode_all_characters(message)
    message.split("").each_slice(4) do |group|
      new_message << @cipher.decode(group[0], shift["A"]) if !group[0].nil?
      new_message << @cipher.decode(group[1], shift["B"]) if !group[1].nil?
      new_message << @cipher.decode(group[2], shift["C"]) if !group[2].nil?
      new_message << @cipher.decode(group[3], shift["D"]) if !group[3].nil?
    end
    @message = new_message.join
  end

  def decryption_hash
    {decryption: @message,
     key:        @key,
     date:       @date}
  end

end
