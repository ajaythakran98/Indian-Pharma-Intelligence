SELECT * FROM MSQ;
SELECT 
  category,
  total_sales,
  ROUND(total_sales / grand_total * 100, 2) AS market_share_percent
FROM (
  SELECT 'M01AB' AS category, SUM(M01AB) AS total_sales FROM msq
  UNION ALL
  SELECT 'M01AE', SUM(M01AE) FROM msq
  UNION ALL
  SELECT 'N02BA', SUM(N02BA) FROM msq
  UNION ALL
  SELECT 'N02BE', SUM(N02BE) FROM msq
  UNION ALL
  SELECT 'N05B', SUM(N05B) FROM msq
  UNION ALL
  SELECT 'N05C', SUM(N05C) FROM msq
  UNION ALL
  SELECT 'R03', SUM(R03) FROM msq
  UNION ALL
  SELECT 'R06', SUM(R06) FROM msq
) AS totals
JOIN (
  SELECT 
    SUM(M01AB + M01AE + N02BA + N02BE + N05B + N05C + R03 + R06) AS grand_total
  FROM msq
) AS grand
ORDER BY market_share_percent DESC;


SELECT 
  ROUND(SUM(market_share_percent), 2) AS top_2_total_percentage
FROM (
  SELECT 
    category,
    total_sales,
    ROUND(total_sales / grand_total * 100, 2) AS market_share_percent
  FROM (
    SELECT 'M01AB' AS category, SUM(M01AB) AS total_sales FROM msq
    UNION ALL
    SELECT 'M01AE', SUM(M01AE) FROM msq
    UNION ALL
    SELECT 'N02BA', SUM(N02BA) FROM msq
    UNION ALL
    SELECT 'N02BE', SUM(N02BE) FROM msq
    UNION ALL
    SELECT 'N05B', SUM(N05B) FROM msq
    UNION ALL
    SELECT 'N05C', SUM(N05C) FROM msq
    UNION ALL
    SELECT 'R03', SUM(R03) FROM msq
    UNION ALL
    SELECT 'R06', SUM(R06) FROM msq
  ) AS totals
  JOIN (
    SELECT 
      SUM(M01AB + M01AE + N02BA + N02BE + N05B + N05C + R03 + R06) AS grand_total
    FROM msq
  ) AS grand
  ORDER BY market_share_percent DESC
  LIMIT 2
) AS top_2;

-- Summary:
-- After analyzing monthly drug sales from 2014 to 2019 using the 'Monthlysales' dataset,
-- N02BE (Paracetamol) and N05B (Anxiolytics) were identified as the top two selling drug classes,
-- Together, they contributed the largest share of total market volume during this period which is 63.85%,
-- The analysis also included calculating each drug class's overall market share, giving a clearer view of their dominance in the Indian pharmaceutical landscape.

