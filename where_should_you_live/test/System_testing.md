# System Testing

### 1. **Sign Up:**

**● Equivalence Class Partitioning:**

| Equivalence Class | User Name | Password | Confirm Password | Expected Output |
| --- | --- | --- | --- | --- |
| E1 | Valid | Valid | Valid | Redirect to Preference Page |
| E2 | Valid | Valid | Invalid | Invalid |
| E3 | Valid | Invalid | Valid | Invalid |
| E4 | Valid | Invalid | Invalid | Invalid |
| E5 | Invalid | Valid | Valid | Invalid |
| E6 | Invalid | Valid | Invalid | Invalid |
| E7 | Invalid | Invalid | Valid | Invalid |
| E8 | Invalid | Invalid | Invalid | Invalid |

| Invalid Input Field | Showing Error |
| --- | --- |
| Username | Please enter user name, user name is invalid |
| Password | Please Select The Password Field If Password is Less than 8 Character then show error that Please enter at least 8 character password. |
| Confirm Password | Please re-enter your password if Confirm password is not matching with password, Confirm Password is not matching |

● Test Cases :

| Test Case | User Name | Password | Confirm Password | Expected Output |
| --- | --- | --- | --- | --- |
| 1 | estuser1@gmail.com | User12345 | User12345 | Redirect to Preference Page |
| 2 | abc@gmail.com | 123@4567 | 123@4567 | Redirect to Preference Page |
| 3 | param@gmail.com | par@12err | par@12err | Redirect to Preference Page |
| 4 | fenil492@gmail.com | 12367@pra | 12367@pra | Redirect to Preference Page |
| 5 | testusr@yaho.com | par453fg | par453fg | Invalid Username |
| 6 | sahilyahoo.com | sahil%3231 | sahil%3231 | Invalid Username |
| 7 | tirthmail.com | tnp$rwegtv | tnp$rwegtv | Invalid Username |
| 8 | abcyaho.com | fgtqr1234 | fgtqr1234 | Invalid Username |
| 9 | Neha@gmail.com | neha&214 | neha&214 | Invalid Username |
| 10 | empty | empty | empty | User Field, Password Field and confirm Password Field are empty. |
| 11 | fter@gmail.com | empty | empty | Password Field is empty |
| 12 | xyz@gmail.com | empty | ghkr#231 | Password Field is empty |
| 13 | Yukta34@gmail.com | Yutsrt#1111 | empty | Confirm Password Field is empty |
| 14 | empty | htre@985421 | empty | username and confirm password field are empty |
| 15 | empty | Dpte%we#130 | Dpte%we#130 | Username Field is empty |
| 16 | ajayaho.com | aj@23456 | aj@23456 | Invalid Username(Doesn’t include @) |
| 17 | aajax.com | 123456789 | 123456789 | Invalid Username(Doesn’t include @) |
| 18 | amitgmail.com | amit@123 | amit@123 | Invalid Username(Doesn’t include @) |
| 19 | bakul44gmail.com | baku@13456 | baku@13456 | Invalid Username(Doesn’t include @) |
| 20 | ami ray@gmail.com | ami&2952 | ami&2952 | Invalid Username(shouldn’t include space(' ')) |
| 21 | Anil @gmail.com | anilef53e2 | anilef53e2 | Invalid Username(shouldn’t include space(' ')) |
| 22 | Gagan34@gmail.com | gagan88880 | gagan88880 | Invalid Username(shouldn’t include space(' ')) |
| 23 | tina@gmail.com | tina@wq%130 | tina@wq%130 | Invalid Username(shouldn’t include space(' ')) |
| 24 | tina@gmail.com | tina@1 | tina@1 | Password Length < 8 |
| 25 | tina@gmail.com | tina@ | tina@ | Password Length < 8 |
| 26 | tina@gmail.com | tina@12 | tina@12 | Password Length < 8 |
| 27 | mina@gmail.com | mina@12 | mina@12 | Password Length < 8 |
| 28 | tinamailto:neha@gmail.com | tin | tin | Password Length < 8 |
| 29 | yash@gmail.com | yash@1345 | yash @1345 | Confirm Password is not matching |
| 30 | yash@gmail.com | yash@1345 | Yash@1345 | Confirm Password is not matching |
| 31 | yash@gmail.com | yash@1345 | Yash@1325 | Confirm Password is not matching |
| 32 | yash@gmail.com | yash@1345 | yash@!345 | Confirm Password is not matching |
| 33 | yash@gmail.com | yash@1345 | yash12345 | Confirm Password is not matching |
| 34 | yash@gmail.com | yash@1345 | yash%1345 | Confirm Password is not matching |
| 35 | yash@gmail.com | yash@1345 | yash*1345 | Confirm Password is not matching |
| 36 | Aman | Amanaa333 | Amanaa333 | Invalid Username |
| 37 | Kartik | Kartik52121 | Kartik52121 | Invalid Username |
| 38 | Anish | anish&Yerg1 | anish&Yerg1 | Invalid Username |
| 39 | Priyanka | priya!#2679 | priya!#2679 | Invalid Username |
| 40 | Tilak43@gmail.com | Tilak#4213 | Tilak #4213 | Confirm Password is not matching |



