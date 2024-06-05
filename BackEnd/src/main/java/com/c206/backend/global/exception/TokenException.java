package com.c206.backend.global.exception;

import lombok.Getter;

/**
 * 토큰 관련 에러를 위한 커스텀 예외 클래스입니다.
 * 이 예외는 토큰 처리와 관련된 문제가 있을 때 발생합니다.
 * 예를 들면, 유효하지 않거나 만료된 토큰 등이 있습니다.
 */
@Getter
public class TokenException extends RuntimeException {
    private final GlobalError errorCode;
    private final int status;
    private final String errorMessage;

    /**
     * GlobalError만을 가지고 TokenException을 생성하는 생성자입니다.
     * 제공된 에러 코드를 기반으로 예외 세부 사항을 초기화합니다.
     *
     * @param errorCode 특정 에러 세부 정보를 나타내는 GlobalError 열거형
     */
    public TokenException(GlobalError errorCode) {
        super(errorCode.getErrorMessage());
        this.errorCode = errorCode;
        this.status = errorCode.getHttpStatus().value();
        this.errorMessage = errorCode.getErrorMessage();
    }
}
