class Encrypt
    def get_rsa_key
        rsa = OpenSSL::PKey::RSA.new(1024)
        # public_key only can public_encrypt or public_decrypt no private_encrypt nor private_decrypt
        #rsa.public_key.to_pem the class of return value is String
        [rsa.public_key.to_pem, rsa.to_pem]
    end

    def rsa_private_encrypt(value , rsakey)
        rsa = OpenSSL::PKey::RSA.new(rsakey)
        rsa.private_encrypt(value)
    end

    def rsa_private_decrypt(value , rsakey)
        rsa = OpenSSL::PKey::RSA.new(rsakey)
        rsa.private_decrypt(value)
    end

    def rsa_public_encrypt(value , publickey)
        rsa = OpenSSL::PKey::RSA.new(publickey)
        rsa.public_encrypt(value)
    end

    def rsa_public_decrypt(value, publickey)
       rsa = OpenSSL::PKey::RSA.new(publickey)
       rsa.public_decrypt(value)
    end
end

#encrypt = Encrypt.new

#public_key = Rails.application.secrets.public_key
#publickey = OpenSSL::PKey::RSA.new(Base64.decode64(public_key))

#original = encrypt.rsa_public_encrypt("123456",publickey)
#encrypt.rsa_private_decrypt(original,rsakey)
