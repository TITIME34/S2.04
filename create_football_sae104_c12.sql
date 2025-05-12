/*
DROP CONSTRAINT team_fk_club;
DROP CONSTRAINT day_fk_season;
DROP CONSTRAINT takes_part_fk_team;
DROP CONSTRAINT takes_part_fk_season;
DROP CONSTRAINT takes_part_fk_league;
DROP CONSTRAINT characteristics_fk_league;
DROP CONSTRAINT characteristics_fk_season;
DROP CONSTRAINT plays_fk_day;
DROP CONSTRAINT plays_fk_player;
DROP CONSTRAINT start_fk_team;
DROP CONSTRAINT start_fk_date;
DROP CONSTRAINT start_fk_player;
DROP CONSTRAINT end_fk_team;
DROP CONSTRAINT end_fk_date;
DROP CONSTRAINT end_fk_player;
DROP CONSTRAINT match_fk_local;
DROP CONSTRAINT match_fk_visitor;
DROP CONSTRAINT match_fk_day;
DROP VAR club;
DROP VAR team;
DROP VAR league;
DROP VAR season;
DROP VAR day;
DROP VAR date;
DROP VAR player;
DROP VAR takes_part;
DROP VAR characteristics;
DROP VAR plays;
DROP VAR start;
DROP VAR ends;
DROP VAR match;
*/


VAR club BASE RELATION{
    club_id int,
    club_name char,
    club_acronym char
}KEY{club_id};

VAR team BASE RELATION{
    team_id int,
    team_name char,
    coach_name_firstname char,

    club_id int
}KEY{team_id};

VAR league BASE RELATION{
    league_id int,
    league_name char
}KEY{league_id};

VAR season BASE RELATION{
    season_id char
}KEY{season_id};

VAR day BASE RELATION{
    season_id char,
    day_nr int
}KEY{season_id,day_nr};

VAR date BASE RELATION{
    date int
}KEY{date};

VAR player BASE RELATION{
    player_id int,
    player_name char,
    player_firstname char,
    date_of_birth int,
    nationality char,
    birth_country char,
    weight rational,
    size rational
}KEY{player_id};


CONSTRAINT team_fk_club
team{club_id}<=club{club_id};

CONSTRAINT day_fk_season
day{season_id}<=season{season_id};

VAR takes_part BASE RELATION{
    team_id int,
    season_id char,
    league_id int
}KEY{team_id,season_id,league_id};

CONSTRAINT takes_part_fk_team
takes_part{team_id}<=team{team_id};
CONSTRAINT takes_part_fk_season
takes_part{season_id}<=season{season_id};
CONSTRAINT takes_part_fk_league
takes_part{league_id}<=league{league_id};

VAR characteristics BASE RELATION{
    league_id int,
    season_id char,
    number_of_teams int
}KEY{league_id,season_id};

CONSTRAINT characteristics_fk_league
characteristics{league_id}<=league{league_id};
CONSTRAINT characteristics_fk_season
characteristics{season_id}<=season{season_id};

VAR plays BASE RELATION{
    season_id char,
    day_nr int,
    player_id int,
    position char,
    starting_time int,
    yellow_cards int,
    red_card boolean,
    shirt_nr int
}KEY{season_id,day_nr,player_id};

CONSTRAINT plays_fk_day
plays{season_id,day_nr}<=day{season_id,day_nr};
CONSTRAINT plays_fk_player
plays{player_id}<=player{player_id};

VAR start BASE RELATION{
    team_id int,
    date int,
    player_id int
}KEY{team_id,date,player_id};

CONSTRAINT start_fk_team
start{team_id}<=team{team_id};
CONSTRAINT start_fk_date
start{date}<=date{date};
CONSTRAINT start_fk_player
start{player_id}<=player{player_id};

VAR ends BASE RELATION{
    team_id int,
    date int,
    player_id int
}KEY{team_id,date,player_id};

CONSTRAINT end_fk_team
ends{team_id}<=team{team_id};
CONSTRAINT end_fk_date
ends{date}<=date{date};
CONSTRAINT end_fk_player
ends{player_id}<=player{player_id};

VAR match BASE RELATION{
    local int,
    visitor int,
    season_id char,
    day_nr int,
    attendance int,
    local_goals int,
    visitors_goal int,
    match_date_time int
}KEY{local,visitor,season_id,day_nr};

CONSTRAINT match_fk_local
match{local} RENAME {local AS team_id}<=team{team_id};
CONSTRAINT match_fk_visitor
match{visitor} RENAME {visitor AS team_id}<=team{team_id};
CONSTRAINT match_fk_day
match{season_id,day_nr}<=day{season_id,day_nr};