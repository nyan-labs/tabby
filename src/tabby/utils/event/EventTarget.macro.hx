package tabby.utils.event;

import haxe.macro.Expr.ComplexType;
import haxe.macro.Expr.TypeDefinition;
import haxe.macro.TypeTools;
import haxe.macro.Context;
import haxe.macro.Expr;

import haxe.Rest;
import tabby.utils.macro.Subfield;

using Lambda;

class EventTarget {
  // clean up this shit man
  public static function build(): Array<Field> {
    var fields = Context.getBuildFields();

    var event_fields = fields
      .filter(f -> f.name != "new" && f.meta.exists(i -> i.name == "event"))
      .filter(f -> {
        fields.remove(f);
      });

    var listeners = macro new Array<haxe.Rest<Any>->Void>();

    fields.push({
      name: "__listeners",
      access: [APrivate],
      kind: FVar(macro: Array<haxe.Rest<Any>->Void>, listeners),
      pos: Context.currentPos()
    });
    
    var emit_fields = event_fields.map(field -> {
      field.access = [APublic];
      
      field.kind = switch field.kind {
        case FFun(f): FFun({
          args: f.args,
          params: f.params,
          ret: macro: Void,
          expr: macro {
            var name = $v{field.name};
            trace('emit $name');
            
            for(listener in __listeners) {
              listener($a{f.args.map(a -> macro $i{a.name})});
            }
            trace(__listeners);
          }
        });
        
        case _: throw "no";
      }

      return field;
    });

    var emit = Subfield.make_subfield("emit", emit_fields, [APublic]);

    fields.push(emit);


    var on_fields = event_fields.map(field -> {
      field.access = [APublic];
      
      field.kind = switch field.kind {
        case FFun(f): FFun({
          args: [{
            name: "listener",
            type: TFunction(f.args.map(a -> TNamed(a.name, a.type)), macro: Void)
          }],
          // args: f.args,
          params: f.params,
          ret: macro: Void,
          expr: macro {
            __listeners.push(cast listener);
          }
        });
        
        case _: throw "no";
      }

      return field;
    });

    var on = Subfield.make_subfield("on", on_fields, [APublic]);
    
    fields.push(on);


    var once_fields = event_fields.map(field -> {
      field.access = [APublic];
      
      field.kind = switch field.kind {
        case FFun(f): FFun({
          args: f.args,
          params: f.params,
          ret: macro: Void,
          expr: macro {
            var name = $v{field.name};
            trace('once $name');
          }
        });
        
        case _: throw "no";
      }

      return field;
    });

    var once = Subfield.make_subfield("once", once_fields, [APublic]);
    
    fields.push(once);
    
    // // make .on .once .emit by making this a util class :3
    // for(field in fields.filter(f -> 
    //   f.name != "new" &&
    //   f.meta.exists(i -> i.name == "event") &&
    //   f.kind.match(FFun(_))
    // )) {
    //   var f = switch field.kind {
    //     case FFun(f): f;
    //     case _: continue;
    //   };

    //   fields.remove(field);

    //   final event_name = field.name;

    //   var emitter_field = {
    //     name: '$event_name',
    //     kind: FFun({
    //       args: f.args,
    //       ret: macro: Void,
    //       expr: null
    //     }),
    //     access: field.access,
    //     pos: Context.currentPos()
    //   };
    //   emitter_fields.push(emitter_field);

    //   emitter_object_fields.push({
    //     field: event_name,
    //     expr: {
    //       expr: EFunction(FNamed(event_name), {
    //         args: f.args,
    //         expr: macro {
    //           var args = $a{f.args.map(a -> macro $i{a.name})};
    //           args.unshift(cast $v{event_name});
    //           for(listener in this.__event_listeners) {
    //             listener(args);
    //           }
    //         } 
    //       }),
    //       pos: Context.currentPos()
    //     }
    //   });
    //   // = macro {
    //   //   var args = $a{f.args.map(a -> macro $i{a.name})};
            
    //   //   trace("hi");
    //   //   for(listener in []) {
    //   //     listener(args);
    //   //   }
    //   // }

    //     // make emit.${field.name}, on., once., etc
    //     // yes there is a macro limitation you'll work it out
    // }

    // fields.push({
    //   name: "__event_listeners",
    //   kind: FVar(macro: Array<Array<Any>->Void>, macro new Array()),
    //   pos: Context.currentPos()
    // });

    // var emitter_type = TAnonymous(emitter_fields);

    // fields.push({
    //   name: "emit",
    //   kind: FVar(emitter_type, null),
    //   access: [APublic],
    //   pos: Context.currentPos()
    // });

    // var emitter = {
    //   expr: EObjectDecl(emitter_object_fields),
    //   pos: Context.currentPos()
    // };
    
    // var constructor_field = fields.find((f) -> f.name == "new") ?? {
    //   name: "new",
    //   access: [APublic],
    //   kind: FFun({
    //     args: [],
    //   }),
    //   pos: Context.currentPos()
    // };

    // switch constructor_field.kind {
    //   case FFun(f):
    //     var exprs = if(f.expr != null) switch f.expr.expr { 
    //       case EBlock(exprs):
    //         exprs;
    //       case e:
    //         [{
    //           expr: e,
    //           pos: f.expr.pos
    //         }];
    //     } else [];

    //     exprs.push(macro this.emit = $emitter);

    //     f.expr = {
    //       expr: EBlock(exprs),
    //       pos: Context.currentPos()
    //     }

    //   case _: null;
    // }
    
    // if(!fields.has(constructor_field))
    //   fields.push(constructor_field);
    
    return fields;
  }
}