-- Animal.lua
-- Author: joel
-- Date: 8/20/15

--- An animal
--  @classmod Animal
--  @author joel
Animal = {}

--- Private Class Properties
--  @section

--- Private Class Methods
--  @section

--- Public Class Methods
--  @section

function Animal.new(name, age, size)
  local self = class {}

  --- Private Instance Properties
  --  @section

  local _name;
  local _age;
  local _size;

  --- Private Instance Methods
  --  @section

  --- Check if the given argument is nil, not a number or negative
  --  @param arg The value to check
  --  @raise nil, not a number, negative
  --  @return arg The value if correct
  --
  local function checkAgeAndSize(arg)
    assert(arg, "nil value");
    local argN = assert(tonumber(arg), arg.." is not a number");
    if argN >= 0 then
      return argN;
    else
      error(arg.." is negative")
    end
  end

  --- Getters
  --  @section

  function self.getName()
    return _name;
  end

  function self.getAge()
    return _age;
  end

  function self.getSize()
    return _size;
  end

  --- Setters
  --  @section

  function self.setName(name)
    _name = name;
  end

  function self.setAge(age)
    _age = checkAgeAndSize(age);
  end

  function self.setSize(size)
    _size = checkAgeAndSize(size);
  end

  --- Public Instance Methods
  --  @section

  --- The animal talk
  --
  function self.talk()
    print(_name.." is talking");
  end

  --- Print the data
  --
  function self.print()
    print(_name..', age: '.._age..', size: '.._size);
  end

  -- Constructor Methods Call --

  self.setName(name);
  self.setAge(age);
  self.setSize(size);

  return self
end