-- =================== SAE S104 Partie 2 (2023-2024) =========================
-- Schéma relationnel --
/*
Medecin(
    numero (1),
	nom (2),
	prenom (2),
    numAgr (NN),
	age,
	salaire,
	anciennete
)
Patient(
	numeroSS (1),
	nom (NN),
    prenom,
    dateNaissance (NN),
    adresse,
    tel (NN),
    medecinTraitant = @Medecin.numero
)
RDV(
	numeroRDV (1),
	date,
    heure,
    unPatient = @Patient.numeroSS (NN),
    unMedecin = @Medecin.numero (NN)
)
Specialite(
	intitule (1),
	codeARS (2)
)
Certificat(
	leMedecin = @Medecin.numero. (1),
	laSpecialite =@Specialite.intitule(1)
)

-- Contraintes textuelles:
1) L'ancienneté (en année) est strictement positive.
2) Le salaire brut mensuel doit être superieur à 2 fois le Smic (1747 euros)
3) DOM(heure) = [8; 9; ...; 10]
4) Certificat[laSpecialite] = Medecin[numero] (Chaque médecin doit avoir au moins une specialité)
*/

CREATE TABLE Medecin(
    numero NUMBER CONSTRAINT pk_Medecin PRIMARY KEY,
    nom VARCHAR2(50),
    prenom VARCHAR2(50),
    numAgr NUMBER CONSTRAINT nn_numAgr NOT NULL,
    age NUMBER,
    salaire NUMBER CONSTRAINT ck_salaire2smic CHECK (salaire >1747*2),
    anciennete NUMBER CONSTRAINT ck_anciennetepos CHECK (anciennete > 0),
    CONSTRAINT uq_nom_prenom UNIQUE (nom,prenom)
);



CREATE TABLE Specialite(
    intitule VARCHAR2(50) CONSTRAINT pk_Specialite PRIMARY KEY,
    codeARS NUMBER
        CONSTRAINT nn_codeARS NOT NULL
        CONSTRAINT uq_codeARS UNIQUE
);
CREATE TABLE Certificat(
    leMedecin NUMBER CONSTRAINT fk_Certificat_Medecin REFERENCES Medecin(numero),
    laSpecialite VARCHAR2(50) CONSTRAINT fk_Certificat_Specialite REFERENCES Specialite(intitule),
    CONSTRAINT pk_Certificat PRIMARY KEY (leMedecin,laSpecialite)
);


