class Chef::Node
  
  def lua_type(v)
    return lua_string(v) if v.kind_of?(String)
    return lua_int(v) if v.kind_of?(Integer)
    return "true" if v.kind_of?(TrueClass)
    return "false" if v.kind_of?(FalseClass)
    return lua_array(v) if v.kind_of?(Array)
    return lua_hash(v) if v.kind_of?(Hash)
  end

  def lua_string(v)
    "\"#{v}\""
  end

  def lua_int(v)
    v.to_s
  end

  def lua_array(v)
    "{" + v.map { |x| lua_type(x) }.join(', ') + "}"
  end

  def lua_hash(v)
    "{" + v.keys.map { |k| "#{k} = #{lua_type(v[k])}" }.join(', ') + "}"
  end
end