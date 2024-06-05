package com.c206.backend.domain.plogging.exception;

import lombok.Getter;

@Getter
public class PloggingException extends RuntimeException {
    private final PloggingError errorCode;
    private final int status;
    private final String errorMessage;

    public PloggingException(PloggingError errorCode) {
        super(errorCode.getErrorMessage());
        this.errorCode = errorCode;
        this.status = errorCode.getHttpStatus().value();
        this.errorMessage = errorCode.getErrorMessage();
    }
}
