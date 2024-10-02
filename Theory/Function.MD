# 부분 문자열 함수
- LEFT : 문자열의 왼쪽을 기준으로 n개의 문자를 가져오는 함수
    - LEFT(컬럼명, n)
- MID : 문자열에서 지정한 시작 위치를 기준으로 n개의 문자를 가져오는 함수 (= SUBSTR, SUBSTRING)
    - MID(컬럼명, 시작 위치, n)
    - SUBSTR(컬럼명, 시작 위치, n)
    - SUBSTRING(컬럼명, 시작 위치, N)
- RIGHT : 문자열의 오른쪽을 기준으로 n개의 문자를 가져오는 함수
    - RIGHT(컬럼명, n)

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

SELECT ROUND(10.349) 	-- 10
SELECT ROUND(10.349, 1) -- 10.3
SELECT ROUND(10.349, 2) -- 10.35

# 반올림 기준이 음수일때는 자연수(왼쪽)이 기준이 된다.
```
## TRUNCATE
-- 소수점 이하 자릿수를 남기고 버리는 함수
```
TRUNCATE(숫자, 자릿수)

SELECT TRUNCATE(10.349)    -- 10
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

# 데이터 타입 변환 함수
##  CAST
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
MySQL에서 **CAST()**와 **CONVERT()**는 거의 동일하게 동작합니다. 하지만 **CONVERT()**는 구문이 다르며, 추가적으로 문자셋 변환도 가능합니다.

- CAST() 구문: CAST(expression AS target_type)
- CONVERT() 구문: CONVERT(expression, target_type) 또는 문자셋 변환 시 CONVERT(expression USING charset).

# JOIN 
![](https://i.imgur.com/76szEjc.png)