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
A class defined property or method is common to **every** object. That means if object _A_ changes a property _p_, 
object _B_ accesses the new value, the old one is lost. However, object property is specific to **one** object, thus if 
object _A_ changes its property _p_, object _B_ has its _p_ property not changed. For example we can count how many instances 
of a class are created by using a class property. An object property is specific to the created object.

#### Methods ####
In a same way methods can be defined by class or by object. Class defined methods are accessible without creating an instance 
of the class whereas object methods are available through the object. As an example think of a dog object (in a programing 
point of view), the method bark is defined as an object method because it is the dog object which barks and differnet dogs can 
bark differently. For a class method example you can think of a Math class which provides some mathematical tool like a random 
number generation. There is no sense to create a Math object only for getting a random number.

## Syntax ##
The syntax to follow is the following:
* Class names start with an uppercase
* Property and method names are lowercase
* All names are explicit, a reader should understand what a property contains or what a method does only by reading its name
* CamelCase is used for easier reading (eg. aMethodName(), aLongNameProperty, ThisIsAClassInCamelCaseSyntax)
* Indentation has to be 2 spaces wide
* A semicolon at the end of the line is optional but to avoid ambiguity it should be placed at the end of each line 
    (when declaring local property it is required thus to avoid errors it is better to put one at the end of each line).
* One class by file, the file has the name of the class and the _.lua_ extension.
* One method does one thing. As a rule of thumb, the definition of a method should fit on the screen.
* Public methods are methods that can be used by an external user (object). If the method should not be used by an external user (object) it has to be 
    private.
* Each method should be unit tested (see **unit test**).
* Each method has to be commented, except getters and setters.
* Code duplicate is forbidden. If a code has to be duplicated it should be extracted and put in a method.

## Class Structure ##
As shown by the template _Template.lua_ the class structure to follow is the following:
* The header of the file containing the file name, the author and the creation date
* All requirement
* The class table
* The private class properties
* The private class methods
* The public class methods
* The constructor
* The instance creation (called self) with the inheritance command
* The private instance properties
* The private instance methods
* The public instance methods
* The call to methods for building an instance. These methods' call are used for setting the instance default values
* The operator overloading

## Unit test ##
To limit bugs, ensure each method does its work without error and follow methods evolution, they are unit tested (Attention: This has nothing to do with the term "Unit" in Osmose). These 
tests check the result of a method against a predicted value for given parameters. If the tests are passed, the method has the 
required behaviour. If the tests fail, the method has an error in its behaviour and should be modified until all tests are passed. 
Unit tests are safety nets tracking methods behaviour, and warn the developer if a method's result changes thus limiting bugs.
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
For more information about luaunit have a look at http://luaunit.readthedocs.org/en/latest/

## Template ##
A class template _Template.lua_ is available in the main folder.

## Documentation ##
To create the documentation we use LDoc with the command `ldoc --all src'. Its output is written to the doc folder.

## IDE ##
I personally use IntelliJ IDEA community edition with the lua plugin for development. Have a look here 
https://bitbucket.org/sylvanaar2/lua-for-idea/wiki/Home for more information.

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

The `package.path` line registers src and lib folders to the path to quickly load packages.
`require 'OOP'` includes the OOP.lua file for simplified object oriented programming
You can see the file has a header with the file name, its author and its creation date.

#### Animal.lua ####

In the _src_ folder we add an _Animal.lua_ file defining an Animal class.
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

We add getters and setters. And we add a limit to age and size and check that they are valid numbers.
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

If we try to create an animal with an age value of -3 the method rises an error: `lua: ./src/Animal.lua:38: -3 is negative` and a stacktrace 
to locate the error.

We add a print function to display the animal characteristic.
```lua
...
function self.print()
  print(_name..', age: '.._age..', size: '.._size);
