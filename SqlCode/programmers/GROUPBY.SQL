--동명 동물 수 찾기
SELECT name,COUNT(*)AS COUNT 
FROM animal_ins
WHERE NAME IS NOT NULL
GROUP BY name
HAVING COUNT(*) >=2
ORDER BY 1

--진료과별 총 예약 횟수 출력하기
SELECT MCDP_CD AS '진료과코드' , COUNT(*) AS '5월예약건수'
FROM APPOINTMENT 
WHERE APNT_YMD LIKE '2022-05%'
GROUP BY MCDP_CD
ORDER BY 2,1

--고양이와 개는 몇마리 있을까?
SELECT animal_type,COUNT(animal_id) 
FROM animal_ins 
GROUP BY animal_type

--입양 시각 구하기
SELECT HOUR , COUNT(*) 
FROM (
    SELECT TO_NUMBER(TO_CHAR(DATETIME,'HH24')) HOUR 
    FROM ANIMAL_OUTS 
    WHERE TO_CHAR(DATETIME,'HH24') BETWEEN '09'AND '19') 
GROUP BY HOUR 
ORDER BY HOUR

--자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기
SELECT CAR_TYPE , COUNT(*) AS CARS
FROM CAR_RENTAL_COMPANY_CAR 
WHERE OPTIONS REGEXP '통풍시트|열선시트|가죽시트'
GROUP BY CAR_TYPE
ORDER BY 1

--성분으로 구분한 아이스크림 총 주문량
SELECT INGREDIENT_TYPE, SUM(TOTAL_ORDER) AS TOTAL_ORDER
FROM FIRST_HALF FH JOIN ICECREAM_INFO II
USING(FLAVOR)
GROUP BY INGREDIENT_TYPE
ORDER BY 2

--카테고리 별 도서 판매량 집계하기
SELECT CATEGORY,SUM(SALES) AS TOTAL_SALES
FROM BOOK_SALES BS JOIN BOOK B
USING(BOOK_ID)
WHERE BS.SALES_DATE LIKE '2022-01%'
GROUP BY CATEGORY
ORDER BY 1 

--조건에 맞는 사용자와 총 거래금액 조회하기
SELECT UGB.WRITER_ID, UGU.NICKNAME , SUM(UGB.PRICE) AS TOTAL_SALES
FROM USED_GOODS_BOARD UGB JOIN USED_GOODS_USER UGU
ON UGB.WRITER_ID = UGU.USER_ID
WHERE UGB.STATUS = 'DONE'
GROUP BY UGB.WRITER_ID
HAVING SUM(UGB.PRICE) >= 700000
ORDER BY 3

--식품분류별 가장 비싼 식품의 정보 조회하기
WITH RANKING_PRICE AS(
    SELECT 
    *,
    RANK() OVER(PARTITION BY CATEGORY ORDER BY PRICE DESC )AS RANKING_PRICE
    FROM FOOD_PRODUCT 
    WHERE CATEGORY IN ('과자', '국', '김치', '식용유')
)

SELECT CATEGORY,PRICE AS MAX_PRICE,	PRODUCT_NAME
FROM RANKING_PRICE
WHERE RANKING_PRICE = 1
ORDER BY 2 DESC 

--즐겨찾기가 가장 많은 식당 정보 출력하기
WITH TOP_SUBSCRIBE AS(
    SELECT *,RANK() OVER(PARTITION BY FOOD_TYPE ORDER BY FAVORITES DESC) RANKING_FAVOR
    FROM REST_INFO 
)

SELECT FOOD_TYPE, REST_ID,REST_NAME,FAVORITES
FROM TOP_SUBSCRIBE
WHERE RANKING_FAVOR = 1
ORDER BY 1 DESC 

--가격대 별 상품 개수 구하기
WITH PRODUCT_PROCESS AS(
    SELECT 
    *,
    FLOOR(PRICE/10000) * 10000 AS PRICE_GROUP
    FROM PRODUCT 
)

SELECT PRICE_GROUP,COUNT(*) AS PRODUCTS
FROM PRODUCT_PROCESS
GROUP BY PRICE_GROUP
ORDER BY 1

--물고기 종류 별 잡은 수 구하기
SELECT COUNT(*) AS FISH_COUNT , FNI.FISH_NAME
FROM FISH_INFO FI JOIN FISH_NAME_INFO FNI
USING(FISH_TYPE)
GROUP BY FNI.FISH_NAME
ORDER BY 1 DESC

--부서별 평균 연봉 조회하기
SELECT HE.DEPT_ID , HD.DEPT_NAME_EN,ROUND(AVG(SAL)) AS AVG_SAL
FROM HR_DEPARTMENT HD JOIN HR_EMPLOYEES HE
USING(DEPT_ID)
GROUP BY HE.DEPT_ID
ORDER BY 3 DESC

--월별 잡은 물고기 수 구하기
SELECT COUNT(*) AS FISH_COUNT , MONTH(TIME) AS MONTH
FROM FISH_INFO 
GROUP BY MONTH(TIME)
ORDER BY 2

--조건에 맞는 사원 정보 조회하기
SELECT TC.SCORE , TC.EMP_NO , HE.EMP_NAME,HE.POSITION,HE.EMAIL
FROM TOP_SCORE TC JOIN HR_EMPLOYEES HE
USING(EMP_NO)

--자동차 대여 기록에서 대여중 / 대여 가능 여부 구분하기
WITH CAR_LIST AS(
    SELECT DISTINCT CAR_ID , 
    CASE
        WHEN '2022-10-16' BETWEEN START_DATE AND END_DATE THEN '대여중'
    ELSE '대여 가능'
    END AS AVAILABILITY
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY 

)

