--조건에 맞는 도서와 저자 리스트 출력하기
SELECT B.BOOK_ID , A.AUTHOR_NAME , DATE_FORMAT(B.PUBLISHED_DATE,'%Y-%m-%d') AS PUBLISHED_DATE
FROM BOOK B JOIN AUTHOR A
USING(AUTHOR_ID)
WHERE B.CATEGORY = "경제"
ORDER BY 3

--상품 별 오프라인 매출 구하기
SELECT P.PRODUCT_CODE , SUM(OS.SALES_AMOUNT*P.PRICE) AS SALES
FROM PRODUCT P JOIN OFFLINE_SALE OS
USING(PRODUCT_ID)
GROUP BY OS.PRODUCT_ID
ORDER BY 2 DESC , 1

--오랜 기간 보호한 동물(1)
WITH ANIMAL_ID AS (
    SELECT ANIMAL_ID 
    FROM ANIMAL_OUTS
)

SELECT NAME , DATETIME
FROM ANIMAL_INS
WHERE ANIMAL_ID NOT IN (SELECT * FROM ANIMAL_ID)
ORDER BY DATETIME 
LIMIT 3

--없어진 기록 찾기
SELECT AO.ANIMAL_ID , AO.NAME
FROM ANIMAL_OUTS AO LEFT JOIN ANIMAL_INS AI
ON AO.ANIMAL_ID = AI.ANIMAL_ID
WHERE AI.ANIMAL_ID IS NULL

--있었는데요 없었습니다.
SELECT AI.ANIMAL_ID , AI.NAME
FROM ANIMAL_INS AI JOIN ANIMAL_OUTS AO
USING(ANIMAL_ID)
WHERE AI.DATETIME > AO.DATETIME
ORDER BY AI.DATETIME

--특정 기간동안 대영 가능한 자동차들의 대여비용 구하기
WITH CAR_RENTAL AS(
    SELECT 
    *   
    FROM CAR_RENTAL_COMPANY_CAR
    WHERE CAR_TYPE IN ("SUV","세단")
    AND CAR_ID NOT IN(
        SELECT 
        DISTINCT CAR_ID
        FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
        WHERE START_DATE <= '2022-11-30' AND END_DATE >='2022-11-01'
    )
)

SELECT 
CR.CAR_ID , CR.CAR_TYPE , FLOOR((daily_fee*30)*(100-discount_rate)/100) as FEE
FROM CAR_RENTAL CR JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN CRCDP
ON CR.CAR_TYPE = CRCDP.CAR_TYPE
WHERE CRCDP.DURATION_TYPE ='30일 이상'
AND FLOOR((daily_fee*30)*(100-discount_rate)/100) >=500000
AND FLOOR((daily_fee*30)*(100-discount_rate)/100) <2000000
ORDER BY 3 DESC , 2, 1 DESC

--5월 식품들의 총매출 조회하기
SELECT
FO.PRODUCT_ID , FP.PRODUCT_NAME ,SUM(AMOUNT)*FP.PRICE AS TOTAL_SALES
FROM FOOD_ORDER FO JOIN FOOD_PRODUCT FP
USING(PRODUCT_ID)
WHERE FO.PRODUCE_DATE LIKE '2022-05%'
GROUP BY FO.PRODUCT_ID 
ORDER BY 3 DESC , 1

--주문량이 많은 아이스크림들 조회하기
WITH UNION_SALES AS (
    SELECT * FROM FIRST_HALF
    UNION 
    SELECT * FROM JULY
),LIST AS (
SELECT
FLAVOR , SUM(TOTAL_ORDER)
FROM UNION_SALES
GROUP BY FLAVOR 
ORDER BY 2 DESC
)

SELECT FLAVOR FROM LIST
LIMIT 3

-- 그룹별 조건에 맞는 식당 목록 출력하기
WITH REVIEW_KING AS(
    SELECT
    MEMBER_ID , COUNT(*)
    FROM REST_REVIEW
    GROUP BY MEMBER_ID 
    ORDER BY 2 DESC 
    LIMIT 1 
)

SELECT MEMBER_NAME , REVIEW_TEXT , DATE_FORMAT(REVIEW_DATE,'%Y-%m-%d')
FROM MEMBER_PROFILE JOIN REST_REVIEW 
USING(MEMBER_ID)
WHERE REST_REVIEW.MEMBER_ID = (SELECT MEMBER_ID FROM REVIEW_KING)
ORDER BY 3 , 2

--보호소에서 중성화한 동물
SELECT ANIMAL_ID , ANIMAL_TYPE , NAME
FROM ANIMAL_OUTS
WHERE ANIMAL_ID IN (
    SELECT
    ANIMAL_ID
    FROM ANIMAL_INS
    WHERE SEX_UPON_INTAKE LIKE 'Intact%'
)
AND SEX_UPON_OUTCOME NOT LIKE 'Intact%'
ORDER BY 1

-- FrontEnd 개발자 찾기
WITH FRONT_END_SKILL AS(
SELECT 
SUM(CODE)
FROM SKILLCODES
WHERE CATEGORY = 'Front End'
)


SELECT 
ID , EMAIL , FIRST_NAME , LAST_NAME 
FROM DEVELOPERS
WHERE SKILL_CODE & (SELECT * FROM FRONT_END_SKILL)
ORDER BY 1

-- 상품을 구매한 회원 비율 구하기
WITH USER_CNT AS(
    SELECT
    COUNT(*) AS USER_CNT
    FROM USER_INFO
    WHERE YEAR(JOINED) = 2021
    ) , 
USER_LIST AS(
    SELECT
    USER_ID 
    FROM USER_INFO
    WHERE YEAR(JOINED) = 2021
    )

SELECT
DATE_FORMAT(SALES_DATE,'%Y') AS 'YEAR' , 
DATE_FORMAT(SALES_DATE,'%m') AS 'MONTH', 
COUNT(DISTINCT USER_ID) AS PURCHASED_USERS,
ROUND((COUNT(DISTINCT USER_ID)/(SELECT * FROM USER_CNT)),1) AS PUCHASED_RATIO
FROM ONLINE_SALE
WHERE USER_ID IN (SELECT * FROM USER_LIST)
GROUP BY 1 , 2
ORDER BY 1 , 2