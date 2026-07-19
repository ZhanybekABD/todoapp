CREATE TABLE users (
                       id SERIAL PRIMARY KEY,
                       first_name VARCHAR(100) NOT NULL,
                       last_name VARCHAR(100) NOT NULL,
                       number_phone VARCHAR(15) NOT NULL UNIQUE
);

CREATE TABLE task (
                      id SERIAL PRIMARY KEY,
                      title VARCHAR(100) NOT NULL,
                      description VARCHAR(1000),
                      completed BOOLEAN NOT NULL,
                      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                      completed_at TIMESTAMP,
                      user_id SERIAL REFERENCES users(id)
);