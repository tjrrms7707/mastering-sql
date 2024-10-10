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

