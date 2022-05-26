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
	}

}



