/**
* Name: Crabe
* Based on the internal empty template. 
* Author: Rinelfi
* Tags: 
*/
model Crabe

import './Plan.gaml'
/* Insert your model definition here */
species Crabe {
	int age;
	int age_de_maturite;
	int taille;
	string sexe;
	rgb couleur;
	agent environnement_crabe;

	init {
		environnement_crabe <- Plan[0, 0];
		sexe <- 'male';
		age_de_maturite <- 4;
		couleur <- rgb(255, 255, 255);
		location <- any_location_in(environnement_crabe);
	}

	reflex deplacer {
		location <- any_location_in(environnement_crabe);
	}

	reflex grandir {
		if (age > 365 * 20) {
			do die;
		} else {
			age <- age + 1;
		}

	}

	aspect icone {
		draw square(1) color: couleur border: #black;
	}

}

species Femelle parent: Crabe {
	bool ovee;
	int jours_d_incubation;
	int mois_d_incubation;

	init {
		sexe <- 'femelle';
		mois_d_incubation <- 5;
		do feconder fecondation: false;
	}

	action pondre {
		create Crabe number: rnd(500) with: (age: 1);
		create Femelle number: rnd(500) with: (age: 1);
	}

	action feconder (bool fecondation) {
		ovee <- fecondation;
		couleur <- fecondation ? #red : #pink;
		jours_d_incubation <- ovee ? 1 : 0;
	}

	reflex fecondable when: age >= 365 * age_de_maturite and !ovee {
		Crabe male <- Crabe where (each distance_to self <= 2) closest_to (self);
		if (male != nil) {
			ask male {
				if (self.age >= 365 * age_de_maturite) {
					ask myself {
						do feconder fecondation: true;
					}

				}

			}

		}

	}

	reflex incuber when: ovee and jours_d_incubation <= 30 * mois_d_incubation {
		jours_d_incubation <- jours_d_incubation + 1;
	}

	reflex periode_de_ponte when: ovee and jours_d_incubation > 30 * mois_d_incubation {
		do pondre;
		do feconder fecondation: false;
		do die;
	}

	/*
	action recherche_crabe_male {
		ask Crabe where(each.sexe = 'male' and (location distance_to each.location) <= 20){
			self.couleur <- rgb(160, 160, 160);
		}
	}
	*/
	aspect icone {
		draw square(1) color: couleur border: #black;
	} }