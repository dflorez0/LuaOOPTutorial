-- TestAnimal.lua
-- Author: joel
-- Date: 8/25/15

package.path = package.path..';../src/?.lua;../lib/?.lua';

luaunit = require 'luaunit';
require 'OOP'
require 'Animal';

TestAnimal = {};

local animal;

--- Prepare the animal instance
--
function TestAnimal:setUp()
  animal = Animal.new("name", 0, 0);
end

--- Test the Animal.setSize with a negative value
--
function TestAnimal:testNegativeSize()
  luaunit.assertErrorMsgContains('-1 is negative', animal.setSize, -1);
end

--- Test the Animal.setSize with a nil value
--
function TestAnimal:testNilSize()
  luaunit.assertErrorMsgContains('nil value', animal.setSize, nil);
end

--- Test the Animal.setSize with a string value
--
function TestAnimal:testNotANumberSize()
  luaunit.assertErrorMsgContains('notANumber is not a number', animal.setSize, 'notANumber');
end

--- Test the Animal.setSize with a positive value
--
function TestAnimal:testPositiveSize()
  animal.setSize(1);
  luaunit.assertEquals(animal.getSize(), 1);
end

os.exit(luaunit.LuaUnit.run());