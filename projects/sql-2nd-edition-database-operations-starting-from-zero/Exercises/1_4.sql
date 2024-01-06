CREATE TABLE IF NOT EXISTS TestDropTransaction (
    toroku_bango  INTEGER NOT NULL,
    PRIMARY KEY (toroku_bango));

\d+ TestDropTransaction;

BEGIN TRANSACTION;
    DROP TABLE TestDropTransaction;
ROLLBACK TRANSACTION;

\d+ TestDropTransaction;

