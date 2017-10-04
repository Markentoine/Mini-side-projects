***Classes*** :

=> ***Board***

  => states : @size(integer), @values_to_display(array)
  => methods : 

  			public :
  					`display_values` 

  			private : 

  					`choose_size` ;  `grid`; `top_line`; `cells`

 => ***GameOfLife***

 	=> collaborators : Board, Engine
 	=> states : @size
 	=> methods : 

 				private : choose_size

=> ***Engine***

	=> initial_state
	=> collaborator : Board
draft : 

Using a GUI to choose the initial alive cells