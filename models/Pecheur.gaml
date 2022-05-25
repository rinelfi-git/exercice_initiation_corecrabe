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
	list<Mareyeur> mareyeur_habitues;
	list<Mareyeur> mareyeur_inconnus;

	init {
		couleur <- #green;
		location <- any_location_in(environnement_marche);
	}

	action rentrer {
		a_la_peche <- false;
		location <- any_location_in(environnement_marche);
	}

	action pecher {
		a_la_peche <- true;
		location <- any_location_in(environnement_crabe);
		list<Crabe> male <- Crabe at_distance (5);
		list<Femelle> femelle <- Femelle at_distance (5);
		ask male {
			myself.nombre_crabe_capture <- myself.nombre_crabe_capture + 1;
			do die;
		}

		ask femelle {
			myself.nombre_crabe_capture <- myself.nombre_crabe_capture + 1;
			do die;
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
		if (a_la_peche) {
			do rentrer;
			do vendre;
		} else {
			do pecher;
		}

	}

	aspect {
		draw circle(1) color: couleur border: #black;
	}

}