/**
* Name: Personne
* Based on the internal empty template. 
* Author: Rinelfi
* Tags: 
*/
model Personne

import './Plan.gaml'

/* Insert your model definition here */
species Personne skills: [moving] {
	geometry forme;
	rgb couleur;
	agent environnement_crabe;
	agent environnement_marche;
	agent environnement_exportation;

	init {
		environnement_crabe <- Plan[0, 0];
		environnement_marche <- Plan[1, 0];
		environnement_exportation <- Plan[2, 0];
		couleur <- #white;
		forme <- circle(1);
		location <- any_location_in(environnement_marche);
	}

	aspect {
		draw forme color: couleur border: #black;
	}

}

species Pecheur parent: Personne {
	bool a_la_peche;
	int nombre_crabe_capture;
	list<unknown> mareyeur_habitues;

	init {
		a_la_peche <- false;
		nombre_crabe_capture <- 0;
		mareyeur_habitues <- [];
		couleur <- #green;
	}

	action pecher {
		a_la_peche <- true;
		write location;
	}

	action rentrer_a_la_terre_ferme {
		a_la_peche <- false;
		write location;
	}

	reflex travailler {
		if (a_la_peche) {
			do rentrer_a_la_terre_ferme;
			location <- any_location_in(environnement_marche);
		} else {
			do pecher;
			location <- any_location_in(environnement_crabe);
		}

	}

}