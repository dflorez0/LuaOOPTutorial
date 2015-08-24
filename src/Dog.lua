-- Dog.lua
-- Author: joel
-- Date: 8/21/15

require 'Animal'

--- A dog
-- @classmod Dog
-- @author joel
Dog = {}

--- Private Class Properties
-- @section

--- Private Class Methods
-- @section

--- Public Class Methods
-- @section

function Dog.new(name, age, size)
  local self = class {Animal.new(name, age, size)};

  --- Private Instance Properties
  -- @section

  --- Private Instance Methods
  -- @section

  --- Public Instance Methods
  -- @section

  --- Override Animal.talk() method
  --  @see Animal
  function self.talk()
    print(self.getName().." is barking");
  end

  -- Constructor Methods Call --

  return self
end