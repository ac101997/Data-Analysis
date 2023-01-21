CREATE database playstoredb;

CREATE TABLE `playstoredb`.`App_Data` (`Index` int NULL,
    `App` VARCHAR(225) NULL,
    `Category` VARCHAR(225) NULL,
    `Rating` FLOAT NULL,
    `Reviews` FLOAT NULL,
    `Size` VARCHAR(225) NULL,
    `Installs` FLOAT NULL,
    `Type` VARCHAR(225) NULL,
    `Price` FLOAT NULL,
    `Content_Rating` VARCHAR(225) NULL,
    `Genres` VARCHAR(225) NULL,
    `Last_Updated` DATETIME NULL,
    `Current_Ver` VARCHAR(225) NULL,
    `Android_Ver` VARCHAR(225) NULL
);

SHOW VARIABLES LIKE "secure_file_priv";

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Playstore App Dataset.csv'
INTO TABLE app_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select count(*) from app_data

CREATE TABLE `playstoredb`.`App_Reviews` (
	 `Index` INT NULL,
    `App` VARCHAR(225) NULL,
    `Translated_Review` VARCHAR(3000) NULL,
    `Sentiment` VARCHAR(3000) NULL,
    `Sentiment_Polarity` FLOAT NULL,
    `Sentiment_Subjectivity` FLOAT NULL
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Playstore Reviews.csv' 
INTO TABLE app_reviews
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM app_reviews;

SELECT * FROM app_data



##1. Which apps have the highest rating in the given available dataset?

SELECT App,Rating FROM app_data
ORDER BY Rating DESC, App ASC


##2. What are the number of installs and reviews for the above apps? Return the apps with the highest reviews to the top.


SELECT App, Installs, Rating, Reviews 
FROM app_data
ORDER BY Reviews DESC

##3. Which app has the highest number of reviews? Also, mention the number of reviews and category of the app

SELECT App, Reviews, Category
FROM app_data
ORDER BY Reviews DESC, Category
LIMIT 1

##4 What is the total amount of revenue generated by the google play store by hosting apps?

SELECT SUM(Price) AS Revenue
FROM app_data

##5. Which Category of google play store apps has the highest number of installs? also, find out the total number of installs for that particular category.

SELECT Category, Installs
FROM app_data
GROUP BY Category, Installs
ORDER BY Installs DESC

##6. Which Genre has the most number of published apps?

SELECT Genres, COUNT(App)
FROM app_data
GROUP BY Genres
ORDER BY COUNT(App) DESC

##7. Provide the list of all games ordered in such a way that the game that has the highest number of installs is displayed on the top
#(to avoid duplicate results use distinct)

SELECT DISTINCT App, Installs
FROM app_data
WHERE Category = "Game"
ORDER BY Installs DESC

##8. Provide the list of apps that can work on android version 4.0.3 and UP.

SELECT App, Android_Ver
FROM app_data
WHERE Android_Ver Like '%4.0.3%'


##9. How many apps from the given data set are free? Also, provide the number of paid apps.


SELECT DISTINCT Count(App) AS FREE
FROM app_data
WHERE Type="Free";
SELECT DISTINCT Count(App) AS Paid
from app_data
WHERE Type="Paid";

#SELECT * FROM app_data

##10. Which is the best dating app? (Best dating app is the one having the highest number of Reviews)

SELECT App, Category, Reviews
FROM app_data
WHERE Category="Dating"
ORDER BY Reviews DESC
LIMIT 1

##11. Get the number of reviews having positive sentiment and the number of reviews having negative sentiment for the app 10 best foods for you and compare them.

SELECT * FROM app_reviews

SELECT COUNT(Sentiment="Positive") AS Positive_sentiment_Count, 
COUNT(Sentiment="Negative") AS Negative_sentiment_Count
FROM app_reviews
WHERE App LIKE '10 best foods for you'


##12. Which comments of ASUS SuperNote have sentiment polarity and sentiment subjectivity both as 1?

#SELECT * FROM app_reviews

SELECT Translated_Review, App, Sentiment_Polarity, Sentiment_Subjectivity
FROM app_reviews 
WHERE App="ASUS SuperNote" AND Sentiment_Polarity=1 AND Sentiment_Subjectivity=1


##13. Get all the neutral sentiment reviews for the app Abs Training-Burn belly fat

SELECT App, Translated_Review, Sentiment
FROM app_reviews
WHERE App LIKE "Abs Training-Burn belly fat" AND Sentiment="Neutral"


## 14. Extract all negative sentiment reviews for Adobe Acrobat Reader with their sentiment polarity and sentiment subjectivity.


SELECT App, Translated_Review, Sentiment_Polarity, Sentiment_Subjectivity
FROM app_reviews
WHERE App="Adobe Acrobat Reader" AND Sentiment="Negative"