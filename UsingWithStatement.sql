-- although this didnt work, as I think the statement returns multiple nested
WITH update_secrets AS (SELECT *
                        FROM client_secret_rotation
                        WHERE client_id = 'someid'
                          AND expired_at IS NOT NULL)
WITH updated AS (UPDATE client_secret_rotation SET expired_at = NOW() WHERE
            client_id = update_secrets.client_id AND client_secret = update_secrets.client_secret)
INSERT INTO client_secret_rotation (client_id, client_secret)
VALUES ((SELECT DISTINCT client_id FROM update_secrets), md5(random()::text));
