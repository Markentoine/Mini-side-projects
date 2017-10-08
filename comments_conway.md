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

At the beginning, user is asked the size of the board and the live cells wanted at the beginning of the game.
The initial Board is then displayed.

Then the game runs : until the death of every cells or when the user hit a key to stop the game.

