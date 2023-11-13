
-- *** The Lost Letter ***

-- We have to look for action status of the scan record by
-- searching for the package with specific from_address, to_address and contents
-- which equal to Congratulatory letter or something like that

-- First we have to find the type of address that the package end up

SELECT type FROM addresses WHERE address = '2 Finnigan Street';

-- Second we have to find out if there is an scan of the action drop type for
-- the sender address

SELECT address FROM scans
JOIN addresses ON
addresses.id = address_id
WHERE package_id = (
    SELECT id FROM packages WHERE from_address_id = (
        SELECT id from addresses WHERE address = '900 Somerville Avenue'
    )
    AND
    contents LIKE '%Congratulatory%'
)
AND
action = 'Drop';



-- *** The Devious Delivery ***

-- First we have to find the package that contains words duck and
-- does not have a address and get the address that :

SELECT * FROM addresses WHERE id = (
    SELECT address_id FROM scans WHERE package_id = (
        SELECT id FROM packages WHERE from_address_id IS NULL
    ) AND
    action = 'Drop'
);

-- Then I have to get the contents of the package by it's specifications:

SELECT contents FROM packages WHERE contents LIKE '%duck%'
AND from_address_id IS NULL;



-- *** The Forgotten Gift ***

-- First we have to find the contents of the mentioned package
-- by the from and to addresses

SELECT contents from packages WHERE from_address_id = (
    SELECT id from addresses where address = '109 Tileston Street'
)
AND to_address_id = (
    SELECT id from addresses WHERE address = '728 Maple Place'
);

-- Then I have to check to see whether the package is still in the driver
-- that has picked up the package or the package that is dropped

SELECT name from drivers where id IN (
    SELECT driver_id from scans WHERE package_id = (
        SELECT id FROM packages WHERE from_address_id = (
            SELECT id FROM addresses WHERE address = '109 Tileston Street'
        )
    ) AND timestamp = (
        SELECT MAX(timestamp) FROM scans WHERE package_id = (
            SELECT id FROM packages WHERE from_address_id = (
                SELECT id FROM addresses WHERE address = '109 Tileston Street'
            )
        )
    )
);