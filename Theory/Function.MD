# 집계함수
## count
- Null 값이 아닌 레코드 수를 구한다.
- 함수안에서 DISTINCT도 사용 가능하다.
- 그룹안에서 특정 데이터만 세고 싶다면 CASE문을 이용한다.
```
COUNT(CASE WHEN column = 'data' THEN 1 END)
```
## SUM
- 필드명의 합계를 구한다. 
## AVG
- 각각의 그룹안에서 필드명의 평균값을 구한다.
## MAX
- 최대값을 구한다.
## MIN
- 최소값을 구한다.
## STDDEV
- 표준 편차를 출력한다.
## VARIAN
- 표현식의 분산을 출력한다.

# 숫자 관련 함수들
## ABS
- 숫자에 절대값을 가져오는 함수
```
ABS(숫자)
```
## Round
- 정해진 자리숫에 따라 반올림을 역활을 하는 함수
```
ROUND(숫자(컬럼), (반올림 기준))
SELECT ROUND(10.349)    -- 10
SELECT ROUND(10.349, 1) -- 10.3
SELECT ROUND(10.349, 2) -- 10.35
# 반올림 기준이 음수일때는 자연수(왼쪽)이 기준이 된다.
```
## TRUNCATE
-- 소수점 이하 자릿수를 남기고 버리는 함수
```
TRUNCATE(숫자, 자릿수)
SELECT TRUNCATE(10.349)    -- 10
SELECT TRUNCATE(10.349, 1) -- 10.3
SELECT TRUNCATE(10.349, 2) -- 10.34
```
## CEILING
- 소수점 이하를 무조건 올리는 함수

```
CEILING(숫자)
SELECT CEILING(21.35) -- 22
SELECT CEILING(21.9) -- 22
```
## FLOOR
- 소수점 이하를 무조건 버리는 함수
```
FLOOR(숫자)
SELECT CEILING(21.35) -- 21
SELECT CEILING(21.9) -- 21
```
## POW (제곱)
- 숫자의 n승을 가져오는 함수
```
POW(숫자, n)
```
## sqrt (제곱근)
```
sqrt(n)
```
## MOD (나머지)
- 분자를 분모로 나눈 나머지를 가져오는 함수 (% 연산자와 동일)
```
MOD(분자, 분모)
```
## GREATEST
- 주어진 수 중 제일 큰 수를 가져오는 함수
```
GREATEST(숫자1, 숫자2, 숫자3 ...)
```
## LEAST
- 주어진 수 중 제일 작은 수를 가져오는 함수
```
LEAST(숫자1, 숫자2, 숫자3 ...)
```
## 진수
- bin( ) : 2진수
- hex( ) : 16진수
- oct( ) : 8진수
## 삼각함수
- SIN( ) 
- COS( ) 
- TAN( )

# 문자열 관련 함수

## CONCAT
- 문자열 합치기 
```
concat("a","b","c")
```
## repeat
- 문자열 반복 
```
repeat('반복',3)
```
### reverse
- 문자열 뒤집기
```
reverse('mysql')
```
## LOCATE
- 문자열 위치
```
LOCATE('abc','ababcedefabc') //3
LOCATE('abc','ababcedefabc',4) //10
```
## 부분 문자열 함수
- LEFT : 문자열의 왼쪽을 기준으로 n개의 문자를 가져오는 함수
    - LEFT(컬럼명, n)
- MID : 문자열에서 지정한 시작 위치를 기준으로 n개의 문자를 가져오는 함수 (= SUBSTR, SUBSTRING)
    - MID(컬럼명, 시작 위치, n)
    - SUBSTR(컬럼명, 시작 위치, n)
    - SUBSTRING(컬럼명, 시작 위치, N)
- RIGHT : 문자열의 오른쪽을 기준으로 n개의 문자를 가져오는 함수
    - RIGHT(컬럼명, n)
## replace
- 문자열 교체
```
replace('MSSQL',''MS','MY')
```
## 문자열 공백 없애기
```
TRIM('     Mysql     ') -- 문자열 공백 다 없애줘
TRIM(leading '!' FROM '!!!!!!!!!!!!!!!!MySQL PHP###') -- 문자열 앞에 '!' 다 없애줘 -> MySQL PHP###
TRIM(trailing '@' from '%%%MYSQL@@@@@@@@');  -- 문자열 뒤쪽 @ 업애줘 -> %%%MYSQL

ltrim('     이것이') : 왼쪽 공백 제거
rtrim('이것이     ') : 오른쪽 공백 제거
```
## format
- 문자열 포맷
```
select format(123123123123123,3)
->123,123,123,123,123,..
```

# GROUP_CONCAT

## 1) 사용법
```
SELECT team as '팀', GROUP_CONCAT(member1) as '같은팀'
FROM department1
GROUP BY team;
```
## 2)구분자 변경하기
SEPARETOR로 원하는 구분자를 사용해주면 된다.
```
SELECT team as '팀', GROUP_CONCAT(member1 SEPARETOR '-') as '같은팀'
FROM department1
GROUP BY team;
```
## 3)DISTINCT 사용
중복되는 문자열 있다면 컬럼앞에 DISTINCT를 사용한다.
## 4)ORDER BY 사용
문자열 정렬이 필요할떄는 ORDER BY를 사용하여 정렬한다.
## 5) 중복제거, 문자열 정렬, 구분자 변경을 함께 사용시 순서
DISTINCT > ORDER BY > SEPERATOR
```
SELECT team as '팀', GROUP_CONCAT(DISTINCT member1 ORDER BY member1 SEPARETOR '-') as '같은팀'
FROM department1
GROUP BY team;
```
# DATE 함수
## **현재 날짜와 시간 출력**
**NOW()**
**SYSDATE()**
**CURRENT_TIMESTAMP()** 
## **현재 날짜 출력**
 **CURDATE()** 
