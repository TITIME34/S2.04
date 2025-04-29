DROP SCHEMA IF EXISTS partie1 CASCADE;

CREATE SCHEMA partie1;
SET SCHEMA 'partie1';

CREATE TABLE candidat(
  no_candidat INTEGER,
  classement VARCHAR(20) DEFAULT '',
  boursier_lycee VARCHAR(20) NOT NULL,
  profil_candidat VARCHAR(20) NOT NULL,
  etablissement VARCHAR(20) NOT NULL,
  dept_etablissement VARCHAR(20) NOT NULL,
  ville_etablissement VARCHAR(20) NOT NULL,
  niveau_etude VARCHAR(20) NOT NULL,
  type_formation_prec VARCHAR(20) NOT NULL,
  serie_prec VARCHAR(20) NOT NULL,
  dominante_prec VARCHAR(20) NOT NULL,
  specialite_prec VARCHAR(20) NOT NULL,
  LV1 VARCHAR(10) NOT NULL,
  LV2 VARCHAR(10) NOT NULL,
  CONSTRAINT candidat_pk
    PRIMARY KEY(no_candidat)
);

CREATE TABLE individu(
  id_individu INTEGER,
  nom VARCHAR(20) NOT NULL,
  prenom VARCHAR(20) NOT NULL,
  date_naissance DATE NOT NULL,
  code_postal VARCHAR(20) NOT NULL,
  ville VARCHAR(20) NOT NULL,
  sexe CHAR(1) NOT NULL,
  nationalite VARCHAR(20) NOT NULL,
  ine VARCHAR(20) NOT NULL,
  CONSTRAINT individu_pk
    PRIMARY KEY(id_individu)
);

CREATE TABLE etudiant(
  code_nip VARCHAR(20),
  cat_socio_etu VARCHAR(20) NOT NULL,
  cat_socio_parent VARCHAR(20) NOT NULL,
  bourse_superieur BOOLEAN NOT NULL,
  mention_bac VARCHAR(20) NOT NULL,
  serie_bac VARCHAR(20) NOT NULL,
  dominante_bac VARCHAR(20) NOT NULL,
  specialite_bac VARCHAR(20) NOT NULL,
  mois_annee_obtention_bac CHAR(7) NOT NULL,
  CONSTRAINT etudiant_pk
    PRIMARY KEY(code_nip)
);

CREATE TABLE semestre(
  id_semestre INTEGER,
  num_semestre CHAR(5) NOT NULL,
  annee_univ CHAR(9) NOT NULL,
  CONSTRAINT semestre_pk
    PRIMARY KEY(id_semestre)
);

CREATE TABLE module(
  id_module CHAR(5),
  libelle_module VARCHAR(20) NOT NULL,
  ue CHAR(2) NOT NULL,
  CONSTRAINT module_pk
    PRIMARY KEY(id_module)
);

CREATE TABLE _postuler(
  id_individu INTEGER,
  no_candidat INTEGER,
  CONSTRAINT postuler_pk
    PRIMARY KEY(id_individu,no_candidat),
  CONSTRAINT postuler_fk_individu
    FOREIGN KEY(id_individu)
      REFERENCES individu(id_individu),
  CONSTRAINT postuler_fk_candidat
    FOREIGN KEY(no_candidat)
      REFERENCES candidat(no_candidat)
);

CREATE TABLE _sinscrire(
  id_individu INTEGER,
  code_nip VARCHAR(20),
  CONSTRAINT sinscrire_pk
    PRIMARY KEY(id_individu,code_nip),
  CONSTRAINT sinscrire_fk_individu
    FOREIGN KEY(id_individu)
      REFERENCES individu(id_individu),
  CONSTRAINT sinscrire_fk_etudiant
    FOREIGN KEY(code_nip)
      REFERENCES etudiant(code_nip)
);

CREATE TABLE _inscription(
  id_semestre INTEGER,
  code_nip VARCHAR(20),
  groupe_tp CHAR(2) NOT NULL,
  amenagement_evaluation VARCHAR(20) NOT NULL,
  CONSTRAINT inscription_pk
    PRIMARY KEY(id_semestre,code_nip),
  CONSTRAINT inscription_fk_semestre
    FOREIGN KEY(id_semestre)
      REFERENCES semestre(id_semestre),
  CONSTRAINT inscription_fk_etudiant
    FOREIGN KEY(code_nip)
      REFERENCES etudiant(code_nip)
);

CREATE TABLE _resultat(
  id_semestre INTEGER,
  code_nip VARCHAR(20),
  id_module CHAR(5),
  moyenne FLOAT NOT NULL,
  CONSTRAINT resultat_pk
    PRIMARY KEY(id_semestre,code_nip,id_module),
  CONSTRAINT resultat_fk_semestre
    FOREIGN KEY(id_semestre)
      REFERENCES semestre(id_semestre),
  CONSTRAINT resultat_fk_etudiant
    FOREIGN KEY(code_nip)
      REFERENCES etudiant(code_nip),
  CONSTRAINT resultat_fk_module
    FOREIGN KEY(id_module)
      REFERENCES module(id_module)
);

CREATE TABLE _programme(
  id_semestre INTEGER,
  id_module CHAR(5),
  coefficient FLOAT NOT NULL,
  CONSTRAINT programme_pk
    PRIMARY KEY(id_semestre,id_module),
  CONSTRAINT programme_fk_semestre
    FOREIGN KEY(id_semestre)
      REFERENCES semestre(id_semestre),
  CONSTRAINT programme_fk_module
    FOREIGN KEY(id_module)
      REFERENCES module(id_module)
);
