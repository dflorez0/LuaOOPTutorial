Lua Object Oriented Programming
===============================

## Objectives ##
Object Oriented Programming simplify development, maintenance, readability and code re-usability. This small tutorial
introduce object oriented programming in Lua and set a development standard which has to be followed by any people wanting 
to develop additional module, add new functionality or correct a bug.

## Background ##
The few following lines give some background to better understand object oriented programming and the tutorial. If you 
are familiar with programming you will not find anything new but it could be a good refresh.

### Vocabulary ###
* Class
    A class is a template, a blueprint of a concept like a blueprint of a house.
* Object
    An object is an instance of a class. It is a particular object with its own properties. If a class is a blueprint of
     a house an object is a concrete built house.
* Property
    Classes can define properties like text, number...
* Method
    Method is another name for function

### Encapsulation ###
Methods and properties can be private or public. When defined public, they can be accessed from the outside of the class.
When defined private they cannot be accessed from the outside of the class.

A rule of thumb is to always make properties private and create getter and setter methods for getting their value and setting 
their value. This rule ensure properties verification and formatting when getting/setting their value. Thus, by following 
this rule, the public property area defined in the template should always be empty.

### Class/Object properties and methods ###
Properties and methods can be defined by class or by object (instance).

#### Properties ####
A class defined property or method is common to all **every** object. That means if object _A_ change a property _p_, 
object _B_ access the new value, the old one is lost. However, object property is specific to **one** object thus if 
object _A_ change its property _p_, object _B_ has its _p_ property not changed. For example we can count how many instance 
of a class are created by using a class property. An object property is specific to the created object.

#### Methods ####
In a same way methods can be defined by class or by object. Class defined methods are accessible without creating an instance 
of the class whereas object methods are available through object. As an example think of a dog object (in a programing 
point of view), the method bark is defined as an object method because it is the dog object which bark. For a class method 
example you can think of a Math class which provides some mathematical tool like a random number generation. There is no 
sense to create a Math object only for getting a random number.

## Syntax ##
The syntax to follow is the following:
* Class name start with an uppercase
* Method name are lowercase
* All names are explicit, a reader should understand what a property contains or what a method do only by reading its name
* Camelcase is used for easier reading (eg. aMethodName(), aLongNameProperty, ThisIsAClassInCamelCaseSyntax)
* Indentation has to be 2 spaces wide
* A semicolon at the end of the line is optional but to avoid ambiguity it should be placed at the end of each line 
    (when declaring local property it is required thus to avoid error it is better to put one at the end of each lines). 
* One class by file, the file has the name of the class and the _.lua_ extension.
* One method do one thing. Has a rule of thumb, a method should be contained on the screen.
* Public methods are methods that can be used by an external user (object), if the method should not be used if has to be 
    private.
* Each method should be unit tested (see **unit test**).
* Each method has to be commented, excepted getters and setters.
* Code duplicate is forbidden. If a code has to be duplicated it should be extracted and put in a method.

## Unit test ##
To limit bug, ensure each method does its work without error and follow methods evolution, they are unit tested. These 
tests check the result of a method against a predicted value for given parameters. If the test pass the method has the 
required behaviour. If the test fail the method has an error in its behaviour and should be modified for all tests pass. 
Unit tests are safety nets tracking methods behaviour and warning the developer if a method result change and limit bugs.
```lua
luaunit = require('luaunit');
Test = class {};

function Test:testMethod()
  ...
  luaunit.assert(actual, expected);
end

os.exit(luaunit.LuaUnit.run());
```
Be aware that in lua what we define as private method cannot be unit tested.

## Tutorial ##
### Basic ###
We are going to write a small application with Animals. First the application launcher. We create a _main.lua_ file 
responsible of creating objects and calling their methods.
```lua
-- main.lua
-- Author: joel
-- Date: 8/20/15

package.path = package.path..';./src/?.lua;./lib/?.lua'

require 'OOP'
```

`package.path` line register src and lib folder to path to quickly load package
`require 'OOP'` include the OOP.lua file for simplified object oriented programming
You can see the file has a header with the file name, its author and its creation date.

#### Animal.lua ####

In _src_ folder we add an _Animal.lua_ file defining an Animal class.
```lua
-- Animal.lua
-- Author: joel
-- Date: 8/20/15

--- An animal
--  @class Animal
--  @author joel
Animal = {}

--- Private Class Properties
--  @section

--- Private Class Methods
--  @section

--- Public Class Methods
--  @section

function Animal.new()
  local self = class {}

  --- Private Instance Properties
  --  @section

  --- Private Instance Methods
  --  @section

  --- Public Instance Methods
  --  @section

  -- Constructor Methods Call --

  return self
end
```

Public properties section have been removed because they should not exist.

