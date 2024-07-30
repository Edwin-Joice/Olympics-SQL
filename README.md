# Olympics Data Analysis Project

This project involves analyzing a dataset containing information about the Olympic Games, including details about athletes, events, medals won, and other relevant data. The analysis is performed using SQL queries on a database named "olymics".

## Project Description

The primary objective of this project is to explore and gain insights from the Olympics dataset by answering various questions through SQL queries. The queries cover a wide range of tasks, such as retrieving distinct games, counting the number of participating nations, identifying sports played across different Olympics, analyzing medal distribution among countries, and more.

## Dataset

The dataset used in this project is stored in a MySQL database named "olympics". The main table used for analysis is "athlete_events", which contains information about athletes, the events they participated in, their countries (represented by NOC codes), medals won, and other relevant details.

## Advanced SQL Functions Used

This project showcases the use of several advanced SQL functions and techniques, including:

1. **Window Functions**: The `DENSE_RANK()` and `ROW_NUMBER()` window functions are used to rank athletes based on their age and medal counts, respectively.

2. **Subqueries**: Correlated subqueries are employed to filter results based on conditions involving aggregated values from the same table.

3. **Aggregation Functions**: Functions like `COUNT`, `SUM`, and `MAX` are used extensively to perform various calculations and aggregations on the data.

4. **Case Statements**: `CASE` statements are utilized to conditionally count or aggregate data based on specific criteria, such as medal types.

5. **Joins and Subqueries**: While not explicitly shown in the provided code, the project may involve joining multiple tables or using subqueries to combine data from different sources.

6. **Group By and Having Clauses**: The `GROUP BY` clause is used to group data based on specific columns, while the `HAVING` clause filters the grouped results based on certain conditions.

7. **Order By and Limit Clauses**: The `ORDER BY` clause is used to sort the results based on specified columns, and the `LIMIT` clause is employed to retrieve a specified number of top or bottom rows.

8. **Distinct and Concatenation**: The `DISTINCT` keyword is used to retrieve unique values, and string concatenation is performed to combine column values for specific queries.

## Usage

To use this project, follow these steps:

1. Set up a MySQL database and import the "olymics" dataset.
2. Open the `OLYMPICS SQL.sql` file in a MySQL client or IDE.
3. Execute the SQL queries one by one to retrieve the desired results.

Each query is accompanied by a comment explaining the question it aims to answer or the task it performs. You can modify or extend these queries based on your specific requirements or explore the dataset further by writing additional queries.

## Contributing

Contributions to this project are welcome. If you find any issues or have suggestions for improvements, please open an issue or submit a pull request on the project's repository.
