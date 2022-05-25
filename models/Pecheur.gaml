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
				write 'capture de crabe ' + self.sexe;
				myself.nombre_crabe_capture <- myself.nombre_crabe_capture + 1;
				do die;
			}
		} else {
			nombre_crabe_capture <- nombre_de_capture_maximal;
			loop i from: 0 to: nombre_de_capture_maximal - 1 {
				ask crabes[i]{
					do die;	
				}
			}
		}

		write 'nombre de crabe capturé: ' + nombre_crabe_capture;
	}

	action vendre {
		Mareyeur mareyeur <- Mareyeur closest_to (self);
		mareyeur.nombre_crabe_obtenu <- nombre_crabe_capture;
		nombre_crabe_capture <- 0;
		if (mareyeur_habitues index_of mareyeur < 0) {
			write 'Nouveau ' + mareyeur + ' pour le ' + self;
			add mareyeur to: mareyeur_habitues;
		}

		write 'mareyeurs conus de ' + self + ' sont : ' + mareyeur_habitues;
	}

	reflex travailler {
		if (a_la_peche or nombre_crabe_capture > 10) {
			do rentrer;
		} else {
			do pecher;
		}

	}

	reflex vendre when: !a_la_peche and nombre_crabe_capture >= 10 {
		do vendre;
	}

	aspect {
		draw circle(1) color: couleur border: #black;
	}

}