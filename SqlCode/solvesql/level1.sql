--모든 데이터 조회하기
SELECT *
FROM points

--일부 데이터 조회하기
SELECT
*
FROM points
WHERE quartet = 'I'

--데이터 정렬하기
SELECT *
FROM points
WHERE quartet ='I'
ORDER BY y

--
points 테이블에 쿼리를 수행해 quartet으로 구분되는 
각 서브셋 데이터에 대해서 아래 통계량을 계산하는 쿼리를 작성해주세요. 
계산된 값은 소수점 아래 셋째 자리에서 반올림 해야 합니다. 
결과 데이터에는 아래 5개의 컬럼이 존재 해야 합니다.

quartet - 콰르텟
x_mean - x 평균
x_var - x 표본 분산
y_mean - y 평균
y_var - y 표본 분산

힌트
이 문제에서 구해야 하는 분산은 모분산이 아니라 표본 분산입니다. DBMS에 따라 표본 분산을 구하는 함수가 다를 수 있으니 유의해주세요.
SELECT quartet ,
ROUND(AVG(x),2) AS x_mean ,
ROUND(VAR_SAMP(x),2) AS x_var,
ROUND(AVG(y),2) AS y_mean,
ROUND(VAR_SAMP(y),2) AS y_var
FROM points
GROUP BY quartet