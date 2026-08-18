package tabby.utils;

import sys.io.File;
import lua.Table;
import lua.Lua;

enum ScriptResult {
  Success(value: Dynamic);
  Error(message: String);
} 

/**
  be careful lol
*/
@:expose("tabby.utils.Script")
class Script {
  static final SAFE_ENV = untyped __lua__('{
  love = love,
  print = print,
  error = error,
  pairs = pairs,
  ipairs = ipairs,
  next = next,
  pcall = pcall,
  tonumber = tonumber,
  tostring = tostring,
  type = type,
  unpack = unpack,
  coroutine = { create = coroutine.create, resume = coroutine.resume, 
      running = coroutine.running, status = coroutine.status, 
      wrap = coroutine.wrap },
  string = { byte = string.byte, char = string.char, find = string.find, 
      format = string.format, gmatch = string.gmatch, gsub = string.gsub, 
      len = string.len, lower = string.lower, match = string.match, 
      rep = string.rep, reverse = string.reverse, sub = string.sub, 
      upper = string.upper },
  table = { insert = table.insert, maxn = table.maxn, remove = table.remove, 
      sort = table.sort },
  math = { abs = math.abs, acos = math.acos, asin = math.asin, 
      atan = math.atan, atan2 = math.atan2, ceil = math.ceil, cos = math.cos, 
      cosh = math.cosh, deg = math.deg, exp = math.exp, floor = math.floor, 
      fmod = math.fmod, frexp = math.frexp, huge = math.huge, 
      ldexp = math.ldexp, log = math.log, log10 = math.log10, max = math.max, 
      min = math.min, modf = math.modf, pi = math.pi, pow = math.pow, 
      rad = math.rad, random = math.random, sin = math.sin, sinh = math.sinh, 
      sqrt = math.sqrt, tan = math.tan, tanh = math.tanh },
  os = { clock = os.clock, difftime = os.difftime, time = os.time },
}');

  inline static function is_bytecode(content: String)
    return content.charCodeAt(0) == 27;

  inline static public function run(path: String, ?env: Table<Dynamic, Dynamic>): ScriptResult {
    var content = File.getContent(path);

    return execute(content, env);
  }

  static public function execute(content: String, ?env: Table<Dynamic, Dynamic>): ScriptResult {
    // is there a reason for this? not much, but i've heard of potential abuse, and i doubt you need this
    if(is_bytecode(content))
      throw "bytecode execution is not allowed in Script.execute";

    var result = Lua.load(content);
    if(result == null || result.func == null)
      return Error(result.message);
    
    // safety
    Lua.setfenv(untyped result.func, env ?? SAFE_ENV);
    
    var pcall = Lua.pcall(result.func);
    return if(pcall.status) 
      Success(pcall.value); 
    else 
      Error(pcall.value);
  }
}