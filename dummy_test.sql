-- First way

SELECT 
    CASE 
        WHEN NOT EXISTS (SELECT 1 FROM relationships r2 WHERE r2.parent = r1.parent) THEN r1.parent
        ELSE 'L-' || r1.parent
    END AS parent_label,
    CASE 
        WHEN NOT EXISTS (SELECT 1 FROM relationships r2 WHERE r2.parent = r1.child) THEN r1.child
        ELSE 'L-' || r1.child
    END AS child_label
FROM relationships r1;


-- Second way

WITH parent_present AS (
    SELECT DISTINCT parent
    FROM relationships
)
SELECT 
    CASE 
        WHEN p1.parent IS NULL THEN r1.parent
        ELSE 'L-' || r1.parent
    END AS parent_label,
    CASE 
        WHEN p2.parent IS NULL THEN r1.child
        ELSE 'L-' || r1.child
    END AS child_label
FROM relationships r1
LEFT JOIN parent_present p1 ON r1.parent = p1.parent
LEFT JOIN parent_present p2 ON r1.child = p2.parent;

