package ecs_engine.components;

import kha.math.FastMatrix3;
import kha.FastFloat;
import eskimo.Entity;

class Transform {
    public var entity(default ,null):Entity;
    public var parent:Transform = null;
    
    public var x(default, set):FastFloat = 0.0;
    public var y(default, set):FastFloat = 0.0;
    public var rotation(default, set):FastFloat = 0.0;
    public var scaleX(default, set):FastFloat = 1.0;
    public var scaleY(default, set):FastFloat = 1.0;
    
    var localMatrix:FastMatrix3;
    var dirty:Bool = true;
    
    public function new(?e:Entity) {
        entity = e;
    }
    
    function set_x(value:FastFloat) {
        return x = value;
    }
    
    function set_y(value:FastFloat) {
        return y = value;
    }
    
    function set_rotation(value:FastFloat) {
        return rotation = value;
    }
    
    function set_scaleX(value:FastFloat) {
        return scaleX = value;
    }
    
    function set_scaleY(value:FastFloat) {
        return scaleY = value;
    }
    
    public function getLocalMatrix():FastMatrix3 {
        if (dirty) {
            var c:FastFloat = Math.cos(rotation);
            var s:FastFloat = Math.sin(rotation);
            localMatrix = new FastMatrix3(scaleX*c, -scaleY*s, x, scaleX*s, scaleY*c, y, 0, 0, 1);
            dirty = false;
        }
        return localMatrix;
    }
    
    public function getWorldMatrix():FastMatrix3 {
        var matrix = getLocalMatrix();
        if (parent == null) return matrix;
        else return parent.getWorldMatrix().multmat(matrix);
    }
    
    public static inline function addTransform(e:Entity, ?t:Transform):Void {
        if (t == null)
            e.set(new Transform(e));
        else {
            t.entity = e;
            e.set(t);
        }
	}
    
    public static function setParent(child_entity:Entity, parent_entity:Entity) {
        child_entity.get(Transform).parent = parent_entity.get(Transform);
    }
}
