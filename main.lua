-- main.lua
-- Author: joel
-- Date: 8/20/15

package.path = package.path..';./src/?.lua;./lib/?.lua'--This register src and lib folder to path to quickly load package

require 'OOP'--Include the OOP.lua file for simplified object oriented programming
require 'Dog'
require 'Cat'

dog = Dog.new('doggy', 3, 50);
dog.print();
dog.talk();
cat = Cat.new('kitty', 1, 10);
cat.print();
cat.talk();
print(cat.isFelis());