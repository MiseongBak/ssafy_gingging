package com.c206.backend.domain.notice.exception;

import lombok.Getter;

@Getter
public class NoticeException extends RuntimeException {
    private final NoticeError errorCode;
    private final int status;
    private final String errorMessage;

    public NoticeException(NoticeError errorCode) {
        super(errorCode.getErrorMessage());
        this.errorCode = errorCode;
        this.status = errorCode.getHttpStatus().value();
        this.errorMessage = errorCode.getErrorMessage();
    }
}
