--평균 일일 대여 요금 구하기
SELECT ROUND(AVG(DAILY_FEE)) AS AVERAGE_FEE
FROM CAR_RENTAL_COMPANY_CAR
WHERE CAR_TYPE = 'SUV'

--재구매가 일어난 상품과 회원 리스트 구하기
SELECT USER_ID , PRODUCT_ID
FROM ONLINE_SALE
GROUP BY 1,2
HAVING COUNT(*) > 1
ORDER BY 1,2 DESC

--역순 정렬하기
SELECT NAME,DATETIME 
FROM ANIMAL_INS
ORDER BY ANIMAL_ID DESC

--아픈 동물 찾기
SELECT ANIMAL_ID,NAME 
FROM ANIMAL_INS 
WHERE INTAKE_CONDITION='SICK'

--어린동물찾기
SELECT ANIMAL_ID , NAME 
FROM ANIMAL_INS 
WHERE INTAKE_CONDITION <>'Aged'

--동물의 아이디와 이름
SELECT ANIMAL_ID , NAME 
FROM ANIMAL_INS 
ORDER BY ANIMAL_ID

--여러 기준으로 정렬하기
SELECT ANIMAL_ID , NAME, DATETIME 
FROM ANIMAL_INS  
ORDER BY NAME ,DATETIME DESC

--상위 N개 레코드
SELECT NAME 
FROM (
    SELECT * 
    FROM ANIMAL_INS 
    ORDER BY DATETIME
) 
WHERE ROWNUM =1

--조건에 맞는 회원수 구하기
SELECT COUNT(*) AS USERS
FROM USER_INFO
WHERE JOINED LIKE '2021%'
AND AGE BETWEEN 20 AND 29

--흉부외과 또는 일반외과 의사 목록 출력하기
SELECT DR_NAME,DR_ID,MCDP_CD,DATE_FORMAT(HIRE_YMD,'%Y-%m-%d')
FROM DOCTOR
WHERE MCDP_CD = 'CS' 
OR MCDP_CD = 'GS'
ORDER BY 4 DESC , 1 ASC

--과일로 만든 아이스크림 구하기
WITH flavor_fruit AS(
SELECT FLAVOR
FROM ICECREAM_INFO 
WHERE INGREDIENT_TYPE ='fruit_based'
)

SELECT H.FLAVOR
FROM FIRST_HALF H JOIN flavor_fruit F
USING(FLAVOR)
WHERE H.TOTAL_ORDER >= 3000

--3월에 태어난 여성 회원 목록 출력하기
SELECT MEMBER_ID,	MEMBER_NAME,	GENDER	,DATE_FORMAT(DATE_OF_BIRTH,'%Y-%m-%d') AS DATE_OF_BIRTH
FROM MEMBER_PROFILE
WHERE GENDER = 'W'
AND TLNO IS NOT NULL
AND MONTH(DATE_OF_BIRTH) ='3'
ORDER BY 1

--서울에 위치한 식당 목록 출력하기
SELECT REST_ID , REST_NAME ,FOOD_TYPE , FAVORITES,ADDRESS , ROUND(AVG(REVIEW_SCORE),2) AS SCORE
FROM REST_INFO I JOIN REST_REVIEW R
USING(REST_ID)
WHERE ADDRESS LIKE '서울%'
GROUP BY REST_ID
ORDER BY 6 DESC , 4 DESC

--조건에 부합하는 중고거래 댓글 조회하기
SELECT 
B.TITLE , 
B.BOARD_ID , 
REPLY_ID ,
U.WRITER_ID ,
U.CONTENTS,
DATE_FORMAT(U.CREATED_DATE,'%Y-%m-%d') AS CREATED_DATE
FROM USED_GOODS_BOARD B JOIN USED_GOODS_REPLY U
USING(BOARD_ID)
WHERE B.CREATED_DATE LIKE "2022-10%"
ORDER BY 6 , 1

--인기있는 아이스크림
SELECT FLAVOR
FROM FIRST_HALF 
ORDER BY TOTAL_ORDER DESC , SHIPMENT_ID

--강원도에 위치한 생산공장 목록 출력하기
SELECT 
FACTORY_ID,	
FACTORY_NAME,	
ADDRESS
FROM FOOD_FACTORY 
WHERE ADDRESS LIKE '강원도%'
ORDER BY  1

--12세 이하인 여자 환자 목록 출력하기
SELECT PT_NAME,
PT_NO,
GEND_CD,
AGE,
IFNULL(TLNO,'NONE') AS TLNO
FROM PATIENT 
WHERE GEND_CD = 'W'
AND AGE <= 12
ORDER BY 4 DESC , 1

--조건에 맞는 도서 리스트 출력하기
SELECT BOOK_ID,
DATE_FORMAT(PUBLISHED_DATE,'%Y-%m-%d') AS PUBLISHED_DATE
FROM BOOK
WHERE CATEGORY ='인문'
AND PUBLISHED_DATE LIKE '2021%'
ORDER BY 2

--Python 개발자 찾기
SELECT ID,	EMAIL,	FIRST_NAME,	LAST_NAME
FROM DEVELOPER_INFOS 
WHERE SKILL_1 = 'Python'
OR SKILL_2 ='Python'
OR SKILL_3 ='Python'
ORDER BY 1

--업그레이드 된 아이템 구매하기
WITH RESULT AS(SELECT ITEM_ID
FROM ITEM_TREE 
WHERE PARENT_ITEM_ID IN (SELECT ITEM_ID
FROM ITEM_INFO
WHERE RARITY = 'RARE')
               )
