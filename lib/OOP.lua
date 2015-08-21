function class(args)
   local toReturn = {}

   for _,i in pairs(args) do
      for k,v in pairs(i) do
	 toReturn[k] = v
      end
   end
   
   return toReturn   
end
