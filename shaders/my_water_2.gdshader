shader_type spatial;

void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = vec3(0.02, 0.45, 0.8);
}

uniform vec3 center = vec3(0.5, 0.5, 0.0);
uniform bool do_ripple = true;

float ripple(vec3 vertex_pos, float start_time) {
	vec3 vertexPosition = vertex_pos;

    // Calculate the distance from the vertex to the center
    float distanceToCenter = length(vertexPosition.xz - center.xz);
    
    // Determine the displacement amount based on the distance and time
    float rippleStrength = 0.65; // Adjust the strength of the ripple effect
    float rippleSpeed = 3.0;    // Adjust the speed of the ripple propagation
    
    float displacement = rippleStrength * sin(2.0*PI*(distanceToCenter  - TIME * rippleSpeed));
	return displacement/(1.0 +  length((vertex_pos-center))*1.3 );
}

void vertex() {
   
	if(do_ripple) {
		float time_now = TIME;
		float displacement = ripple(VERTEX, time_now);
	    // Apply displacement to the vertex position
	    VERTEX.y += displacement;
	}
 	
}


