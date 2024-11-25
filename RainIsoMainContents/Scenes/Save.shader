shader_type canvas_item;

uniform vec4 OLDCOLOR1 : hint_color;

uniform vec4 NEWCOLOR1 : hint_color;

void fragment() {
	vec4 curr_color = texture(TEXTURE,UV);
	
	//LOL
	if (curr_color == OLDCOLOR1)
	{
		COLOR = NEWCOLOR1;
	}
	else
	{
		//yeah
		COLOR = curr_color;
	}
}