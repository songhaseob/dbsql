도시발전지수 : (버거킹 + 맥도날드 + kfc ) / 롯데리아
SELECT sido, sigungu, gb, COUNT(*)
FROM fastfood
WHERE gb = '롯데리아'
    AND sido = '강원도'
    AND sigungu = '강릉시'
GROUP BY sido, sigungu, gb
ORDER BY sido, sigungu, gb;

SELECT sido, sigungu, gb, COUNT(*)
FROM fastfood
WHERE gb = '맥도날드'
    AND sido = '강원도'
    AND sigungu = '강릉시'
GROUP BY sido, sigungu, gb
ORDER BY sido, sigungu, gb;



