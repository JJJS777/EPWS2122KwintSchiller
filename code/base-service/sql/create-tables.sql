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