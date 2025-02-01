CREATE TABLE TransactionRecord (
    s_no INT,
    timestamp DATETIME PRIMARY KEY,
    transaction_id VARCHAR(50) UNIQUE,
    status VARCHAR(10) CHECK (status IN ('success', 'failure')),
    admin VARCHAR(100)
);
