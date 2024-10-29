# 문제필이 오답노트

## leetcode 

### 집계함수처리
집계함수 처리시 not in 조건에 포함을 못시키나?
196. delete Duplicate emails
```
DELETE FROM Person
WHERE id NOT IN (
    SELECT sub.id
    FROM (
        SELECT MIN(id) as id , email
        FROM Person
        GROUP BY email
    ) sub)
```
### 607번
서브쿼리를 이용하는 것 보다 조인하는 것이 처리속도가 더 빠르나?


--IN 연산자의 CTE
WTIH sub_a AS(
...
)

1.잘못된 CTE의 사용
SELECT *
FROM TABLE_A
WHERE col A IN(suba)

2.옳바른 사용 방법
SELECT *
FROM TABLE_A
WHERE col A IN(SELECT col1 FROM sub_a)

## IN , NOT IN 안에 NULL이 포함되어 있을때
https://velog.io/@park2348190/SQL-IN-%EC%BF%BC%EB%A6%AC%EC%97%90%EC%84%9C-Null-%EA%B0%92%EC%9D%98-%EC%98%81%ED%96%A5

## CONCAT 컬럼을 숫자로 정렬할때
SELECT CONCAT(COL1 ,"단위(M,CM)..")
FROM TABLE
ORDER BY 1

제대로 정렬 되지 않는다.
ORDER BY COL1 이 되어야 한다.