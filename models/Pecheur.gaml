/**
* Name: Pecheur
* Based on the internal empty template. 
* Author: Rinelfi
* Tags: 
*/
model Pecheur

import './Personne.gaml'
import './Mareyeur.gaml'
import './Crabe.gaml'
/* Insert your model definition here */
species Pecheur parent: Personne {
	bool a_la_peche;
	int nombre_crabe_capture;
	int nombre_de_capture_maximal;
	int jours_de_stockage;
	list<Mareyeur> mareyeur_habitues;
	list<Mareyeur> mareyeur_inconnus;

	init {
		couleur <- #green;
		nombre_de_capture_maximal <- 100;
		location <- any_location_in(environnement_marche);
	}

	action rentrer {
		a_la_peche <- false;
		location <- any_location_in(environnement_marche);
	}

	action pecher {
		a_la_peche <- true;
		location <- any_location_in(environnement_crabe);
		list<Crabe> crabes <- (agents of_generic_species Crabe) at_distance (5);
		if (length(crabes) < nombre_de_capture_maximal) {
			ask crabes {
				myself.nombre_crabe_capture <- myself.nombre_crabe_capture + 1;
				do die;
			}

		} else {
			nombre_crabe_capture <- nombre_de_capture_maximal;
			loop i from: 0 to: nombre_de_capture_maximal - 1 {
				ask crabes[i] {
					do die;
				}

			}

		}
	}

	action vendre {
		Mareyeur mareyeur <- Mareyeur closest_to (self);
		mareyeur.nombre_crabe_obtenu <- nombre_crabe_capture;
		nombre_crabe_capture <- 0;
		if (mareyeur_habitues index_of mareyeur < 0) {
			add mareyeur to: mareyeur_habitues;
		}
	}

	reflex travailler {
		if (a_la_peche or nombre_crabe_capture > 10) {
			do rentrer;
		} else {
			do pecher;
		}

	}

	reflex vendre when: !a_la_peche {
		if (nombre_crabe_capture >= 10) {
			do vendre;
		} else {
			jours_de_stockage <- jours_de_stockage + 1;
		}

	}
	
	reflex consommer when: jours_de_stockage >=2 {
		jours_de_stockage <- 0;
		nombre_crabe_capture <- 0;
	}

	aspect {
		draw circle(1) color: couleur border: #black;
	}

}