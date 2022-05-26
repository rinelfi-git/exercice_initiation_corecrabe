/**
* Name: Pecheur
* Based on the internal empty template. 
* Author: Rinelfi
* Tags: 
*/
model Pecheur

import './Mareyeur.gaml'
import './Crabe.gaml'
/* Insert your model definition here */
species Pecheur parent: Personne {
	bool a_la_peche;
	int nombre_de_capture;
	int nombre_de_capture_maximal;
	int jours_de_stockage;
	int argent_gagne;
	list<Mareyeur> mareyeur_habitues;
	list<Mareyeur> mareyeur_inconnus;

	init {
		argent_gagne <- 0;
		couleur <- #green;
		nombre_de_capture_maximal <- 5;
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
				myself.nombre_de_capture <- myself.nombre_de_capture + 1;
				do die;
			}

		} else {
			nombre_de_capture <- nombre_de_capture_maximal;
			loop i from: 0 to: nombre_de_capture_maximal - 1 {
				ask crabes[i] {
					do die;
				}

			}

		}
		write '' + self + ' a capturé : ' + nombre_de_capture + ' crabes';

	}

	action vendre {
		Mareyeur mareyeur <- Mareyeur where (each.nombre_de_crabe < each.quota) closest_to (self);
		if (mareyeur != nil) {
			ask mareyeur {
				write 'achat de crabe à ' + self.prix_d_achat + ' Ariary par le Mareyeur ' + self;
				self.nombre_de_crabe <- self.nombre_de_crabe + myself.nombre_de_capture;
				myself.argent_gagne <- myself.argent_gagne + myself.nombre_de_capture * self.prix_d_achat;
				myself.nombre_de_capture <- 0;
				if (myself.mareyeur_habitues index_of self < 0) {
					add self to: myself.mareyeur_habitues;
				}

			}

		}

	}

	reflex travailler {
		if (a_la_peche or nombre_de_capture > 10) {
			do rentrer;
		} else {
			do pecher;
		}

	}

	reflex vendre when: !a_la_peche {
		if (nombre_de_capture = nombre_de_capture_maximal) {
			do vendre;
		} else {
			jours_de_stockage <- jours_de_stockage + 1;
		}

	}

	reflex consommer when: jours_de_stockage >= 2 {
		jours_de_stockage <- 0;
		nombre_de_capture <- 0;
	}
	
	reflex acheter_biens when:argent_gagne > 0 {
		argent_gagne <- argent_gagne - rnd(argent_gagne);
	}

	aspect icone {
		draw circle(1) color: couleur border: #black;
	}

}