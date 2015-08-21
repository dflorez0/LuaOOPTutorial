-- Cat.lua
-- Author: joel
-- Date: 8/21/15

require 'Felis'

--- A Cat
-- @classmod Cat
-- @author joel
Cat = {}

--- Private Class Properties
-- @section

--- Private Class Methods
-- @section

--- Public Class Methods
-- @section

function Cat.new(name, age, size)
  local self = class {Animal.new(name, age, size), Felis.new()}

  --- Private Instance Properties
  -- @section

  --- Private Instance Methods
  -- @section

  --- Public Instance Methods
  -- @section

  -- Constructor Methods Call --

  return self
end
