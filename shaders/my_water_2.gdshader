shader_type spatial;
//
//void vertex() {
	//// Called for every vertex the material is visible on.
	//
	//VERTEX.y = sin((sin(VERTEX.z + TIME*4.0) + sin(VERTEX.x + TIME*4.0)));
	//
//}
//
void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = vec3(0.02, 0.45, 0.8);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}

uniform float time;

void vertex() {
    // Calculate the distance from the vertex to the center
    vec3 center = vec3(0.5, 0.5, 0.0); // Center of the plane, assuming normalized UVs
    vec3 vertexPosition = vec3(VERTEX);

    // Calculate the distance from the vertex to the center
    float distanceToCenter = length(vertexPosition.xz - center.xz);
    
    // Determine the displacement amount based on the distance and time
    float rippleStrength = 0.5; // Adjust the strength of the ripple effect
    float rippleSpeed = 3.0;    // Adjust the speed of the ripple propagation
    
    float displacement = rippleStrength * sin(distanceToCenter  - TIME * rippleSpeed);
    
    // Apply displacement to the vertex position
    VERTEX.y += displacement;
}
