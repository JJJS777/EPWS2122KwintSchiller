set timezone = 'Europe/Berlin';


CREATE TABLE users (
	userID			SERIAL				PRIMARY KEY,
	user_name 		VARCHAR(50)			NOT NULL,
	firstname		VARCHAR(20)			NOT NULL,
	lastname		VARCHAR(20)			NOT NULL,
	password		VARCHAR(200)		NOT NULL,
	created_at 		TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE SEQUENCE userID_seq 
	START WITH 1 
	INCREMENT BY 1;


CREATE TABLE artworks (
	artworkID 		SERIAL				PRIMARY KEY,
	title			VARCHAR(500)		NOT NULL,
	year			VARCHAR(200),
	artist			VARCHAR(500),
	objectName		VARCHAR(500),
	classification	VARCHAR(500),
	medium			VARCHAR(500),
	dimensions		VARCHAR(500),
	country			VARCHAR(200),
	license			VARCHAR(100),
	primaryImage	VARCHAR(500),
	format			VARCHAR(200),
	motive			VARCHAR(200),
	copyright		BOOL,
	lent			BOOL,
	loanUntil		DATE,
	loanExtended	BOOL
);

CREATE SEQUENCE artworkID_seq 
	START WITH 1 
	INCREMENT BY 1;

CREATE TABLE favorites (
	userID			SERIAL		REFERENCES	users(userID),
	artworkID		SERIAL 		REFERENCES	artworks(artworkID),
	addad			TIMESTAMPTZ DEFAULT Now(),
	PRIMARY KEY (userID, artworkID)
);