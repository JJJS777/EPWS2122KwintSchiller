set timezone = 'Europe/Berlin';


CREATE TABLE users (
	userID		SERIAL			PRIMARY KEY,
	user_name 	VARCHAR(50)		NOT NULL,
	firstname	VARCHAR(20)		NOT NULL,
	lastname	VARCHAR(20)		NOT NULL,
	password	VARCHAR(200)	NOT NULL,
	created_at 	TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE SEQUENCE userID_seq 
	START WITH 1 
	INCREMENT BY 1;


CREATE TABLE artworks (
	artworkID 	SERIAL			PRIMARY KEY,
	title		VARCHAR(200)	NOT NULL,
	year		DATE,
	genre		VARCHAR(50),
	artist		VARCHAR(100),
	typ			VARCHAR(200),
	technique	VARCHAR(200),
	size		VARCHAR(20),
	lent		BOOL,
	country		VARCHAR(100),
	License		VARCHAR(100),
	poster		VARCHAR(200),
	format		VARCHAR(100),
	material	VARCHAR(200),
	motive		VARCHAR(200),
	copyright	BOOL
);

CREATE SEQUENCE artworkID_seq 
	START WITH 1 
	INCREMENT BY 1;

CREATE TABLE favorites (
	userID		SERIAL	REFERENCES	users(userID),
	artworkID	SERIAL 	REFERENCES	artworks(artworkID),
	addad		DATE,
	PRIMARY KEY (userID, artworkID)
);