SELECT CAR_ID , IF(COUNT(*)=2,'대여중',AVAILABILITY) AS AVAILABILITY
FROM CAR_LIST
GROUP BY CAR_ID 
ORDER BY 1 DESC

--년, 월, 성별 별 상품 구매 회원 수 구하기
WITH BUY_LIST AS(
    SELECT USER_ID,YEAR(SALES_DATE) AS YEAR , MONTH(SALES_DATE) AS MONTH
    FROM ONLINE_SALE 
    GROUP BY USER_ID ,YEAR(SALES_DATE) , MONTH(SALES_DATE)
)

SELECT YEAR,MONTH,GENDER ,COUNT(*) AS USERS
FROM BUY_LIST BL JOIN USER_INFO UI
USING(USER_ID)
WHERE UI.GENDER IS NOT NULL
GROUP BY YEAR,MONTH,GENDER
ORDER BY 1,2,3

--저자 별 카테고리 별 매출액 집계하기
SELECT AUTHOR_ID , AUTHOR_NAME ,CATEGORY ,SUM(SALES*PRICE) AS TOTAL_SALES
FROM BOOK_SALES BS JOIN BOOK B
USING(BOOK_ID)
JOIN AUTHOR A
USING(AUTHOR_ID)
WHERE SALES_DATE LIKE '2022-01%'
GROUP BY CATEGORY ,AUTHOR_ID
ORDER BY 1 , 3 DESC

--대여 횟수가 많은 자동차들의 월별 대여 횟수 구하기
WITH MANY_RENT AS(
    SELECT CAR_ID
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
    WHERE START_DATE BETWEEN '2022-08-01' AND '2022-10-31'
    GROUP BY CAR_ID
    HAVING COUNT(*) >=5
)
SELECT  MONTH(START_DATE)AS MONTH,CAR_ID , COUNT(*) AS RECORDS
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
WHERE CAR_ID IN (SELECT * FROM MANY_RENT)
AND START_DATE BETWEEN '2022-08-01' AND '2022-10-31'
GROUP BY CAR_ID , MONTH(START_DATE)
ORDER BY 1 , 2 DESC

--연간 평가점수에 해당하는 평가 등급 및 성과금 조회하기
WITH EMP_GRADE AS(
    SELECT EMP_NO , 
        CASE 
        WHEN AVG(SCORE) >=96 THEN 'S20'
        WHEN AVG(SCORE) >=90 THEN 'A15'
        WHEN AVG(SCORE) >=80 THEN 'B10'
        ELSE 'C0'
        END AS GRADE
    FROM HR_GRADE
    GROUP BY EMP_NO
)

SELECT 
HE.EMP_NO,
HE.EMP_NAME,
LEFT(EG.GRADE,1)AS GRADE,
(SUBSTRING(GRADE,2)*SAL/100) AS BONUS
FROM HR_EMPLOYEES HE JOIN EMP_GRADE EG
USING(EMP_NO)
ORDER BY 1

--특정 조건을 만족하는 물고기별 수와 최대 길이 구하기
SELECT COUNT(*) AS FISH_COUNT , MAX(LENGTH) AS MAX_LENGTH ,FISH_TYPE 
FROM FISH_INFO 
GROUP BY FISH_TYPE
HAVING AVG(IFNULL(LENGTH,10)) >=33
ORDER BY 3

--노선별 평균 역 사이 거리 조회하기
SELECT 
ROUTE , 
CONCAT(ROUND(SUM(D_BETWEEN_DIST),1),'km') AS TOTAL_DISTANCE,
CONCAT(ROUND(AVG(D_BETWEEN_DIST),2),'km') AS AVERAGE_DISTANCE
FROM SUBWAY_DISTANCE 
GROUP BY ROUTE
ORDER BY ROUND(SUM(D_BETWEEN_DIST), 1) DESC

--입양 시각 구하기(2)
SELECT B.HOUR,NVL(A.COUNT,'0') AS COUNT 
FROM
(SELECT TO_NUMBER(TO_CHAR(DATETIME,'HH24')) HOUR,
COUNT(*)AS COUNT FROM ANIMAL_OUTS GROUP BY TO_CHAR(DATETIME,'HH24'))A,
(SELECT TO_NUMBER((LEVEL-1))HOUR , 0 COUNT FROM DUAL CONNECT BY LEVEL<=24)B
WHERE A.HOUR(+) = B.HOUR
ORDER BY B.HOUR

--언어별 개발자 분류하기
-- A : Front End 스킬과 Python 스킬을 함께 가지고 있는 개발자
-- B : C# 스킬을 가진 개발자
-- C : 그 외의 Front End 개발자
WITH FRONT_END_CODE AS(
    SELECT 
    SUM(CODE)
    FROM SKILLCODES
    WHERE CATEGORY = 'Front End'
),
PYTHON_CODE AS(
    SELECT 
    CODE
    FROM SKILLCODES
    WHERE NAME ='Python'
), 
CNS_CODE AS(
    SELECT 
    CODE
    FROM SKILLCODES
    WHERE NAME = 'C#'
)

SELECT 
CASE
    WHEN SKILL_CODE & (SELECT * FROM FRONT_END_CODE) AND SKILL_CODE & (SELECT * FROM PYTHON_CODE) THEN 'A'
    WHEN SKILL_CODE & (SELECT * FROM CNS_CODE) THEN 'B'
    ELSE 'C'
    END AS GRADE,
ID ,
EMAIL
FROM DEVELOPERS 
WHERE SKILL_CODE & (SELECT * FROM FRONT_END_CODE)
OR SKILL_CODE & (SELECT * FROM CNS_CODE)
ORDER BY 1,2