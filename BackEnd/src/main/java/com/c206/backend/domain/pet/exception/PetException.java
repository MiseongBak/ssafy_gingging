package com.c206.backend.domain.pet.exception;

import lombok.Getter;

@Getter
public class PetException extends RuntimeException {
    private final PetError errorCode;
    private final int status;
    private final String errorMessage;

    public PetException(PetError errorCode) {
        super(errorCode.getErrorMessage());
        this.errorCode = errorCode;
        this.status = errorCode.getHttpStatus().value();
        this.errorMessage = errorCode.getErrorMessage();
    }
}