end
...
```

Lets say an animal can talk (in a way they are). We add a talk method to the Animal class. This method is public thus can 
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

Because it inherits from animal, all methods defined in Animal are also defined in Dog. Name, age and size are compulsory 
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

A dog barks so we override the talk method. That means we write a method "talk" specific to "dog" which will be called instead of the 
mother class' "talk" method.
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

It is possible to set the name, age and size value directly without using setters but by doing this we loose the check. 

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

You can see when we call `cat.talk()` lua prints `kitty is talking`. That is because we have not overwritten the talk 
method for _Cat_ so it is the _Animal talk_ method which is called.

### Multiple Inheritance ###
This design supports multiple inheritance through the _OOP.lua_ library. We are going to create a _Felis_ class and _Cat_ 
will inherit from _Animal_ but also from _Felis_. That is not correct from a programming point of view but for the exercise
it is convenient. It has a simple method which returns true.
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

The class _Cat_ requires the _Felis.lua_ file and inherits from _Animal_ and also _Felis_.
```lua
...
require 'Felis'
...
local self = class {Animal.new(name, age, size), Felis.new()}
...
```

Then in main we can call `print(cat.isFelis())` and it prints `true`. However if we try `print(dog.isFelis())` it returns 
an error because the method does not exist.
```
lua: main.lua:18: attempt to call field 'isFelis' (a nil value)
stack traceback:
        main.lua:18: in main chunk
        [C]: in ?
```

### Operator Overloading ###
Operator overloading is a little like property overloading, we redefine how an operator (+, -, * etc) has to behave. For 
this we use a metatable. It allows for example to add two objects using the + operator or to print directly an object without 
a print method like we have in _Animal_. First we add a metatable to animal.
```lua
...
local meta = {};
...
```
Before returning the instance of an animal we set the functions of the metatable of the instance and we set its metatable.
```lua
...
meta.__tostring = function ()
 return _name..', age: '.._age..', size: '.._size;
end
setmetatable(self, meta);
...
```
Then we can remove the print function of _Animal_ and in _main_ instead of `dog.print();` we can call `print(dog);`. It 
does not change a lot in this example but it is very powerful.

#### With Inheritance ####
_OOP.lua_ manages metatable inheritance and children inherit the metatable as well as other properties. *BE CAREFUL*: In 
case of multiple inheritance, metatable functions present in both motherclasses, like in the _Cat_ class inheriting from 
_Animal_ and _Felis_, the function from the last motherclass overrides all the previous classes. For example we can add a 
_tostring_ override in _Felis_.
```lua
...
meta.__tostring =
  function ()
    return 'Felis';
  end
...
```
Because _Cat_ inherits from _Animal_ and _Felis_ its metatable is composed of both. Both parent metatables define the same 
function _tostring_, however, the last one (here _Felis_) is the one keeped. Thus when we call `print(dog);` it returns 
`doggy, age:3, size: 50`, inherited from _Animal_, but when we call `print(cat);` it returns `Felis`, inherited 
from _Felis_. If we want a custom _tostring_ for _Cat_ we can override (again) the method.
```lua
...
local meta = getmetatable(self);
meta.__tostring =
  function ()
    return self.getName()..', Felis, age: '..self.getAge()..', size: '..self.getSize();
  end

setmetatable(self, meta);
...
```
Remember _Cat_ is a child of _Animal_ so it does not have access to private _Animal_ properties _name_, _age_, _size_ 
thus we have to use the getters. Then by calling `print(cat);` it calls our new overwritten metatable's method and displays 
`kitty, Felis, age: 1, size: 10`.

### Unit test ###
In the _test_ folder we create a _TestAnimal.lua_ file. We set the `package.path` to include the _src_ and _lib_ folders.
We require _luaunit_, _OOP_ and the class we want to test, _Animal_. We create the _TestAnimal_ table and an animal instance.
We crate a _setUp()_ method to create the animal instance on which we are going to work. Then we test the method setSize 
with all possible case, with negative, nil, text and positive size value. Each test runs the method and check its behaviour.
```lua
...
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
...
```
Then we run the script with `lua TestAnimal.lua -o TAP`. The option `... -o TAP` serves to give details on the tests.
To simplify the running of the tests we can create a _testMain.lua_ script file and add a require line for each test class 
we want to run.