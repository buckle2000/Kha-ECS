package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;

import eskimo.Context;
import eskimo.Entity;
import eskimo.View;

using ecs_engine.components.Transform;

class Project {
	var context:Context;
	var graphicsView:View;
	var physicsView:View;
	var vitalityView:View;
	
	public function new() {
		context = new Context();
		graphicsView = new View([Transform], context); // TODO : add rendering component(s)
		physicsView = new View([Transform], context); // TODO : add physics compoennt
		vitalityView = new View([Life], context);
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
	}

	function update(): Void {
		
	}

	function render(framebuffer: Framebuffer): Void {
		
	}
	
	public static inline function createEntitywt(_context:Context):Entity {
		var e = _context.entities.create();
		e.addTransform();
		return e;
	}
}
