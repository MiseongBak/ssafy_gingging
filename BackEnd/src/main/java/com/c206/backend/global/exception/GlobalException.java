package com.c206.backend.global.exception;

import lombok.Getter;

/**
 * 애플리케이션 전역에서 발생하는 예외를 처리하기 위한 커스텀 예외 클래스입니다.
 * {@link GlobalError} 열거형을 사용하여 특정 에러 상황을 명확하게 정의하고 관리합니다.
 */
@Getter
public class GlobalException extends RuntimeException {
    private final GlobalError errorCode; // 발생한 에러의 코드
    private final int status; // HTTP 상태 코드
    private final String errorMessage; // 에러 메시지

    /**
     * GlobalError를 매개변수로 받아 예외 객체를 생성합니다.
     *
     * @param errorCode 발생한 에러를 나타내는 {@link GlobalError} 열거형
     */
    public GlobalException(GlobalError errorCode) {
        super(errorCode.getErrorMessage()); // 부모 클래스의 생성자를 호출하여 에러 메시지를 초기화
        this.errorCode = errorCode; // 에러 코드 초기화
        this.status = errorCode.getHttpStatus().value(); // HTTP 상태 코드를 추출하여 초기화
        this.errorMessage = errorCode.getErrorMessage(); // 에러 메시지 초기화
    }
}
