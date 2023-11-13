-- change admin password to MD5 hash of 'oops!'
UPDATE "users"
SET
    "password" = '982c0381c279d139fd221fce974916e7'
WHERE
    "username" = 'admin';

-- delete the user_log row for this update
DELETE FROM "user_logs"
WHERE
    "type" = 'update'
    AND "new_username" = 'admin'
    AND "old_password" = (
        SELECT
            "new_password"
        FROM
            "user_logs"
        WHERE
            "type" = 'insert'
            AND "new_username" = 'admin'
    )
    AND "new_password" = (
        SELECT
            "password"
        FROM
            "users"
        WHERE
            "username" = 'admin'
    );

UPDATE "user_logs"
SET
    "new_password" = '982c0381c279d139fd221fce974916e7'
WHERE
    "type" = 'insert'
    AND "new_username" = 'admin';

-- insert a fake record if admin changing it's password
-- to the emily33's password
INSERT INTO
    "user_logs" (
        "type",
        "old_username",
        "new_username",
        "old_password",
        "new_password"
    )
VALUES
    (
        'update',
        'admin',
        'admin',
        (
            SELECT
                "new_password"
            FROM
                "user_logs"
            WHERE
                "type" = 'insert'
                AND "new_username" = 'admin'
        ),
        (
            SELECT
                "new_password"
            FROM
                "user_logs"
            WHERE
                "type" = 'insert'
                AND "new_username" = 'emily33'
        )
    );