### 2. Log In:

**● Equivalence Class Partitioning:**

| Equivalence Class | Email | Password | Expected Output |
| --- | --- | --- | --- |
| E1 | Valid | Valid | Redirect To Home Page |
| E2 | Valid | Invalid | Invalid |
| E3 | Invalid | Valid | Invalid |
| E4 | Invalid | Invalid | Invalid |

| Invalid Input Field | Showing Error |
| --- | --- |
| Email Address | Please enter user name, user name is invalid |
| Password | Please Select The Password Field If Password is Less than 8 Character then show error that Please enter at least 8 character password. |

● Test Cases :

| Test Case | User Name | Password | Expected Output |
| --- | --- | --- | --- |
| 1 | estuser1@gmail.com | User12345 | Redirect to Home Page |
| 2 | abc@gmail.com | 123@4567 | Redirect to Home Page |
| 3 | param@gmail.com | par@12err | Redirect to Home Page |
| 4 | fenil492@gmail.com | 12367@pra | Redirect to Home Page |
| 5 | testusr@yaho.com | par453fg | Invalid Username |
| 6 | sahilyahoo.com | sahil%3231 | Invalid Username |
| 7 | tirthmail.com | tnp$rwegtv | Invalid Username |
| 8 | abcyaho.com | fgtqr1234 | Invalid Username |
| 9 | Neha@gmail.com | neha&214 | Invalid Username |
| 10 | empty | empty | User Field, Password Field and confirm Password Field are empty. |
| 11 | fter@gmail.com | empty | Password Field is empty |
| 12 | xyz@gmail.com | empty | Password Field is empty |
| 13 | empty | htre@985421 | username and confirm password field are empty |
| 14 | empty | Dpte%we#130 | Username Field is empty |
| 15 | ajayaho.com | aj@23456 | Invalid Username(Doesn’t include @) |
| 16 | aajax.com | 123456789 | Invalid Username(Doesn’t include @) |
| 17 | amitgmail.com/ | amit@123 | Invalid Username(Doesn’t include @) |
| 18 | bakul44gmail.com | baku@13456 | Invalid Username(Doesn’t include @) |
| 19 | ami ray@gmail.com | ami&2952 | Invalid Username(shouldn’t include space(' ')) |
| 20 | Anil @gmail.com | anilef53e2 | Invalid Username(shouldn’t include space(' ')) |
| 21 | Gagan34@gmail.com | gagan88880 | Invalid Username(shouldn’t include space(' ')) |
| 22 | tina @gmail.com | tina@wq%130 | Invalid Username(shouldn’t include space(' ')) |
| 23 | tina@gmail.com | tina@1 | Password Length < 8 |
| 24 | tina@gmail.com | tina@ | Password Length < 8 |
| 25 | tina@gmail.com | tina@12 | Password Length < 8 |
| 26 | mina@gmail.com | mina@12 | Password Length < 8 |
| 27 | tina@gmail.com | tin | Password Length < 8 |
| 28 | Aman | Amanaa333 | Invalid Username |
| 29 | Kartik | Kartik52121 | Invalid Username |
| 30 | Anish | anish&Yerg1 | Invalid Username |
| 31 | Priyanka | priya!#2679 | Invalid Username |
| 32 | Tilak43@gmail.com | Tilak#4213 | Not Registered user |
| 33 | Nimesh61@gmail.com | Nimesh^124 | Not Registered user |
| 34 | Mahesh111@gmail.com | Mahi%212123 | Not Registered user |
| 35 | Prakash932@gmail.com | prak@54322 | Not Registered user |
