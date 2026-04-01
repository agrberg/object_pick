# frozen_string_literal: true

# Adds `Object#pick` to extract a hash of method results from any object
class Object
  def pick(*methods)
    methods.to_h { [_1, public_send(_1)] }
  end
end
