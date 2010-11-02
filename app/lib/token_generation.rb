require 'digest/sha1'

module TokenGeneration
  def secure_digest(*args)
    Digest::SHA1.hexdigest(args.flatten.join('--'))
  end

  def make_token
    secure_digest(Time.now, (1..10).map{ rand.to_s })
  end

  def make_hash(key, pepper)
    hash = secure_digest(key, rand.to_s)
    10.times do
      hash = secure_digest(hash, pepper, key)
    end
    hash
  end

  extend self
end