SELECT ITEM_ID	,ITEM_NAME	,RARITY
FROM ITEM_INFO 
WHERE ITEM_ID IN (SELECT * FROM RESULT)
ORDER BY 1 DESC 

--조건에 맞는 개발자 찾기
SELECT ID, EMAIL, FIRST_NAME, LAST_NAME 
FROM DEVELOPERS
WHERE SKILL_CODE & (SELECT CODE FROM SKILLCODES WHERE NAME = 'Python')
    OR SKILL_CODE & (SELECT CODE FROM SKILLCODES WHERE NAME = 'C#')
ORDER BY ID;

--잔챙이 잡은 수 구하기
SELECT COUNT(*) AS FISH_COUNT
FROM FISH_INFO 
WHERE LENGTH IS NULL

--가장 큰 물고기 10마리 구하기
SELECT ID, LENGTH
FROM FISH_INFO
WHERE LENGTH IS NOT NULL
ORDER BY 2 DESC, 1
LIMIT 10

--특정 물고기 잡은 총 수 구하기
SELECT COUNT(*) AS FISH_COUNT
FROM FISH_INFO
WHERE FISH_TYPE IN (
    SELECT FISH_TYPE
    FROM FISH_NAME_INFO
    WHERE FISH_NAME = 'BASS'
    OR FISH_NAME ='SNAPPER'
    )

--특정 형질을 가지는 대장균 찾기
SELECT COUNT(*) AS COUNT
FROM ECOLI_DATA 
WHERE GENOTYPE&2 = 0 
AND (GENOTYPE&1 !=0 OR GENOTYPE&4 != 0)

--부모의 형질을 모두 가지는 대장균 찾기
SELECT C.ID,	C.GENOTYPE,	P.GENOTYPE AS PARENT_GENOTYPE
FROM ECOLI_DATA C JOIN ECOLI_DATA P
ON C.PARENT_ID = P.ID
WHERE C.GENOTYPE & P.GENOTYPE = P.GENOTYPE
ORDER BY 1

--대장균들의 자식의 수 구하기
SELECT P.ID , COUNT(C.ID) AS CHILD_COUNT
FROM ECOLI_DATA P LEFT JOIN ECOLI_DATA C
ON P.ID = C.PARENT_ID
GROUP BY P.ID
ORDER BY 1

--대장균의 크기에 따라 분류하기 1
SELECT ID,
CASE
    WHEN SIZE_OF_COLONY <= 100 THEN 'LOW'
    WHEN SIZE_OF_COLONY >100 AND SIZE_OF_COLONY <= 1000 THEN 'MEDIUM'
    ELSE 'HIGH'
    END AS SIZE
FROM ECOLI_DATA

--대장균의 크기에 따라 분류하기 2
WITH ECOLI_PERCENT AS (
SELECT *,PERCENT_RANK() OVER(ORDER BY SIZE_OF_COLONY DESC) AS PERCENT
FROM ECOLI_DATA
)

SELECT ID , 
CASE 
    WHEN PERCENT <= 0.25 THEN 'CRITICAL'
    WHEN PERCENT <= 0.5 THEN 'HIGH'
    WHEN PERCENT <= 0.75 THEN 'MEDIUM'
    ELSE 'LOW'
    END AS COLONY_NAME
FROM ECOLI_PERCENT
ORDER BY 1

--특정 세대의 대장균 찾기
WITH PARENT AS (
    SELECT  P.ID AS P_ID
    FROM ECOLI_DATA G JOIN ECOLI_DATA P
    ON G.ID = P.PARENT_ID
    WHERE G.PARENT_ID IS NULL
)

SELECT ID
FROM ECOLI_DATA C JOIN PARENT P
ON C.PARENT_ID = P.P_ID
ORDER BY 1

--오프라인/온라인 판매 데이터 통합하기
WITH RESULT AS (
SELECT DATE_FORMAT(SALES_DATE,'%Y-%m-%d') AS SALES_DATE, PRODUCT_ID , USER_ID , SALES_AMOUNT
FROM ONLINE_SALE 
WHERE SALES_DATE LIKE '2022-03%'
UNION
SELECT DATE_FORMAT(SALES_DATE,'%Y-%m-%d') AS SALES_DATE, PRODUCT_ID , NULL AS USER_ID, SALES_AMOUNT
FROM OFFLINE_SALE
WHERE SALES_DATE LIKE '2022-03%')

SELECT * 
FROM RESULT
ORDER BY SALES_DATE,PRODUCT_ID,USER_ID

--멸종위기 대장균 찾기
WITH RECURSIVE ECOLI_DATA_HIERARCHY AS (
    -- 초기 쿼리 : 최상위 대장균 정보
    SELECT ID, PARENT_ID, 1 AS GENERATION
    FROM  ECOLI_DATA
    WHERE PARENT_ID IS NULL
    
    UNION ALL
    
    -- 재귀 부분 : 하위 대장균 정보입니다.
    SELECT ED.ID, ED.PARENT_ID, EDH.GENERATION + 1
    FROM ECOLI_DATA AS ED
    INNER JOIN ECOLI_DATA_HIERARCHY EDH ON EDH.ID = ED.PARENT_ID
)

SELECT COUNT(*) AS COUNT, GENERATION AS GENERATION
FROM ECOLI_DATA_HIERARCHY AS EDH
LEFT OUTER JOIN ECOLI_DATA ED
ON EDH.ID = ED.PARENT_ID
WHERE ED.ID IS NULL
GROUP BY GENERATION
ORDER BY GENERATION ASC