An animal has a name, an age, and a size. These properties are specific to each animal thus, they are instance properties.
```lua
--- Private Instance Properties
--  @section

local _name;
local _age;
local _size;
```

We add getters and setters. And we add limit to age and size and check they are valid numbers.
```lua
...
function self.setAge(age)
    assert(age, "age is not set");
    local ageN = assert(tonumber(age), age.."is not a number");
    if ageN >= 0 then
      _age = ageN;
    end
  end
...
```

Because the check is the same for age and size we can define a private method doing this check. Do not forget to add 
documentation comments.
```lua
...
local function checkAgeAndSize(arg)
  assert(arg, "nil value");
  local argN = assert(tonumber(arg), arg.." is not a number");
  if argN >= 0 then
    return argN;
  else
    error(arg.." is negative")
  end
end
...
```

We can then call this method in both age and size setter:
```lua
...
function self.setAge(age)
  _age = checkAgeAndSize(age);
end

function self.setSize(size)
  _size = checkAgeAndSize(size);
end
...
```

If we try to create an animal with an age value of -3 the method rise an error: `lua: ./src/Animal.lua:38: -3 is negative` and a stacktrace 
to locate the error.

We add a print function to display the animal characteristic.
```lua
...
function self.print()
  print(_name..', age: '.._age..', size: '.._size);
end
...
```

Let say an animal can talk (in a way they are). We add a talk method to the Animal class. This method is public thus can 
be accessed by an external class.
```lua
...
function self.talk()
  print(_name.." is talking");
end
...
```

#### Dog.lua ####
We create another file _Dog.lua_, defining a Dog class inheriting from Animal (of course a dog is an animal).
```lua
...
function Dog.new(name, age, size)
  local self = class {Animal.new()};
...
```

Because it inherits from animal all methods defined in Animal are also defined in Dog. Name, age and size are compulsory 
for a dog creation thus they are parameters in the constructor. We then call setters in the constructor methods call to 
set the corresponding value.
```lua
...

-- Constructor Methods Call --

self.setName(name);
self.setAge(age);
self.setSize(size);

return self
```

A dog bark so we override the talk method. That means we write a method talk to dog which will be called instead of the 
mother class' talk method.
```lua
function self.talk()
  print(self.getName().." is barking");
end
```

We need to call `self.getName()` and cannot use `_name` because the last one is private to the Animal class and not 
accessible from external class as well as child classes.

#### main.lua ####
In _main.lua_ we create a dog, print its characteristics through the print method then we make it bark
```lua
...
dog = Dog.new('doggy', 3, 50);
dog.print();
dog.talk();
...
```

### Advanced ###
We are going to add a Cat class inheriting from Animal in a same manner. But before we are going to modify the Animal 
class to avoid calling setName, setAge and setSize in both Dog and Cat classes.
```lua
...
function Animal.new(name, age, size)
  local self = class {}
...
-- Constructor Methods Call --

  self.setName(name);
  self.setAge(age);
  self.setSize(size);
...
```

It is possible to set the name, age and size value directly without using setters but by doing this we lose the check. 

In dog when inheriting from Animal we pass the name, age and size arguments in the class call and we remove the setter call.
```lua
...
function Dog.new(name, age, size)
  local self = class {Animal.new(name, age, size)};
...
```

Then in _Cat.lua_.
```lua
...
function Cat.new(name, age, size)
  local self = class {Animal.new(name, age, size)}
...
```

So in _main.lua_ we can add.
```lua
...
cat = Cat.new('kitty', 1, 10);
cat.print();
cat.talk();
```

You can see when we call `cat.talk()` lua prints `kitty is talking`. That is because we have not overridden the talk 
method for _Cat_ so it is the _Animal talk_ method which is called.

### Multiple Inheritance ###
This design support multiple inheritance through the _OOP.lua_ library. We are going to create a _Felis_ class and _Cat_ 
will inherit from _Animal_ but also from _Felis_. That is not correct in a programming point of view but for the exercise 
it is convenient. It has a simple method which return true.
```lua
-- Felis.lua
-- Author: joel
-- Date: 8/21/15

--- A Felis
-- @classmod Felis
-- @author joel
Felis = {}

--- Private Class Properties
-- @section

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

  return self
end
```

The class _Cat_ require the _Felis.lua_ file and inherits from _Animal_ and also _Felis_.
```lua
...
require 'Felis'
...
local self = class {Animal.new(name, age, size), Felis.new()}
...
```

Then in main we can call `print(cat.isFelis())` and it prints `true`. However if we try `print(dog.isFelis())` it returns 
an error because the method does not exists.
```
lua: main.lua:18: attempt to call field 'isFelis' (a nil value)
stack traceback:
        main.lua:18: in main chunk
        [C]: in ?
```