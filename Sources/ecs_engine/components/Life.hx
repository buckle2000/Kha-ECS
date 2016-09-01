package ecs_engine.components;

import hscript.Expr;
import hscript.Parser;

class Life {
    public var script_str(default, set):String;
    var expr:Expr;
    
    public function new(?str:String) {
        script_str = str;
        expr = null;
    }
    
    function set_script_str(value:String):String {
        script_str = value;
        expr = null;
        return value;
    }
    
    public function get_expr(parser:Parser):Expr {
        if (expr == null) {
            try {
                expr = parser.parseString(script_str);
            } catch (e:Dynamic) {
                expr = null;
                trace(e);
                return null;
            }
        }
        return expr;
    }
}
