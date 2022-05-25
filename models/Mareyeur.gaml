/**
* Name: Mareyeur
* Based on the internal empty template. 
* Author: Rinelfi
* Tags: 
*/
model Mareyeur

import './Personne.gaml'
/* Insert your model definition here */
species Mareyeur parent: Personne {
	int nombre_crabe_obtenu;

	init {
		couleur <- #red;
		location <- any_location_in(environnement_marche);
	}
	
	reflex travailler {
		location <- any_location_in(environnement_marche);
	}

	aspect {
		draw circle(1) color: couleur border: #black;
	}

}