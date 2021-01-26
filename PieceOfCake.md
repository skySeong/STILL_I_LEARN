# 객체 참조 시 메모리 할당

##Retain, Strong, weak, assign 차이
- nonatomic : 멀티스레드 환경에서 하나의 프로퍼티에 여럿이 접근할 수 없음
- atomic : 멀티스레드 환경에서 하나의 프로퍼티에 여럿이 접근할 수 있음
- retain : 참조변수 (reference count + 1)
- assign : 일반변수 (count 변경이 되지 않음)
- copy : 참조변수 (count + 1) - [NSString, Arrary]
- Readonly : getter만 생성
- ReadWrite : Default, setter, getter
- Weak : UI 단에 영향

## Q. 왜 primitive type int type은 ARC strong, retain type 선언이 안될까?
### A. heap과 stack 의 메모리 할당 영역이 다름.
int, float, double...과 같은 자료 원시형 타입은 메모리 할당 타입이 필요가 없다.
property 선언 시 strong type으로 선언할 경우 error 발생.
원시형 타입은 스택영역의 메모리를 참조는데, 스택 영역은 기본 타입이 assign이기 때문에 strong type을 선언하게 되면 메모리 할당영역이 달라 에러가 난다.
(굳이 type을 선언할 필요가 없다)

* 메모리 참조(스택과 힙)
	- 메모리 참조 위험성을 고려하여 선언한다.
	- 내가 메모리를 해제할 시점이 보장되는가?
	-  Assign : ex) int, float, double (primitive)
	-  weak : ex) Object, reference count ++


# 클래스와 객체
### 클래스 :  객체지향 프로그램의 기본 사용자 정의 자료형(Data type)
### 객체 : 클래스의 인스턴스 (실제 메모리에 할당된 상태)
	- 클래스 인스턴스 
	- 객체 == 클래스의 인스턴스
	-  객체 != 인스턴스

	