/**
* Name: Mareyeur
* Based on the internal empty template. 
* Author: Rinelfi
* Tags: 
*/
model Mareyeur

import './Collecteur.gaml'

/* Insert your model definition here */
species Mareyeur parent: AgentCommercial {
	int prix_d_achat;

	init {
		quota <- 200;
		couleur <- #red;
		prix_d_achat <- rnd(4000, 4500, 50);
		location <- any_location_in(environnement_marche);
	}

	reflex deplacer {
		location <- any_location_in(environnement_marche);
	}

	reflex vendre_crabe {
		Collecteur collecteur <- Collecteur where (each.nombre_de_crabe < each.quota and each overlaps environnement_marche) closest_to (self);
		if (collecteur != nil) {
			ask collecteur {
				int crabe_a_prendre <- self.quota - self.nombre_de_crabe;
				if (crabe_a_prendre > myself.nombre_de_crabe) {
					self.nombre_de_crabe <- self.nombre_de_crabe + myself.nombre_de_crabe;
					myself.nombre_de_crabe <- 0;
				} else {
					self.nombre_de_crabe <- self.nombre_de_crabe + crabe_a_prendre;
					myself.nombre_de_crabe <- myself.nombre_de_crabe - crabe_a_prendre;
				}

			}

		}

	}

	aspect icone {
		draw circle(1) color: couleur border: #black;
	}

}