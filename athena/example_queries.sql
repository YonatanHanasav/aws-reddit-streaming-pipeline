-- Example Athena SQL queries for Reddit data analysis
-- Replace 'your_database' and 'your_table' with your actual database and table names

-- Query 1: Get top posts by score for a specific date
SELECT 
    title,
    author,
    score,
    num_comments,
    created_utc,
    subreddit
FROM your_database.your_table
WHERE DATE(from_unixtime(created_utc)) = '2024-01-01'
ORDER BY score DESC
LIMIT 10;

-- Query 2: Get posts by subreddit with average scores
SELECT 
    subreddit,
    COUNT(*) as post_count,
    AVG(score) as avg_score,
    AVG(num_comments) as avg_comments
FROM your_database.your_table
GROUP BY subreddit
ORDER BY avg_score DESC;

-- Query 3: Get hourly post trends
SELECT 
    DATE(from_unixtime(created_utc)) as post_date,
    HOUR(from_unixtime(created_utc)) as post_hour,
    COUNT(*) as posts_count,
    AVG(score) as avg_score
FROM your_database.your_table
GROUP BY DATE(from_unixtime(created_utc)), HOUR(from_unixtime(created_utc))
ORDER BY post_date DESC, post_hour;

-- Query 4: Get top authors by total score
SELECT 
    author,
    COUNT(*) as posts_count,
    SUM(score) as total_score,
    AVG(score) as avg_score
FROM your_database.your_table
WHERE author != '[deleted]'
GROUP BY author
ORDER BY total_score DESC
LIMIT 20; 