**CURRENT_DATE()** **​**
## **현재 시간 출력**
 **CURTIME()**
**CURRENT_TIME()** **​**
## **날짜에서 기준값 만큼 덧셈**
 **DATE_ADD(날짜, INTERVAL 기준값)** 
**※ 기준값 : YEAR, MONTH, DAY, HOUR, MINUTE, SECOND** 
## **날짜에서 기준값 만큼 뺄셈**
 **DATE_SUB(날짜, INTERVAL 기준값)** 
**※ 기준값 : YEAR, MONTH, DAY, HOUR, MINUTE, SECOND** 
## **날짜 포맷**
 **YEAR(날짜) -날짜의 연도 출력.** 
 **MONTH(날짜) -날짜의 월 출력.** 
 **MONTHNAME(날짜) -날짜의 월을 영어로 출력.** 
 **DAYNAME(날짜) -날짜의 요일일 영어로 출력.** 
 **DAYOFMONTH(날짜) -날짜의 월별 일자 출력.** 
 **DAYOFWEEK(날짜) -날짜의 주별 일자 출력(월요일(0),화요일(1)...일요일(6))** 
 **WEEKDAY(날짜) -날짜의 주별 일자 출력(월요일(0),화요일(1)...일요일(6))** 
 **DAYOFYEAR(날짜) -일년을 기준으로 한 날짜까지의 날 수.** 
 **WEEK(날짜) -일년 중 몇 번쨰 주.** **​**
 **FROM_DAYS(날 수) : 00년 00월 00일부터 날 수 만큼 경과한 날의 날짜 출력.** 
 **TO_DAYS(날짜) : 00 년 00 월 00일 부터 날짜까지의 일자 수 출력.** 
 **DATE_FORMAT(날짜,'형식') : 날짜를 형식에 맞게 출력**
# 데이터 타입 변환 함수
##  CAST
```
CAST(expression AS target_type)
```
MySQL에서 CAST() 함수로 변환할 수 있는 주요 데이터 타입은 다음과 같습니다.
1. CHAR: 문자열로 변환합니다.
2. SIGNED: 정수형(음수와 양수를 포함)으로 변환합니다.
3. UNSIGNED: 양수 정수형으로 변환합니다.
4. DATE: 날짜 형식으로 변환합니다.
5. DATETIME: 날짜와 시간 형식으로 변환합니다.
6. DECIMAL: 소수점 숫자로 변환합니다.
7. BINARY: 바이너리 데이터로 변환합니다.
## CAST 사용 시 주의 사항
1. 부적절한 변환: 예를 들어, 문자열 'ABC'를 숫자로 변환하려고 할 경우, MySQL은 변환할 수 없기 때문에 0을 반환합니다.
2. 데이터 타입이 맞지 않으면 오류 발생: CAST()는 입력된 데이터가 해당 형식으로 변환될 수 있는지 검사합니다. 변환할 수 없으면 NULL이나 오류가 발생할 수 있습니다.
## CAST와 CONVERT 차이
MySQL에서 CAST()와 CONVERT()는 거의 동일하게 동작합니다. 하지만 CONVERT()는 구문이 다르며, 추가적으로 문자셋 변환도 가능합니다.
- CAST() 구문: CAST(expression AS target_type)
- CONVERT() 구문: CONVERT(expression, target_type) 또는 문자셋 변환 시 CONVERT(expression USING charset).
# JOIN
![](https://i.imgur.com/76szEjc.png)
## INNER JOIN

## LEFR/RIGHT JOIN

## OUTER JOIN

# WITH
- MySQL에서 'WITH'절은 서브쿼리를 만들고 재사용 가능한 공통 테이블 표현식(Common Table Expression, CTE)을 정의하는 방법입니다. 
- WITH절을 사용하여 쿼리를 단순화하고 가독성을 높일 수 있습니다.
```
WITH [cte_name] AS (
	SELECT [column_name(s)] 
	FROM [table_name] 
	WHERE [condition] 
) 

SELECT [column_name(s)] 
FROM [table_name] JOIN [cte_name] 
ON [join_condition] WHERE [condition];
```
- 위 구문에서 cte_name은 임의의 이름으로, 서브쿼리에서 반환된 결과를 참조할 수 있는 임시 테이블의 이름입니다.  
  서브쿼리 내에서 SELECT문을 사용하여 데이터를 검색하고, 해당 결과 집합을 cte_name으로 정의한 CTE에 저장합니다.
  그런 다음 CTE를 메인 쿼리에서 참조하여 추가 데이터를 가져올 수 있습니다.
  - 추가로 열의 이름도 지정하고 싶다면 테이블이름 뒤에 (col1,col2,...)으로 지정하면 된다.