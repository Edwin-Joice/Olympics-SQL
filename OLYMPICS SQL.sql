use olymics;
SELECT * from athlete_events;

## Q) List down all Olympics games held so far ##
SELECT COUNT(DISTINCT Games) AS distinct_games_count FROM athlete_events;

## Q) List down all Olympics games held so far ##
SELECT DISTINCT Games FROM athlete_events;

## Q) Mention the total no of nations who participated in each Olympics game ##
SELECT Games, COUNT(DISTINCT NOC) AS distinct_noc_count 
FROM athlete_events GROUP BY Games;

## Q) Which year saw the highest and lowest no of countries participating in Olympics? ##
SELECT Year, Games, COUNT(DISTINCT NOC) AS no_of_countries
FROM athlete_events
GROUP BY Year, Games
ORDER BY no_of_countries DESC
LIMIT 1;

SELECT Year, Games, COUNT(DISTINCT NOC) AS no_of_countries
FROM athlete_events
GROUP BY Year, Games
ORDER BY no_of_countries
LIMIT 1;

## Q) Which nation has participated in all of the Olympic games? ##
select Team, count(Games) as game_cnt
from athlete_events
group by Team
having game_cnt = ( select count(distinct Games) from athlete_events);

## Q) Identify the sport which was played in all summer Olympics ##
SELECT Sport
FROM (
    SELECT Sport, COUNT(DISTINCT Year) AS num_summer_olympics
    FROM athlete_events
    WHERE Season = 'Summer'
    GROUP BY Sport
) AS sports_participation
WHERE num_summer_olympics = (SELECT COUNT(DISTINCT Year) FROM athlete_events WHERE Season = 'Summer');

## Q) Which Sports were just played only once in the Olympics? ##
SELECT  Sport, count(distinct (Games)) as count_in_games
from athlete_events
group by  Sport
having count( distinct (Games)) = 1;

## Q) Fetch the total no of sports played in each Olympic games ##
SELECT Games, COUNT(DISTINCT Sport) AS sport_count 
FROM athlete_events 
GROUP BY Games;

## Q) Fetch details of the oldest athletes to win a gold medal ##
SELECT ID, Name, Sex, Age, Year, Medal FROM athlete_events WHERE Medal = "Gold" ORDER BY Age DESC;

SELECT ID, Name, Sex, Age, Year, Medal, DENSE_RANK() OVER (ORDER BY Age DESC) AS dense_ranks
FROM athlete_events 
WHERE Medal = 'Gold'
ORDER BY Age DESC;

## Q) Find the Ratio of male and female athletes participated in all olympic games ##
SELECT 
    (SELECT COUNT(*) FROM athlete_events WHERE Sex = 'M') AS MaleCount,
    (SELECT COUNT(*) FROM athlete_events WHERE Sex = 'F') AS FemaleCount,
    (SELECT COUNT(*) FROM athlete_events WHERE Sex = 'M') / (SELECT COUNT(*) FROM athlete_events) AS Male_Ratio,
    (SELECT COUNT(*) FROM athlete_events WHERE Sex = 'f') / (SELECT COUNT(*) FROM athlete_events) AS Female_Ratio
FROM 
    dual;

## Q) Fetch the top 5 athletes who have won the most medals (gold/silver/bronze) ##
SELECT Name,COUNT(Medal) AS Total_Medals FROM athlete_events WHERE Medal IS NOT NULL
GROUP BY Name ORDER BY Total_Medals DESC
LIMIT 5;

## Q) List down total gold, silver and bronze medals won by each country ##
SELECT NOC,
    SUM(CASE WHEN Medal = 'Gold' THEN 1 ELSE 0 END) AS Gold_Medals,
    SUM(CASE WHEN Medal = 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
    SUM(CASE WHEN Medal = 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals
FROM athlete_events
WHERE Medal IN ('Gold', 'Silver', 'Bronze')
GROUP BY NOC
ORDER BY Gold_Medals DESC;

## Q) List down total gold, silver and bronze medals won by each country corresponding to each Olympic games ##
SELECT NOC, Games,
    SUM(CASE WHEN Medal = 'Gold' THEN 1 ELSE 0 END) AS Gold_Medals,
    SUM(CASE WHEN Medal = 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
    SUM(CASE WHEN Medal = 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals
FROM athlete_events
WHERE Medal IN ('Gold', 'Silver', 'Bronze')
GROUP BY Games , NOC
ORDER BY Games;

## Q) Identify which country won the most gold, most silver and most bronze medals in each Olympic games ##
SELECT 
    Games,
    MAX(Gold_Medals) AS Most_Gold_Medals,
    MAX(CASE WHEN Gold_Rank = 1 THEN NOC_Gold END) AS Country_Max_Gold,
    MAX(Silver_Medals) AS Most_Silver_Medals,
    MAX(CASE WHEN Silver_Rank = 1 THEN NOC_Silver END) AS Country_Max_Silver,
    MAX(Bronze_Medals) AS Most_Bronze_Medals,
    MAX(CASE WHEN Bronze_Rank = 1 THEN NOC_Bronze END) AS Country_Max_Bronze
FROM (
    SELECT 
        Games,
        NOC AS NOC_Gold,
        SUM(CASE WHEN Medal = 'Gold' THEN 1 ELSE 0 END) AS Gold_Medals,
        ROW_NUMBER() OVER (PARTITION BY Games ORDER BY SUM(CASE WHEN Medal = 'Gold' THEN 1 ELSE 0 END) DESC) AS Gold_Rank,
        NOC AS NOC_Silver,
        SUM(CASE WHEN Medal = 'Silver' THEN 1 ELSE 0 END) AS Silver_Medals,
        ROW_NUMBER() OVER (PARTITION BY Games ORDER BY SUM(CASE WHEN Medal = 'Silver' THEN 1 ELSE 0 END) DESC) AS Silver_Rank,
        NOC AS NOC_Bronze,
        SUM(CASE WHEN Medal = 'Bronze' THEN 1 ELSE 0 END) AS Bronze_Medals,
        ROW_NUMBER() OVER (PARTITION BY Games ORDER BY SUM(CASE WHEN Medal = 'Bronze' THEN 1 ELSE 0 END) DESC) AS Bronze_Rank
    FROM 
        athlete_events
    WHERE 
        Medal IN ('Gold', 'Silver', 'Bronze')
    GROUP BY 
        Games, NOC
) AS Medals_Per_Game_Per_NOC
GROUP BY 
    Games;
    
## Q) Which countries have never won gold medal but have won silver or bronze medals? ##
SELECT DISTINCT NOC
FROM athlete_events
WHERE Medal IN ('Silver', 'Bronze') AND NOC NOT IN (
    SELECT DISTINCT NOC
    FROM athlete_events
    WHERE Medal = 'Gold'
);


## Q) In which Sport/event, India has won highest medals? ##
SELECT Sport,Event,COUNT(*) AS Total_Medals
FROM athlete_events
WHERE NOC = 'IND'
GROUP BY Sport, Event
ORDER BY Total_Medals DESC
LIMIT 1;

## Q) Break down all Olympic games where India won medal for Hockey and how many medals in each olympic games ##
SELECT Games, COUNT(*) AS Total_Medals
FROM athlete_events
WHERE NOC = 'IND' 
AND Sport = 'Hockey'
AND Medal IS NOT NULL
GROUP BY Games;


	




