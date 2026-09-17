#!/bin/bash

set -e

cat <<'SQL'
INSERT INTO hotel_bookings
SELECT
    gen_random_uuid(),
    (
        ARRAY[
            '11111111-1111-1111-1111-111111111111',
            '22222222-2222-2222-2222-222222222222',
            '33333333-3333-3333-3333-333333333333'
        ]
    )[1 + floor(random() * 3)::int],
    'hotel-' || (1 + floor(random() * 10)::int),
    (
        ARRAY[
            'delhi',
            'mumbai',
            'bangalore',
            'hyderabad',
            'pune'
        ]
    )[1 + floor(random() * 5)::int],
    CURRENT_DATE + floor(random() * 10)::int,
    CURRENT_DATE + floor(random() * 15)::int + 1,
    round((500 + random() * 9500)::numeric, 2),
    (
        ARRAY[
            'confirmed',
            'cancelled',
            'pending',
            'completed'
        ]
    )[1 + floor(random() * 4)::int],
    NOW() - (random() * INTERVAL '60 days')
FROM generate_series(1, 150);
SQL
