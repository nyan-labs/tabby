package tabby.utils.macro;

import haxe.macro.Printer;
import haxe.macro.ComplexTypeTools;
import haxe.Rest;
import haxe.macro.TypeTools;
import haxe.macro.Expr;
import haxe.macro.Context;

using Lambda;

class Subfield {
  /** side-effect: modifies constructor **/
  public static function make_subfield(name: String, subfields: Array<Field>, access: Array<Access>) {
    var ass = Context.getLocalClass().get();
    if(ass == null) throw "not class context";

    // fields.push({
    //   name: "__event_listeners",
    //   kind: FVar(macro: Array<Array<Any>->Void>, macro new Array()),
    //   pos: Context.currentPos()
    // });

    // var subfield_typedef = macro class $class_name {};

    var object_fields: Array<ObjectField> = subfields.map(f -> ({
      field: f.name,
      expr: switch f.kind {
        case FFun(fn):
          {
            expr: EFunction(FNamed(f.name), fn),
            pos: f.pos
          };
        case FVar(t, e): e;
        case _: Context.error("can't do set/get property fields", f.pos);
      },
      quotes: Unquoted
    }));

    var class_fields: Array<Field> = subfields.map(f -> {
      f.kind = switch f.kind {
        case FFun(fn):
          FFun({
            args: fn.args,
            params: fn.params,
            expr: null,
            ret: fn.ret
          });

        case _: f.kind;
      }

      return f;
    });

    var subfield_struct = {
      expr: EObjectDecl(object_fields),
      pos: Context.currentPos()
    };
    trace(object_fields);

    // trace(subfields);
    var subfield_type: ComplexType = TAnonymous(subfields);
    // (subfield_type, Context.currentPos());
    
    var type_name = '${ass.name}_$name';
    // var name = '$name';
    Context.defineType({
      pack: ass.pack,
      name: type_name,
      pos: Context.currentPos(),
      kind: TDAlias(subfield_type),
      fields: []
    });
    var type = Context.getType(type_name);

    var field: Field = {
      name: name,
      kind: FVar(Context.toComplexType(type)),
      access: access,
      pos: Context.currentPos()
    };

    return {
      constructor: macro this.$name = $subfield_struct,
      field: field
    };
  }


  public static function inject_constructor(fields: Array<Field>, inject_exprs: Array<Expr>) {
    var constructor_field: Field = fields.find((f) -> f.name == "new") ?? {
      name: "new",
      access: [APublic],
      kind: FFun({
        args: [],
      }),
      pos: Context.currentPos()
    };

    switch constructor_field.kind {
      case FFun(f):
        var exprs = if(f.expr != null) switch f.expr.expr { 
          case EBlock(exprs):
            exprs;
          case e:
            [{
              expr: e,
              pos: f.expr.pos
            }];
        } else [];

        exprs = exprs.concat(inject_exprs);

        f.expr = {
          expr: EBlock(exprs),
          pos: Context.currentPos()
        }

      case _: null;
    }

    trace(switch constructor_field.kind {
      case FFun(f): switch f.expr.expr {
        case EBlock(exprs): new Printer().printExprs(exprs, "\n");
        case _: [];
      }
      case _: [];
    });
    
    if(!fields.has(constructor_field))
      fields.push(constructor_field);

    return fields;
  }
}