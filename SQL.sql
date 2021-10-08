WITH sum_sentiment AS 
	(SELECT country_code, SUM(sentiment) AS sent FROM twits GROUP BY country_code)
SELECT country_code, sent FROM sum_sentiment 
	WHERE sent = (SELECT MAX(sent) FROM sum_sentiment
					WHERE country_code IS NOT NULL);
					
WITH sum_sentiment AS 
	(SELECT country_code, SUM(sentiment) AS sent FROM twits GROUP BY country_code)
SELECT country_code, sent FROM sum_sentiment 
	WHERE sent = (SELECT MIN(sent) FROM sum_sentiment
					WHERE country_code IS NOT NULL);

WITH sum_sentiment AS 
	(SELECT *, SUM(sentiment) AS sent FROM twits GROUP BY name)
SELECT * FROM sum_sentiment 
	WHERE sent = (SELECT MIN(sent) FROM sum_sentiment);

WITH sum_sentiment AS 
	(SELECT *, SUM(sentiment) AS sent FROM twits GROUP BY name)
SELECT * FROM sum_sentiment 
	WHERE sent = (SELECT MAX(sent) FROM sum_sentiment);

					
WITH sum_sentiment AS 
	(SELECT *, SUM(sentiment) AS sent FROM twits 
	WHERE location != ''
	GROUP BY location)
SELECT * FROM sum_sentiment 
	WHERE sent = (SELECT MAX(sent) FROM sum_sentiment);
	
WITH sum_sentiment AS 
	(SELECT *, SUM(sentiment) AS sent FROM twits 
	WHERE location != ''
	GROUP BY location)
SELECT * FROM sum_sentiment 
	WHERE sent = (SELECT MIN(sent) FROM sum_sentiment);
 
