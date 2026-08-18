package tabby.utils.macro;

import haxe.macro.ComplexTypeTools;
import haxe.Rest;
import haxe.macro.TypeTools;
import haxe.macro.Expr;
import haxe.macro.Context;

import StringTools;

class Subfield {
  public static function make_subfield(name: String, subfields: Array<Field>, access: Array<Access>): Field {
    var ass = Context.getLocalClass().get();
    if(ass == null) throw "not class context";

    // fields.push({
    //   name: "__event_listeners",
    //   kind: FVar(macro: Array<Array<Any>->Void>, macro new Array()),
    //   pos: Context.currentPos()
    // });

    // var subfield_typedef = macro class $class_name {};
    var subfield_struct = {
      expr: EObjectDecl(subfields.map(f -> ({
        field: f.name,
        expr: switch f.kind {
          case FFun(fn):
            var old = {
              args: fn.args,
              params: fn.params,
              expr: fn.expr,
              ret: fn.ret
            };

            fn.expr = null;
            {
              expr: EFunction(FNamed(f.name), old),
              pos: f.pos
            };
          case FVar(t, e): e;
          case _: Context.error("can't do set/get property fields", f.pos);
        },
        quotes: Unquoted
      }))),
      pos: Context.currentPos()
    };

    trace(subfields);
    var subfield_type: ComplexType = TAnonymous(subfields);

    return {
      name: name,
      kind: FVar(subfield_type, subfield_struct),
      access: access,
      pos: Context.currentPos()
    };
  }
}