-- Felis.lua
-- Author: joel
-- Date: 8/21/15

--- A Felis
-- @classmod Felis
-- @author joel
Felis = {}

--- Private Class Properties
-- @section

local meta = {}

--- Private Class Methods
-- @section

--- Public Class Methods
-- @section

function Felis.new()
  local self = class {}

  --- Private Instance Properties
  -- @section

  --- Private Instance Methods
  -- @section

  --- Public Instance Methods
  -- @section

  --- Return true
  -- @return true
  function self.isFelis()
    return true;
  end

  -- Constructor Methods Call --

  meta.__tostring =
  function ()
    return 'Felis';
  end

  setmetatable(self, meta);
  return self
end
