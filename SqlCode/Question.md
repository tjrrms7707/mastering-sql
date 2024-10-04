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
