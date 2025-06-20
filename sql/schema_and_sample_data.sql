
-- Tablas base
CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    handicap INTEGER NOT NULL DEFAULT 0,
    team_id INTEGER REFERENCES teams(id)
);

CREATE TABLE matchdays (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL
);

CREATE TABLE matches (
    id SERIAL PRIMARY KEY,
    matchday_id INTEGER REFERENCES matchdays(id),
    team_a_id INTEGER REFERENCES teams(id),
    team_b_id INTEGER REFERENCES teams(id)
);

CREATE TABLE games (
    id SERIAL PRIMARY KEY,
    match_id INTEGER REFERENCES matches(id),
    game_number INTEGER CHECK (game_number BETWEEN 1 AND 3)
);

CREATE TABLE game_results (
    id SERIAL PRIMARY KEY,
    game_id INTEGER REFERENCES games(id),
    player_id INTEGER REFERENCES players(id),
    score INTEGER
);

CREATE TABLE match_points (
    id SERIAL PRIMARY KEY,
    match_id INTEGER REFERENCES matches(id),
    team_id INTEGER REFERENCES teams(id),
    individual_points INTEGER NOT NULL,
    total_points INTEGER NOT NULL
);

CREATE TABLE starting_lineups (
    id SERIAL PRIMARY KEY,
    match_id INTEGER NOT NULL REFERENCES matches(id),
    team_id INTEGER NOT NULL REFERENCES teams(id),
    player_id INTEGER NOT NULL REFERENCES players(id),
    position INTEGER NOT NULL CHECK (position BETWEEN 1 AND 3),
    UNIQUE (match_id, team_id, position),
    UNIQUE (match_id, player_id)
);

-- Datos de ejemplo
INSERT INTO teams (name) VALUES
('Los Pinos'), ('Strike Force'), ('Bowling Masters'), ('Lucky Rollers'),
('Rolling Thunder'), ('Pin Kings'), ('Split Happens'), ('Spare Warriors'),
('Alley Cats'), ('Turbo Strikers');

INSERT INTO players (name, handicap, team_id)
SELECT 'Jugador ' || g, (RANDOM() * 50)::int, t.id
FROM generate_series(1,5) g, teams t;
