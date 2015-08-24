function class(args)
  local toReturn = {};
  local toReturnMeta = {};

  for _,i in pairs(args) do
    for k,v in pairs(i) do
	    toReturn[k] = v;
    end
    for k,v in pairs(getmetatable(i)) do
      toReturnMeta[k] = v;
    end
  end

  setmetatable(toReturn, toReturnMeta);
  return toReturn;
end
