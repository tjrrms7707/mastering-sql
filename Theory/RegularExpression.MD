Matching
| **.**   | 문자 하나                 | - "..." : 문자 길이가 3 이상인 문자                        |
| ------- | --------------------- | ------------------------------------------------ |
| **\|**  | OR (구분된 문자에 해당하는 문자열) | - "안녕\|하이" : '안녕' 또는 '하이'에 해당하는 문자열을 찾음          |
| **[ ]** | 안에 나열된 패턴에 해당하는 문자열   | - "[abc]1" : 문자열에서 'a1' 또는 'b1' 또는 'c1'인 문자열을 찾음 |
| **^**   | 시작하는 문자열              | - "^안녕" : 문자열에서 '안녕'으로 시작하는 문자열을 찾음              |
| **$**   | 끝나는 문자열               | - "잘가$" : 문자열에서 '잘가'로 끝나는 문자열을 찾음                |

Number Limit
| *****      | 0회 이상 나타나는 문자       | - "s*" : 's'가 0번 이상 나타나는 문자열을 찾음                  |
| ---------- | ------------------- | ------------------------------------------------- |
| **+**      | 1회 이상 나타나는 문자       | - "가+" : '가'가 1번 이상 나타나는 문자열을 찾음                  |
| **{m, n}** | m회 이상 n회 이하 반복되는 문자 | - "나{1, 2}" : '나'가 1회 이상 2회 이하 반복되는 문자열을 찾음       |
| **?**      | 0~1회 나타나는 문자        | - "[abc]?" : 'a' 또는 'b' 또는 'c'가 0~1회 나타나는 문자열을 찾음 |

Number Limit
| **[A-z]  <br>[:alpha:]  <br>\a** | 알파벳 대문자 또는 소문자인 문자열 | - "[A-z]+" : 문자열에서 알파벳이 1개 이상인 문자열을 찾음 |
| -------------------------------- | ------------------- | -------------------------------------- |
| **[0-9]  <br>[:digit:]  <br>\d** | 숫자인 문자열             | - "^[0-9]+" : 1개 이상의 숫자로 시작하는 문자열을 찾음  |

Not
| **[^문자]** | 괄호 안의 문자를 포함하지 않는 문자열 | - "[^가나다]" : '가' 또는 '나' 또는 '다'를 포함하지 않는 문자열을 찾음 |
| --------- | --------------------- | ----------------------------------------------- |