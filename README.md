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
* Each method should be unit tested (see [unit test](#unit-test))

## <a name="unit-test"></a>Unit test ##
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